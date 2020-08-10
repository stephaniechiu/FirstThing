//
//  CategoriesController.swift
//  FirstThing
//
//  Created by Stephanie on 8/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class OnboardingCategoryController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
// MARK: - Properties
    let onboardingCategoryView = OnboardingCategoryView()
    var cellReuseIdentifier = "CategoryCell"
    var category: [Category] = []
    let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
        viewLayout.itemSize = CGSize(width: 100, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .systemGray
        
        collectionView.setCollectionViewLayout(viewLayout, animated: true)
        return collectionView
    }()
    
// MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = onboardingCategoryView
        
        setupNavigation()
        setupCollectionViwLayout()

        category = createCategory()
    }
    
// MARK: - Helper Functions
    
    func setupNavigation() {
        navigationController?.navigationBar.tintColor = .clear
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupCollectionViwLayout() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: onboardingCategoryView.onboardingTitle.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    func createCategory() -> [Category] {
        var tempCategory: [Category] = []
        
        let category1 = Category(category: "Technology")
        let category2 = Category(category: "Fashion")
        let category3 = Category(category: "Covid")
        
        tempCategory.append(category1)
        tempCategory.append(category2)
        tempCategory.append(category3)
        
        return tempCategory
    }
    
// MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.backgroundColor = .yellow
        cell.categoryLabel.text = category[indexPath.row].category
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 250)
    }
    
// MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("click")
    }
    
}
