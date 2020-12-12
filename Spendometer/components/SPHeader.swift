//
//  SPHeader.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit


class SPHeader: UILabel {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        font = UIFont(name: SPFont.Futura.Bold, size: 24)
        textColor = SPColor.Text.primaryInfo
    }
}
