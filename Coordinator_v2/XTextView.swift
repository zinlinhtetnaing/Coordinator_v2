////
////  XTextView.swift
////  MOB
////
////  Created by Tin Tun Aung on 20/01/2022.
////
//
//import Foundation
//
//import Foundation
//import UIKit
//
//@IBDesignable
//class XTextView: UITextView, UITextViewDelegate {
//    
//    private var floatingLabel = UILabel()
//    private let underLine = UIView()
//    private let errorLabel = UILabel()
//    
//    private var floatingLabelHeight: CGFloat = 20
//    
//    @IBInspectable
//    var placeHolderText: String = .empty {
//        didSet {
//            self.text = placeHolderText.localized
//            self.floatingLabel.text = placeHolderText.localized
//        }
//    }
//    
//    @IBInspectable
//    var floatingLabelColor: UIColor = .whiteBlackColor {
//        didSet {
//            self.floatingLabel.textColor = floatingLabelColor
//        }
//    }
//    
//    var floatingLabelFont: UIFont = .poppinsRegular(ofSize: 14) {
//        didSet {
//            self.floatingLabel.font = floatingLabelFont
//        }
//    }
//    
//    @IBInspectable
//    var underLineColor: UIColor = UIColor.init(hex: 000000) {
//        didSet {
//            underLine.backgroundColor = underLineColor
//        }
//    }
//    
//    @IBInspectable
//    var underLineHeight: CGFloat = 1.0 {
//        didSet {
//            underLine.frame.size.height = underLineHeight
//        }
//    }
//    
//    @IBInspectable
//    var errorTextColor: UIColor = UIColor.init(hex: 0xCA2027) {
//        didSet{
//            errorLabel.textColor = errorTextColor
//        }
//    }
//    
//    // MARK: - A string for errorLabel
//    var errorMessage: String? {
//        didSet {
//            updateError()
//        }
//    }
//    
//    //MARK: -  A Boolean value that determines whether the receiver has an error message.
//    private var hasError: Bool {
//        get {
//            return self.errorMessage != nil && self.errorMessage != ""
//        }
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    // MARK: - Initializers
//    override init(frame: CGRect, textContainer: NSTextContainer?) {
//        super.init(frame: frame, textContainer: textContainer)
//        setup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        addUnderLine()
//    }
//    
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        setup()
//    }
//    
//    private func setup() {
//        addObserver()
//        defaultStyle()
//        addFloatingLabel()
//        addErrorLabel()
//        delegate = self
//        adjustUITextViewHeight()
//    }
//    
//    private func defaultStyle() {
//        backgroundColor = .clear
//        self.layer.borderColor = .none
//        self.clipsToBounds = false
//        self.keyboardType = .asciiCapable
//    }
//    
//    private func addObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditing), name: UITextView.textDidBeginEditingNotification, object: self)
//        NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: UITextView.textDidEndEditingNotification, object: self)
//        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
//    }
//
//    private func addUnderLine() {
//        underLine.backgroundColor = underLineColor
//        underLine.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: underLineHeight)
//        self.addSubview(underLine)
//    }
//    
//    private func addFloatingLabel() {
//        floatingLabel = UILabel(frame: CGRect(x: 0, y: -self.floatingLabelHeight + 5, width: frame.width, height: 0))
//        floatingLabel.textColor = floatingLabelColor
//        floatingLabel.text = self.placeHolderText.localized
//        floatingLabel.font = floatingLabelFont
//        self.addSubview(floatingLabel)
//    }
//    
//    
//    private func addErrorLabel() {
//        errorLabel.frame = CGRect(x: 0, y: frame.height + underLineHeight + 5, width: frame.width, height: 20)
//        errorLabel.backgroundColor = UIColor.clear
//        errorLabel.numberOfLines = 0
//        errorLabel.textColor = errorTextColor
//        errorLabel.textAlignment = .left
//        errorLabel.font = .poppinsRegular(ofSize: 13)
//        self.addSubview(errorLabel)
//    }
//    
//    private func updateError() {
//        errorLabel.isHidden = !hasError
//        if hasError {
//            underLineColor = errorTextColor
//            errorLabel.text = errorMessage?.localized
//            errorLabel.frame.origin.y = frame.height + underLineHeight + 5
//            shake()
//            return
//        }
//        underLineColor =  UIColor.init(hex: 000000)
//    }
//    
//    func showFloatingLabel() {
//        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
//            self.floatingLabel.frame.size.height = self.floatingLabelHeight
//            self.text = self.text == self.placeHolderText.localized ? "" : self.text
//        })
//    }
//    
//    private func hideFloatingLabel() {
//        self.floatingLabel.frame.size.height = 0
//        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
//            self.text = self.placeHolderText.localized
//        })
//    }
//    
//    func clear() {
//        text = ""
//        hideFloatingLabel()
//    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if let range = text.rangeOfCharacter(from: NoSpecialCharacters.validString) {
//            printDebug(range)
//            return false
//        }
//        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//        let numberOfChars = newText.count
//        return numberOfChars <= 70    
//    }
//    
//    @objc private func textDidBeginEditing(_ textField: UITextView) {
//        if self.inputValue.isEmpty || self.text == self.placeHolderText.localized {
//            self.showFloatingLabel()
//        }
//    }
//    
//    @objc private func textDidEndEditing(_ textField: UITextView) {
//        if self.inputValue.isEmpty || self.text == self.placeHolderText.localized {
//            self.hideFloatingLabel()
//        }
//    }
//    
//    //TODO: - remove error each TextField
//    @objc private func textDidChange(_ textField: UITextView) {
//        //  TODO: Clear error message
//        errorMessage = ""
//        underLineColor = UIColor.init(hex: 000000)
////        underLine.frame.origin.y = frame.height
//    }
//}
//
//extension XTextView {
//
//    func shake(count: Float = 4, for duration: TimeInterval = 0.3, withTranslation translation: Float = 3) {
//        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//        animation.repeatCount = count
//        animation.duration = duration / TimeInterval(animation.repeatCount)
//        animation.autoreverses = true
//        animation.values = [translation, -translation]
//        layer.add(animation, forKey: "shake")
//    }
//    
//    func adjustUITextViewHeight() {
//        self.translatesAutoresizingMaskIntoConstraints = true
//        self.sizeToFit()
//        self.isScrollEnabled = false
//    }
//
//}
