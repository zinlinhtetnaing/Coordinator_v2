////
////  XDecimalTextField.swift
////  MOB
////
////  Created by Zin Lin Htet Naing on 15/12/2021.
////
//
//import Foundation
//import UIKit
//
//class XDecimalTextField: XTextField, XTextFieldDelegate {
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
//        self.keyboardType = .decimalPad
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////        self.errorMessage = .empty
//        return self.addDecimal(range, string)
//    }
//    
//}
//
