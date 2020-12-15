//
//  BasePresenter.swift
//  Spendometer
//
//  Created by Thet Htun on 12/14/20.
//

import Foundation

protocol BaseView {
    func onError(error : String)
}

protocol BasePresenter {
    
}

class BasePresenterImpl : BasePresenter {
    var db : DBManager?
    
    init() {
        db = DBManagerImpl()
    }
}
