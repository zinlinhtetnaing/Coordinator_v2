////
////  XTextField.swift
////  MOB
////
////  Created by Zin Lin Htet Naing on 30/07/2021.
////
//
//import Foundation
//import UIKit
//
//@objc protocol XTextFieldDelegate: UITextFieldDelegate {
//    @objc optional func textFieldRightIconClick(_ textField: UITextField)
//}
//
//@IBDesignable
//class XTextField: UITextField {
//    
//    private var floatingLabel = UILabel()
//    private let underLine = UIView()
//    private let errorLabel = UILabel()
//    
//    private var floatingLabelHeight: CGFloat = 20
//    private var placeHolderText: String?
//    
//    private let leftRightViewFrame: CGRect = CGRect(x: 0, y: 0, width: 20, height: 20)
//    private let padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
//    
//    override var text: String? {
//        didSet {
//            autoFloatingLabelShow()
//        }
//    }
//    
//    override var isHidden: Bool {
//        didSet {
//            underLine.isHidden = isHidden
//            placeholder = ""
//        }
//    }
//    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        if leftImage != nil {
//            return bounds.inset(by: padding)
//        }
//        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30))
//    }
//    
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        if leftImage != nil {
//            return bounds.inset(by: padding)
//        }
//        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30))
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        if leftImage != nil {
//            return bounds.inset(by: padding)
//        }
//        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30))
//    }
//    
//
//    private var xTextFieldDelegate: XTextFieldDelegate? {
//        get {
//            return delegate as? XTextFieldDelegate
//        }
//    }
//
//    @IBInspectable
//    var placeholderColor: UIColor = .whiteGrayColor {
//        didSet {
//            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
//        }
//    }
//    
//    public override var placeholder: String? {
//        didSet {
//            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor, NSAttributedString.Key.font: UIFont.poppinsRegular(ofSize: 14)])
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
//    var underLineColor: UIColor = .tertiaryColor ?? .black {
//        didSet {
//            underLine.backgroundColor = underLineColor
//        }
//    }
//    
//    @IBInspectable
//    var underLineHeight: CGFloat = 1.0 {
//        didSet {
//            underLine.frame = CGRect(origin: CGPoint(x: 0, y: self.frame.height - underLineHeight), size: CGSize(width: self.frame.width, height: underLineHeight))
//        }
//    }
//    
//    @IBInspectable
//    var addVisible: Bool = false {
//        didSet {
//            if addVisible {
//                addVisibleBtn()
//                return
//            }
//        }
//    }
//    
//    @IBInspectable
//    var leftImage: UIImage? {
//        didSet {
//            if leftImage != nil {
//                addImage(direction: .Left, image: leftImage)
//                return
//            }
//            leftViewMode = .never
//        }
//    }
//    
//    @IBInspectable
//    var rightImage: UIImage? {
//        didSet {
//            if rightImage != nil {
//                addImage(direction: .Right, image: rightImage)
//                return
//            }
//        }
//    }
//    
//    @IBInspectable
//    var addCurrency: String? {
//        didSet {
//            if addCurrency != nil {
//                self.keyboardType = .decimalPad
//                addCurrencyLabel(text: addCurrency)
//                return
//            }
//            rightViewMode = .never
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
//    override init(frame: CGRect) {
//        super.init(frame: frame)
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
//        autoFloatingLabelShow()
//    }
//    
//    private func defaultStyle() {
//        backgroundColor = .clear
//        borderStyle = .none
//        self.placeholder = placeholder?.localized
//        textColor = .whiteGrayColor
//    }
//    
//    private func addObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
//        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
//        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: self)
//    }
//    
//    private func addUnderLine() {
//        underLine.translatesAutoresizingMaskIntoConstraints = false
//        underLine.backgroundColor = underLineColor
//        self.addSubview(underLine)
//        underLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 1).isActive = true
//        underLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        underLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        underLine.heightAnchor.constraint(equalToConstant: underLineHeight).isActive = true
//    }
//    
//    private func addFloatingLabel() {
//        floatingLabel = UILabel(frame: CGRect(x: self.leftImage != nil ? self.padding.left : 0, y: 0, width: frame.width, height: 0))
//        floatingLabel.textColor = floatingLabelColor
//        floatingLabel.text = self.placeholder?.components(separatedBy: "- ").last
//        floatingLabel.font = floatingLabelFont
//        placeHolderText = placeholder
//        self.addSubview(floatingLabel)
//    }
//    
//    enum Direction {
//        case Left
//        case Right
//    }
//    
//    private func addImage(direction: Direction, image: UIImage?) {
//        let button = UIButton(frame: leftRightViewFrame)
//        let imageView = UIImageView(frame: leftRightViewFrame)
//        let image = image?.withRenderingMode(.alwaysOriginal)
//        if direction == .Left {
//            imageView.image = image
//            self.leftViewMode = .always
//            self.leftView = imageView
//            return
//        }
//        button.setImage(image, for: .normal)
//        self.rightViewMode = .always
//        self.rightView = button
//        button.addTarget(self, action: #selector(rightButtonTapAction(_:)), for: .touchUpInside)
//    }
//    
//    private func addCurrencyLabel(text: String?) {
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
//        label.font = .size4InchAutoScale(size4Inch: .poppinsMedium(ofSize: 12), otherSize: .poppinsMedium(ofSize: 15))
//        label.textColor = .quinaryColor
//        self.rightViewMode = .always
//        label.text = text?.localized
//        self.rightView = label
//    }
//    
//    private func addVisibleBtn() {
//        let visibleBtn = UIButton(frame: leftRightViewFrame)
//        visibleBtn.setImage(.imageWithMode(imageName: .invisible), for: .selected)
//        visibleBtn.setImage(.imageWithMode(imageName: .visible), for: .normal)
//        visibleBtn.isSelected = true
//        isSecureTextEntry = visibleBtn.isSelected
//        visibleBtn.addTarget(self, action: #selector(visibleBtnAction(_:)), for: .touchUpInside)
//        rightViewMode = .always
//        rightView = visibleBtn
//    }
//    
//    @objc private func visibleBtnAction(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        self.isSecureTextEntry = sender.isSelected
//    }
//    
//    @objc private func rightButtonTapAction(_ sender: UIButton) {
//        self.xTextFieldDelegate?.textFieldRightIconClick?(self)
//    }
//    
//    @objc private func textFieldDidBeginEditing(_ textField: UITextField) {
//        if self.inputValue.isEmpty {
//            self.showFloatingLabel()
//        }
//    }
//    
//    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
//        if self.inputValue.isEmpty {
//            self.hideFloatingLabel()
//            /* TODO: Clear error message
//             errorMessage = ""
//             underLineColor = UIColor.init(hex: 000000)
//             */
//        }
//    }
//    
//    private func addErrorLabel() {
////        errorLabel.frame = CGRect(x: self.leftImage != nil ? self.padding.left : 0, y: self.frame.height, width: self.frame.size.width, height: 25)
//        errorLabel.backgroundColor = UIColor.clear
//        errorLabel.numberOfLines = 0
//        errorLabel.textColor = errorTextColor
//        errorLabel.textAlignment = .left
//        errorLabel.font = .poppinsRegular(ofSize: 13)
//        errorLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(errorLabel)
//        errorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height + 5).isActive = true
//        errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.leftImage != nil ? self.padding.left : 0).isActive = true
//        errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//    }
//    
//    private func updateError() {
//        errorLabel.isHidden = !hasError
//        if hasError {
//            underLineColor = errorTextColor
//            errorLabel.text = errorMessage?.localized
//            shake()
////            clear()
//            return
//        }
//        underLineColor = (.tertiaryColor ?? .black)
//    }
//    
//    //TODO: - remove error each TextField
//    @objc private func textDidChange(_ textField: UITextField) {
//        //  TODO: Clear error message
//        errorMessage = ""
//        underLineColor = (.tertiaryColor ?? .black)
//    }
//    
//    func clear() {
//        text = ""
//        hideFloatingLabel()
//    }
//    
//    private func showFloatingLabel() {
//        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
//            self.floatingLabel.frame = CGRect(x: self.leftImage != nil ? self.padding.left : 0, y: -self.floatingLabelHeight + 5, width: self.frame.width, height: self.floatingLabelHeight)
//            self.placeholder = ""
//        })
//    }
//    
//    private func hideFloatingLabel() {
//        self.floatingLabel.frame = CGRect(x: self.leftImage != nil ? self.padding.left : 0, y: 0, width: self.frame.width, height: 0)
//        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
//            self.placeholder = self.placeHolderText
//        })
//    }
//    
//    private func autoFloatingLabelShow() {
//        self.inputValue.isEmpty ? hideFloatingLabel() : showFloatingLabel()
//    }
//
//}
//
//private var KeyMaxLength: Int = 0
//
//extension XTextField {
//    
//    @IBInspectable
//    var maxLength: Int {
//        get {
//            if let length = objc_getAssociatedObject(self, &KeyMaxLength) as? Int {
//                return length
//            } else {
//                return Int.max
//            }
//        }
//        set {
//            objc_setAssociatedObject(self, &KeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
//            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
//        }
//    }
//    
//    @objc func checkMaxLength(textField: UITextField) {
//        guard let prospectiveText = self.text, prospectiveText.count > maxLength else { return }
//        let selection = selectedTextRange
//        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
//        text = String(prospectiveText[..<maxCharIndex])
//        selectedTextRange = selection
//    }
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
//    func addDecimal(_ range: NSRange, _ string: String) -> Bool {
//        let point = Locale.current.decimalSeparator!
//        let decSep = Locale.current.groupingSeparator!
//        
//        let text = self.inputValue
//        let textRange = Range(range, in: text)!
//        
//        var fractionLength = 0
//        var isRangeUpperPoint = false
//        
//        if let startPoint = text.lastIndex(of: point.first!) {
//            let end = text.endIndex
//            let str = String(text[startPoint..<end])
//            fractionLength = str.count
//            isRangeUpperPoint = textRange.lowerBound >= startPoint
//        }
//        
//        if fractionLength == 3 && string != "" && isRangeUpperPoint {
//            return false
//        }
//        
//        let r = (self.text! as NSString).range(of: point).location < range.location
//        if (string == "0" || string == "") && r {
//            return true
//        }
//        
//        // First check whether the replacement string's numeric...
//        let cs = NSCharacterSet(charactersIn: "0123456789\(point)").inverted
//        let filtered = string.components(separatedBy: cs)
//        let component = filtered.joined(separator: "")
//        let isNumeric = string == component
//        
//        if isNumeric {
//            let formatter = NumberFormatter()
//            formatter.numberStyle = .decimal
//            formatter.locale = Locale(identifier: "en_US")
//            formatter.maximumFractionDigits = 2
//            // Combine the new text with the old; then remove any
//            // commas from the textField before formatting
//            
//            let newString = text.replacingCharacters(in: textRange,  with: string)
//            
//            let numberWithOutCommas = newString.replacingOccurrences(of: decSep, with: "")
//            let number = formatter.number(from: numberWithOutCommas)
//            if number != nil {
//                var formattedString = formatter.string(from: number!)
//                // If the last entry was a decimal or a zero after a decimal,
//                // re-add it here because the formatter will naturally remove
//                // it.
//                if string == point && range.location == self.text?.count {
//                    formattedString = formattedString?.appending(point)
//                }
//                self.text = formattedString
//            } else {
//                self.text = nil
//            }
//        }
//        return false
//    }
//    
//}
