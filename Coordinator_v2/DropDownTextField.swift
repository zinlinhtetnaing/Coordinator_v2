////
////  DropDownTextField.swift
////  MOB
////
////  Created by Aung Thit on 29/09/2021.
////
//
//import UIKit
//
//@objc protocol DropDownTextFieldDelegate: UITextFieldDelegate {
//    @objc optional func textFieldRightButton(_ textField: DropDownTextField)
//}
//
//class DropDownTextField: UITextField {
//    
//    var dropDownTextFieldDelegate: DropDownTextFieldDelegate?
//    var textPadding = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
//
//    @IBInspectable
//    var rightImage: UIImage? {
//        didSet {
//            if rightImage != nil {
//                let imageColor =                 rightImage?.withRenderingMode(.alwaysTemplate)
//                if #available(iOS 13.0, *) {
////                    rightImage?.withTintColor((.tertiaryColor ?? .orange))
//                } else {
//                    // Fallback on earlier versions
//                }
//                addImage(image: imageColor)
//                return
//            }
//        }
//    }
//    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        let rect = super.textRect(forBounds: bounds)
//        return rect.inset(by: textPadding)
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        let rect = super.editingRect(forBounds: bounds)
//        return rect.inset(by: textPadding)
//    }
//    
//    private func addImage(image: UIImage?) {
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        let image = image?.withRenderingMode(.alwaysOriginal)
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        view.addSubview(button)
//        button.setImage(image, for: .normal)
//        self.rightViewMode = .always
//        self.rightView = view
//        button.addTarget(self, action: #selector(rightButtonTapAction(_:)), for: .touchUpInside)
//    }
//    
//    @objc private func rightButtonTapAction(_ sender: UIButton) {
//        self.dropDownTextFieldDelegate?.textFieldRightButton?(self)
//    }
//    
//}
