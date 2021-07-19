//
//  AddCategoryPresenter.swift
//  Spendometer
//
//  Created by Thet Htun on 12/15/20.
//

import Foundation


protocol AddCategoryView : BaseView {
    func onNewCategorySaved(data: SpendingCategory)
}

protocol AddCategoryPresenter {
    var mView : AddCategoryView? { get set }

    func addNewCategory(data : String)
}


class AddCategoryPresenterImpl : BasePresenterImpl, AddCategoryPresenter {

    var mView : AddCategoryView?

    var spendingCategoryModel : SpendingCategoryModel = SpendingCategoryModelImpl.shared
    
    func addNewCategory(data : String) {
        let newCategory = SpendingCategory(name: data)
        
        spendingCategoryModel.saveSpendingCategory(data: newCategory, success: {
            self.mView?.onNewCategorySaved(data: newCategory)
        }, fail: { (error) in
            self.mView?.onError(error: error)
        })
    }
    
}
