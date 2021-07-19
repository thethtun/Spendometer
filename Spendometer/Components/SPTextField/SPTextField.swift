//
//  SPTextField.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit


class SPTextField: BaseViewPod, UITextFieldDelegate {
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var textFieldInput : UITextField!
    
    var placeholderText : String = "Placeholder Text" {
        didSet {
            textFieldInput.placeholder = placeholderText
        }
    }
    
    var onTextEndEditing : ((String?)->Void)?
    
    override func commonInit() {
        loadNib(with: SPTextField.self).instantiate(withOwner: self, options: nil)
        setUpViewPod(with: containerView)
        
        setup()
    }
    
    func setup() {
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        textFieldInput.borderStyle = .none
        textFieldInput.font = UIFont(name: SPFont.Futura.Medium, size: 18)
        //        textFieldInput.textColor = SPColor.Text.primaryInfo
        textFieldInput.delegate = self
        textFieldInput.attributedPlaceholder =
            NSAttributedString(string: placeholderText,
                               attributes: [
                                NSAttributedString.Key.foregroundColor: SPColor.Text.hint ,
                                NSAttributedString.Key.font: UIFont(name: SPFont.Futura.Medium, size: 18) ?? UIFont.systemFont(ofSize: 18),
                               ])
        
        textFieldInput.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
    }
    
    
    @objc func onTextChanged(_ textField : UITextField) {
        onTextEndEditing?(textField.text)
    }
    
    
}

