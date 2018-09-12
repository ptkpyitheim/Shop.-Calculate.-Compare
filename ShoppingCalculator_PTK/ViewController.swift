//
//  ViewController.swift
//  ShoppingCalculator_PTK
//
//  Created by Pyi Theim Kyaw on 9/7/18.
//  Copyright © 2018 Pyi Theim Kyaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var salesTax: UITextField!
    @IBOutlet weak var displayFinalPrice: UILabel!
    @IBOutlet weak var textField1: UITextView!
    @IBOutlet weak var textField2: UITextView!
    @IBOutlet weak var textFieldFPrice1: UITextView!
    @IBOutlet weak var textFieldFPrice2: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnToHide()
        self.originalPrice.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func clearBtn(_ sender: Any) {
        textField1.text = " "
        textField2.text = " "
        textFieldFPrice1.text = " "
        textFieldFPrice2.text = " "
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let printingString = "Original Price: $ \(originalPrice.text!)\n\nDiscount: \(discount.text!) %\n\nSales Tax: \(salesTax.text!) %"
        if(textField1.text == " ") {
            textField1.text = printingString
            textFieldFPrice1.text = "Final Price #1: \(displayFinalPrice.text!)"
        }
        else {
            textField2.text = printingString
            textFieldFPrice2.text = "Final Price #2: \(displayFinalPrice.text!)"
        }
        
        originalPrice.text = ""
        discount.text = ""
        salesTax.text = ""
        displayFinalPrice.text = ""
    }
    
    @IBAction func showfinalPrice(_sender: AnyObject) {
        //Function for calculating the final price. All exceptions handled.

        let ogPrice = Double(originalPrice.text!)
        let disc = Double(discount.text!)
        let sales = Double(salesTax.text!)
        
        var discountedValue: Double = 0
        var final: Double = 0
        var display: Double = 0
        
        if(ogPrice != nil && disc != nil && sales != nil) {
            discountedValue = Double(ogPrice! * (100-disc!)/100)
            final = Double(discountedValue + (discountedValue * (sales!/100)))
            display = final
        }
        else if (ogPrice != nil && disc != nil && sales == nil) {
            discountedValue = Double(ogPrice! * (100-disc!)/100)
            display = discountedValue
        }
        else if (ogPrice != nil && disc == nil && sales != nil) {
            display = Double(ogPrice! + (ogPrice! * sales!/100))
        }
        else if (ogPrice != nil && disc == nil && sales == nil) {
            display = ogPrice!
        }
        else {
            display = 0
        }
        displayFinalPrice.text = "$\(String(format: "%.2f", display))"
        if (display < 0) {
            print("Something must be wrong with your input. Please try again.")
        }
        
    }
    
    func returnToHide() { //caller function that will hide the keyboard when user taps return button.
        originalPrice.delegate = self
        discount.delegate = self
        salesTax.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //When the user touches the outside of the number pad, the pad with resign
        originalPrice.resignFirstResponder()
        discount.resignFirstResponder()
        salesTax.resignFirstResponder()
    }
    
}



extension ViewController: UITextFieldDelegate {
    //extending the ViewController class so we can use methods from UITextFieldDelegate. Making existing type conform to a protocol
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //To resign the keyboard when user taps return
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //The following function restricts user to only enter numbers and a dot
        let allowedCharactersSet = CharacterSet(charactersIn: ".1234567890")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharactersSet.isSuperset(of: typedCharacterSet)
    }
}


