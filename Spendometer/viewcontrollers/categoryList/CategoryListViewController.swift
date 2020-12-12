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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupActionListeners()
    }
    
    private func setupView() {
        buttonAddCategory.image = #imageLiteral(resourceName: "ic_plus")
        
        buttonDismiss.containerView.backgroundColor = UIColor.white
        buttonDismiss.image = #imageLiteral(resourceName: "ic_close_accent")
        
        textFieldSearch.placeholderText = "Search Category"
        
        setUpCollectionView()
    }

   
    private func setupActionListeners() {
        buttonAddCategory.onClick = {
            self.present(AddNewCategoryViewController(), animated: true, completion: nil)
        }
        
        buttonDismiss.onClick = {
            self.dismiss(animated: true, completion: nil)
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

extension CategoryListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryListCell.self), for: indexPath) as? CategoryListCell else { return UICollectionViewCell() }
        
        return cell
        
    }
    
    
}

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
