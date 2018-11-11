//
//  Text.swift
//  MeMeV1.0
//
//  Created by Ohud Alessa on 03/11/2018.
//  Copyright © 2018 OHUD. All rights reserved.
//

import Foundation
import UIKit


class CustomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    
    var viewController : MeMeViewController!
 
    
    let memeTextAttributes:[NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.white,
        NSAttributedString.Key.foregroundColor: UIColor.black ,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 35)!,
    
        
        // using the minus sign was of a help from StackOverFlow : https://stackoverflow.com/questions/47774748/swift-nsattributedstringkey-not-applying-foreground-color-correctly
        NSAttributedString.Key.strokeWidth: -4.0 ]
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    
        
        return true
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
            if viewController.imageView.image != nil {
                //enable the sharing button only if there is an image in the imageview :)
                
                viewController.toggleShareAndClear(true, true)
            }
            else{
                
                viewController.toggleShareAndClear(true, false)
                
            }
        }
        
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}
