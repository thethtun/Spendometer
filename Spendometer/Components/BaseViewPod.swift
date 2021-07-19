//
//  BaseViewPod.swift
//  ICTShared
//
//  Created by Zaw Htet Naing on 17/02/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import UIKit

open class BaseViewPod: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
//    override open func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        commonInit()
//    }
    
    open func commonInit(){
        
    }
    
    
    public func makeAnimation(duration: TimeInterval){
        UIView.animate(withDuration: duration) {
            self.layoutIfNeeded()
        }
    }

}


extension UIView{
    
    func loadNib<T>(with nibClass : T) -> UINib{
        return UINib(nibName: String(describing: nibClass), bundle: Bundle(for: nibClass as! AnyClass))
    }
    
    func setUpViewPod(with containerView : UIView){
        containerView.frame = bounds
        addSubview(containerView)
    }
    
}
