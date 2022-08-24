//
//  CalculateVATViewController.swift
//  TvaCalculator
//
//  Created by Andrei Romanciuc on 24.08.2022.
//

import UIKit

class SecondVatViewController: UIViewController {

    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var totalPriceField: UITextField!
    @IBOutlet weak var vatField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func calculateButton(_ sender: Any) {
        guard let text = priceText.text else { return }
        
        let price = Double(text)
        let total = price! * 1.19
        let vatVal = price! * 0.19
        
        totalPriceField.text = "Pretul total este: \(total)"
        vatField.text = "Tva-ul este: \(vatVal)"
    }
    

}
