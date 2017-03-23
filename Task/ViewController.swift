//
//  ViewController.swift
//  Task
//
//  Created by mohamed hassan on 3/2/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {

    // outlets for textboxes and buttons on the UI
    @IBOutlet weak var widthTxt: UITextField!
    @IBOutlet weak var heightTxt: UITextField!
    @IBOutlet weak var clacBuutonOutlet: UIButton!
    @IBOutlet weak var clearButtonOutlet: UIButton!
  
    
    // Global variables : width , height and number of squares(boxes , 1 km width * i km height) for the land that will be calculated for its coast length
    var width : Int = 0
    var height : Int = 0
    var numberOfAllSquares : Int = 0
    
    
    // order the boxes of the land to a multidimention array take hight and width (rows and columns)
    var arr = Array(repeating: Array(repeating: 0, count: 1), count: 1)
    
    
    // counters will be used to loop in the global arr
    var rowCounter : Int = 0
    var columnwCounter : Int = 0
    
    
    // final value for the coast length
    var coastLength : Int = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.heightTxt.delegate = self
//        self.widthTxt.delegate = self
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    // clear button function will erase all data like height and width
    @IBAction func clearAction(_ sender: AnyObject) {
        
        self.dismissKeyboard()
        self.width = 0
        self.height = 0
        self.numberOfAllSquares = 0
        
        
        self.arr = Array(repeating: Array(repeating: 0, count: 1), count: 1)
        
        
        self.rowCounter = 0
        self.columnwCounter = 0
        
        
        self.coastLength = 0
    
        
        self.widthTxt.text = ""
        self.heightTxt.text = ""
        
        
        
        
    }
    
    
    // calculation button is our entry point for calculate the coast length
    @IBAction func calcAction(_ sender: UIButton) {
        
        if (checkUserInputs() == false) {
            let alert = UIAlertController(title: "Alert", message: "Please Enter valid numbers", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.dismissKeyboard()
        
        // recieve values from user
        self.width = Int(widthTxt.text!)!   // no of columns
        self.height = Int(heightTxt.text!)! // no of rows
        
        
        // width * height = number of all boxes
        self.numberOfAllSquares = self.width * self.height
        print(self.numberOfAllSquares)


    
        // show message view number of all boxes and start to take values for this boxes 1 for land and 0 for water
        let alert = UIAlertController(title: "Alert", message: "Number of boxes you enterd are \(self.numberOfAllSquares) , Please now tap to add values for land and water", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Add values for land and water", style: UIAlertActionStyle.default, handler: { action in
            
            // do something like...
            self.arr = Array(repeating: Array(repeating: 0, count: self.width), count: self.height)
            self.showMessage()
            
        }))

        self.present(alert, animated: true, completion: nil)
        
        
       
    }
    

    
    func checkUserInputs() -> Bool {
        
        
        
        if (widthTxt.text!.isEmpty || heightTxt.text!.isEmpty) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text!.characters.contains("٠") || heightTxt.text!.characters.contains("٠")) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text!.characters.contains("١") || heightTxt.text!.characters.contains("١")) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text!.characters.contains("٢") || heightTxt.text!.characters.contains("٢")) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text!.characters.contains("٣") || heightTxt.text!.characters.contains("٣")) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text!.characters.contains("٤") || heightTxt.text!.characters.contains("٤")) {
            return false
        }
        
        else if (widthTxt.text!.characters.contains("٥") || heightTxt.text!.characters.contains("٥")) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text!.characters.contains("٦") || heightTxt.text!.characters.contains("٦")) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text!.characters.contains("٧") || heightTxt.text!.characters.contains("٧")) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text!.characters.contains("٨") || heightTxt.text!.characters.contains("٨")) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text!.characters.contains("٩") || heightTxt.text!.characters.contains("٩")) {
            clearAction(self)
            return false
        }
        
        else if (widthTxt.text! == "0" || heightTxt.text!  == "0") {
            clearAction(self)
            return false
        }
        
        else {}
        return true
    }
    
    func showMessage() {
        
        // loop or review the message to the user till fill the array with the values
        if self.columnwCounter == self.width {
            
            self.columnwCounter = 0
            self.rowCounter+=1
            
        }
        if self.rowCounter == self.height {
            print("Gloabal Array is \(self.arr)")
            
            
            // clear counters
            self.columnwCounter = 0
            self.rowCounter = 0
            self.RealAction()
            return
        }
        
        
        let alert = UIAlertController(title: "Enter a value for the square in row \(self.rowCounter + 1) and col \(self.columnwCounter + 1)", message: "Enter 0 for water an 1 for land", preferredStyle: .alert)
        
        
        alert.addTextField { (textField) in
            textField.keyboardType = UIKeyboardType.numberPad
            
            textField.delegate = self
            
        }
        
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            //alert?.textFields?[0].keyboardType = UIKeyboardType.numberPad
                
                alert?.textFields?[0].delegate = self

            let textField = alert?.textFields?[0]
            
            let theValueWillInserted = Int((textField?.text)!)
            
            print("Text field: \(theValueWillInserted!)")
                print("row is \(self.rowCounter)")
                print("col is \(self.columnwCounter)")
                
                
                self.arr[self.rowCounter][self.columnwCounter] = theValueWillInserted!
                
            
            self.columnwCounter+=1

                
                
            self.showMessage()
            
            
        }))

        self.present(alert, animated: true, completion: nil)
       
    }
    
    
    // check every box if its value == 1 , see what is in right , left , down and up to him to add 1 for the length is the next to it is water(0)

    func RealAction() {
        
        // loop in rows first
        for rowIndex in 0 ... self.height - 1 {
            
            // then take each column
            for columnIndex in 0 ... self.width - 1 {
                
                let square = self.arr[rowIndex][columnIndex]
                if square == 1 {
                    
                    
                    // first check for rows
                    // first row
                    if rowIndex == 0 {
                        self.coastLength += 1
                        print("added one to the total coast")
                        
                        if self.height > 1 {
                            let BelowTempSquare = self.arr[rowIndex + 1][columnIndex]
                            
                            if BelowTempSquare == 0 {self.coastLength += 1;print("added one to the total coast")}
                        }
                        
                    }
                    
                        
                        // lasr row
                    if rowIndex == self.height - 1 {
                        self.coastLength += 1
                        print("added one to the total coast")
                        if self.height > 1 {
                            let AboveTempSquare = self.arr[rowIndex - 1][columnIndex]
                            
                            if AboveTempSquare == 0 {self.coastLength += 1;print("added one to the total coast")}
                        }
                        
                        
                    }
                    
                    if rowIndex > 0 &&  rowIndex < self.height - 1 {
                        let AboveTempSquare = self.arr[rowIndex - 1][columnIndex]
                        let BelowTempSquare = self.arr[rowIndex + 1][columnIndex]
                        
                        if AboveTempSquare == 0 {self.coastLength += 1;print("added one to the total coast")}
                        
                        if BelowTempSquare == 0 {self.coastLength += 1;print("added one to the total coast")}
                        
                        
                    }
                    
                    
                    
                    // second check for cols
                    // first col
                    if columnIndex == 0 {
                        self.coastLength += 1
                        print("added one to the total coast")
                        
                        if self.width > 1 {
                            let RightTempSquare = self.arr[rowIndex][columnIndex + 1]
                            
                            if RightTempSquare == 0 {self.coastLength += 1;print("added one to the total coast")}
                        }
                        
                        
                    }
                        // last col
                    if columnIndex == self.width - 1 {
                        self.coastLength += 1
                        print("added one to the total coast")
                        
                        if self.width > 1 {
                            let leftTempSquare = self.arr[rowIndex][columnIndex - 1]
                            
                            if leftTempSquare == 0 {self.coastLength += 1;print("added one to the total coast")}
                        }
                        
                    }
                    
                    
                    if columnIndex > 0 &&  columnIndex < self.height - 1 {
                        let RightTempSquare = self.arr[rowIndex][columnIndex + 1]
                        let leftTempSquare = self.arr[rowIndex][columnIndex - 1]
                        
                        if RightTempSquare == 0 {self.coastLength += 1;print("added one to the total coast")}
                        if leftTempSquare == 0 {self.coastLength += 1;print("added one to the total coast")}
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
            }
            
            
            
        }
        print("_____\(self.coastLength)")
        
        let alert = UIAlertController(title: "Alert", message: "Coast length is \(self.coastLength) KM ", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        clearAction(self)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text?.characters.count)! > 0 {
            return false
        }
        
        let aSet = NSCharacterSet(charactersIn:"01").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
  
    
    
  

}


