//
//  DashboardViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit

class DashboardViewController: UIViewController, Storyboarded {
    
    weak var coordinator: DashboardCoordinator?
    
    @IBOutlet weak var tncLabel: UILabel!
    @IBOutlet weak var pasteMeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pasteMeTextField.delegate = self
        pasteMeTextField.clearButtonMode = .whileEditing
        pasteMeTextField.tintColor = .red
        
        // Custom clear button
               let clearButton = UIButton(type: .custom)
        if #available(iOS 13.0, *) {
            clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
               clearButton.tintColor = .red // Set your desired color here
        clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
               // Adjust button frame if needed
               clearButton.frame = CGRect(x: 20, y: 0, width: 24, height: 24)

               pasteMeTextField.rightView = clearButton
        pasteMeTextField.rightViewMode = .whileEditing
        
        setuptnc()

    }
    
    func setuptnc() {
        tncLabel.text = "စည်းကမ်းနှင့်သတ်မှတ်ချက်များကိုသဘောတူပါသည်"
        tncLabel.setUnderline(textToUnderline: "စည်းကမ်းနှင့်သတ်မှတ်ချက်များကို", .blue)
//        tncLabel.setMultiLabelColor(changeText: "စည်းကမ်းနှင့်သတ်မှတ်ချက်များကို", .blue)
    }
    
    @objc func clearTextField(sender: UIButton) {
           if let textField = sender.superview as? UITextField {
               textField.text = ""
           }
       }
    
    override func viewWillAppear(_ animated: Bool) {
        debugPrint("ViewController Stacks: \(self.navigationController?.viewControllers.count as Any)")
        super.viewWillAppear(animated)
    }
    
    @IBAction func cashInBtnAction(_ sender: UIButton) {
//        coordinator?.navigateToCashIn()
        if let networkData = UserDefaults.standard.string(forKey: "networkresult") {
            pasteMeTextField.text = networkData
        }
        
    }
    
    @IBAction func cashOutBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func infoButtonAction(_ sender: UIButton) {
        coordinator?.showInfoBottomSheet()
    }
    
}

extension DashboardViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        // max characters
//        let maxCharactersCount = 7
//        
//        // get the current text, or use an empty string if that failed
//        let currentText = textField.text ?? ""
//        
//        // attempt to read the range they are trying to change, or exit if we can't
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        
//        // add their new text to the existing text
//        let updatedText = currentText
//            .replacingCharacters(in: stringRange, with: string)
//            .prefix(maxCharactersCount)
//    
//        // Check if the pasteboard has string content and if the range length is 0 (no existing text selected)
//        if let pastedString = UIPasteboard.general.string, range.length == 0, !pastedString.isEmpty {
//            
//            textField.text = String(updatedText)
//            
//            // Move cursor to the end of the text field
//            DispatchQueue.main.async {
//                textField.selectedTextRange = textField.textRange(from: textField.endOfDocument, to: textField.endOfDocument)
//            }
//            
//            // Return false to prevent default text change behavior
//            return false
//        }
//        
//        // Return true to allow default text change behavior
//        // make sure the result is under maxCharactersCount
//        return updatedText.count <= maxCharactersCount
        
        // get the current text, or use an empty string if that failed
            let currentText = textField.text ?? ""

            // attempt to read the range they are trying to change, or exit if we can't
            guard let stringRange = Range(range, in: currentText) else { return false }

            // add their new text to the existing text
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            // make sure the result is under 16 characters
            return updatedText.count <= 16
        
//        return textField.addDecimal(range, string)
    }
    
}

extension UITextField {
    func addDecimal(_ range: NSRange, _ string: String) -> Bool {
        let point = Locale.current.decimalSeparator!
        let decSep = Locale.current.groupingSeparator!
        
        let text = self.text ?? ""
        let textRange = Range(range, in: text)!
        
        var fractionLength = 0
        var isRangeUpperPoint = false
        
        if let startPoint = text.lastIndex(of: point.first!) {
            let end = text.endIndex
            let str = String(text[startPoint..<end])
            fractionLength = str.count
            isRangeUpperPoint = textRange.lowerBound >= startPoint
        }
        
        if fractionLength == 3 && string != "" && isRangeUpperPoint {
            return false
        }
        
        let r = (self.text! as NSString).range(of: point).location < range.location
        if (string == "0" || string == "") && r {
            return true
        }
        
        // First check whether the replacement string's numeric...
        let cs = NSCharacterSet(charactersIn: "0123456789\(point)").inverted
        let filtered = string.components(separatedBy: cs)
        let component = filtered.joined(separator: "")
        let isNumeric = string == component
        
        if isNumeric {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "en_US")
            formatter.maximumFractionDigits = 2
            // Combine the new text with the old; then remove any
            // commas from the textField before formatting
            
            let newString = text.replacingCharacters(in: textRange,  with: string)
            
            let numberWithOutCommas = newString.replacingOccurrences(of: decSep, with: "")
            let number = formatter.number(from: numberWithOutCommas)
            if number != nil {
                var formattedString = formatter.string(from: number!)
                // If the last entry was a decimal or a zero after a decimal,
                // re-add it here because the formatter will naturally remove
                // it.
                if string == point && range.location == self.text?.count {
                    formattedString = formattedString?.appending(point)
                }
                self.text = formattedString
            } else {
                self.text = nil
            }
        }
        return false
    }
}

extension UILabel {
    func setMultiLabelColor(changeText: String, _ color: UIColor = .blue) {
        let text = self.text ?? ""
        let strNumber: NSString = text as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = attribute
    }
    
    func setUnderline(textToUnderline: String, _ color: UIColor? = nil) {
        let text = self.text ?? ""
        let strNumber: NSString = text as NSString
        let range = (strNumber).range(of: textToUnderline)
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttributes([ NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: color ?? .red], range: range)
        self.attributedText = attribute
    }
}
