//
//  CategoryListPresenter.swift
//  Spendometer
//
//  Created by Thet Htun on 12/14/20.
//

import Foundation

protocol CategoryListView : BaseView {
    func onCategoryListReady(data: [SpendingCategory])
}

protocol CategoryListPresenter {
    var mView : CategoryListView? { get set }
    var categoryList : [SpendingCategory] { get set }
    
    func fetchCategoryList()
    func searchCategory(name: String)
}


class CategoryListPresenterImpl : BasePresenterImpl, CategoryListPresenter {
    
    var mView : CategoryListView?
    var categoryList = [SpendingCategory]()
    
    func fetchCategoryList() {
        db?.getSpendingCategory(success: { (data) in
            self.categoryList = data
            self.mView?.onCategoryListReady(data: data)
        }, fail: { (err) in
            self.mView?.onError(error: err)
        })
    }
    
    func searchCategory(name: String) {
        if name.isEmpty {
            fetchCategoryList()
            return
        }
        
        db?.getSpendingCategoryByID(name: name, success: { (data) in
            self.categoryList = data
            self.mView?.onCategoryListReady(data: data)
        }, fail: { (error) in
            self.mView?.onError(error: error)
        })
    }
    
}


//
//protocol CategoryListView : BaseView {
//
//}
//
//protocol CategoryListPresenter {
//    var mView : CategoryListView? { get set }
//
//
//}
//
//
//class CategoryListPresenterImpl : BasePresenterImpl, CategoryListPresenter {
//
//    var mView : CategoryListView?
//
//
//}
