//
//  FloatingLabelInput.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import UIKit

class FloatingLabelInput: UITextField {
    var floatingLabel: UILabel!// = UILabel(frame: CGRect.zero)
    var floatingLabelHeight: CGFloat = 12
    var button = UIButton(type: .custom)
    var imageView = UIImageView(frame: CGRect.zero)
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
    
    @IBInspectable
    var _placeholder: String?
    
    @IBInspectable
    var floatingLabelColor: UIColor = UIColor.black {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var activeBorderColor: UIColor = UIColor.label
    
    @IBInspectable
    var floatingLabelBackground: UIColor = UIColor.clear.withAlphaComponent(1) {
        didSet {
            self.floatingLabel.backgroundColor = self.floatingLabelBackground
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var _backgroundColor: UIColor = UIColor.clear {
        didSet {
            self.layer.backgroundColor = self._backgroundColor.cgColor
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addDoneButtonOnKeyboard()
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder
        placeholder = self._placeholder // Make sure the placeholder is shown
        self.floatingLabel = UILabel(frame: CGRect.zero)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.label.cgColor
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    }
    
    // Add a floating label to the view on becoming first responder
    @objc func addFloatingLabel() {
        if self.text == "" {
            self.floatingLabel.textColor = floatingLabelColor
            self.floatingLabel.font = floatingLabelFont
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.layer.backgroundColor = UIColor.clear.cgColor
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.clipsToBounds = true
            self.floatingLabel.frame = CGRect(x: 0, y: 0, width: floatingLabel.frame.width+4, height: floatingLabel.frame.height+2)
            self.floatingLabel.textAlignment = .center
            self.addSubview(self.floatingLabel)
            self.layer.borderColor = self.activeBorderColor.cgColor
            
            self.floatingLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -5).isActive = true // Place our label 10 pts above the text field
            self.placeholder = ""
        }
        // Floating label may be stuck behind text input. we bring it forward as it was the last item added to the view heirachy
        self.bringSubviewToFront(subviews.last!)
        self.setNeedsDisplay()
    }
    
    @objc func removeFloatingLabel() {
        if self.text == "" {
            UIView.animate(withDuration: 0.2) {
                self.subviews.forEach{ $0.removeFromSuperview() }
                self.setNeedsDisplay()
            }
            self.placeholder = self._placeholder
        }
        self.layer.borderColor = UIColor.label.cgColor
    }
    
    func addViewPasswordButton() {
        self.button.setImage(UIImage(named: "ic_reveal"), for: .normal)
      //  self.button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.button.frame = CGRect(x: 0, y: 16, width: 22, height: 16)
        self.button.clipsToBounds = true
        self.rightView = self.button
        self.rightViewMode = .always
        self.button.addTarget(self, action: #selector(self.enablePasswordVisibilityToggle), for: .touchUpInside)
    }
    
    func addImage(image: UIImage){
        
        self.imageView.image = image
        self.imageView.frame = CGRect(x: 20, y: 0, width: 20, height: 20)
        self.imageView.translatesAutoresizingMaskIntoConstraints = true
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        
        DispatchQueue.main.async {
            self.leftView = self.imageView
            self.leftViewMode = .always
        }
        
    }
    
    @objc func enablePasswordVisibilityToggle() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            self.button.setImage(UIImage(named: "ic_show"), for: .normal)
        }else{
            self.button.setImage(UIImage(named: "ic_hide"), for: .normal)
        }
    }
    
    fileprivate func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc fileprivate func doneButtonAction() {
        self.resignFirstResponder()
    }
}

