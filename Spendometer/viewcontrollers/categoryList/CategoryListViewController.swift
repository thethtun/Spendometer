//
//  CategoryListViewController.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit

class CategoryListViewController: UIViewController {

    @IBOutlet weak var collectionViewCategoryList : UICollectionView!
    @IBOutlet weak var buttonAddCategory : SPButtonSquare!
    @IBOutlet weak var buttonDismiss : SPButtonSquare!
    @IBOutlet weak var textFieldSearch : SPTextField!
    
    var presenter : CategoryListPresenter?
    var onCategorySelected : ((SpendingCategory)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupActionListeners()
        setupPresenter()
    }
    
    private func setupPresenter() {
        presenter = CategoryListPresenterImpl()
        presenter?.mView = self
        
        presenter?.fetchCategoryList()
    }
    
    private func setupView() {
        buttonAddCategory.image = #imageLiteral(resourceName: "ic_plus")
        
        buttonDismiss.containerView.backgroundColor = UIColor.white
        buttonDismiss.image = #imageLiteral(resourceName: "ic_close_accent")
        
        textFieldSearch.placeholderText = "Search Category"
        
        setUpCollectionView()
        
    }

   
    private func setupActionListeners() {
        buttonAddCategory.onClick = { _ in
            let vc = AddNewCategoryViewController()
            vc.onNewCategorySaved = { _ in
                self.presenter?.fetchCategoryList()
            }
            self.present(vc, animated: true, completion: nil)
        }
        
        buttonDismiss.onClick = { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        textFieldSearch.onTextEndEditing = { data in
            self.presenter?.searchCategory(name: data ?? "")
        }
        
    }
    
    private func setUpCollectionView() {
        collectionViewCategoryList.dataSource = self
        collectionViewCategoryList.delegate = self
        collectionViewCategoryList.showsHorizontalScrollIndicator = false
        collectionViewCategoryList.showsVerticalScrollIndicator = false
        if let layout = collectionViewCategoryList.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical  // .horizontal
        }
        
        collectionViewCategoryList.register(UINib(nibName: String(describing: CategoryListCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CategoryListCell.self))
    }

}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension CategoryListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.presenter?.categoryList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryListCell.self), for: indexPath) as? CategoryListCell else { return UICollectionViewCell() }
        
        cell.data = self.presenter?.categoryList[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = self.presenter?.categoryList[indexPath.row] {
            onCategorySelected?(data)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CategoryListViewController:UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height:  32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

//MARK: - CategoryListView
extension CategoryListViewController : CategoryListView {
    
    func onCategoryListReady(data: [SpendingCategory]) {
        collectionViewCategoryList.reloadData()
    }
    
    func onError(error: String) {
        self.showAlert(message: error)
    }
    
    
}
