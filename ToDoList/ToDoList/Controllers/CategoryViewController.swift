//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by Andrei Romanciuc on 26.10.2022.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLists()
    }

    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name

        return cell
    }
    
    
    //MARK: - Data manipulation Methods
    
    func saveList() {

        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }

        tableView.reloadData()
    }
    
    
    func loadLists(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
           categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }

        tableView.reloadData()
    }

    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New List", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add list", style: .default) { (action) in

        let category = Category(context: self.context)

            if let text = textField.text {
                category.name = text
                self.categoryArray.append(category)
            }

            self.saveList()
        }

        alert.addTextField {(alertTextField) in
            alertTextField.placeholder = "Add new list"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true)
    }
}

