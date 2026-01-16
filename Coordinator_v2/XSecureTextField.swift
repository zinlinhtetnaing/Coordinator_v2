////
////  XSecureTextField.swift
////  MOB
////
////  Created by Zin Lin Htet Naing on 09/12/2021.
////
//
//import Foundation
//import UIKit
//
//class XSecureTextField: XTextField, XTextFieldDelegate {
//    
//    var realText: String = "" {
//        didSet {
//            updateSecureText()
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//    
//    private func commonInit() {
//        delegate = self
//        returnKeyType = .done
//        keyboardType = .asciiCapable
//    }
//    
//    func updateSecureText() {
////        printDebug("before update: self.text---\(self.inputValue), self.realText---\(self.realText)")
////        // self.text = self.realText
////        printDebug("after  update: self.text---\(self.inputValue), self.realText---\(self.realText)")
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////        printDebug("range:\(range), string:\(string)")
//        let currentText = self.realText
////        let updatedString: String = currentText.updateText(range: range, string: string)
////        self.realText = updatedString
////        printDebug("currentText:\(currentText), updatedStr:\(updatedString), self.realText:\(self.realText)")
//        return true
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//}
//
