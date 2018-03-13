//
//  CoinDataViewController+UITextFieldDelegate.swift
//  CoinBucket
//
//  Created by Christopher Lee on 12/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

extension CoinDataViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("end")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")
        
        if arrayOfString.count > 2 {
            return false
        }
        return true
    }
}
