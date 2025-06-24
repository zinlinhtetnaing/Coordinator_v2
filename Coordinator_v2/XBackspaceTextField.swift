////
////  XBackspaceTextField.swift
////  MOB
////
////  Created by Zin Lin Htet Naing on 06/09/2021.
////  Copyright © 2021 zinlinhtetnaing. All rights reserved.
//
//import UIKit
//
//protocol XBackspaceTextFieldDelegate: UITextFieldDelegate {
//    func textFieldDidEnterBackspace(_ textField: XBackspaceTextField)
//}
//
//class XBackspaceTextField: UITextField {
//    
//    private var backspaceTextFieldDelegate: XBackspaceTextFieldDelegate? {
//        get {
//            return delegate as? XBackspaceTextFieldDelegate
//        }
//    }
//    
//    override func deleteBackward() {
//        if text?.isEmpty ?? false {
//            backspaceTextFieldDelegate?.textFieldDidEnterBackspace(self)
//        }
//        self.text = ""
//        super.deleteBackward()
//    }
//    
//}
