//
//  AddingTVA.swift
//  TvaCalculator
//
//  Created by Andrei Romanciuc on 23.08.2022.
//

import Foundation
import UIKit

class FirstVatViewController: UIViewController {

    @IBOutlet weak var initialPriceField: UITextField!
    @IBOutlet weak var displayField: UITextField!
    @IBOutlet weak var displayVat: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func calculateButton(_ sender: Any) {
        guard let text = initialPriceField.text else { return }
        guard let number = Double(text) else { return }
        
        let result = String(format: "%.2f", number / 1.19)
        let vat = number - Double(result)!
        let vatResult = String(format: "%.2f", vat)
        displayField.text = "Pret fara TVA este: \(result)"
        displayVat.text = "Tva-ul este: \(vatResult)"
    }
    
}
