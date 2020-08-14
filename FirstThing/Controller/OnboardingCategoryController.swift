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
//    let category = ["#Technology", "#Fashion", "#Covid"]
    let defaults = UserDefaults.standard
    let defaultNewsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=e2f0b28b0f0146dcb2b9c2ce5c3142a7"
    let defaultKey = "prefersAllCategories"
    
    let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        viewLayout.itemSize = CGSize(width: 100, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .systemBackground
        
        collectionView.setCollectionViewLayout(viewLayout, animated: true)
        return collectionView
    }()
    
// MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = onboardingCategoryView
        
        setupNavigation()
        setupCollectionViwLayout()
        buttonActions()
        saveUserDefaults()
        checkForCategoryPreference()
        
        category = fetchCategoryURL()
    }
    
// MARK: - Helper Functions
    
//    struct Category {
//        var category = ""
//    }
//
//    func createCategory() -> [Category] {
//        var tempCategory: [Category] = []
//
//        let category1 = Category(category: "#Technology")
//        let category2 = Category(category: "#Fashion")
//        let category3 = Category(category: "#Covid")
//
//        tempCategory.append(category1)
//        tempCategory.append(category2)
//        tempCategory.append(category3)
//
//        return tempCategory
//    }
    
    func setupNavigation() {
        navigationController?.navigationBar.tintColor = .clear
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupCollectionViwLayout() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.allowsMultipleSelection = true
        
        view.addSubview(collectionView)
        collectionView.anchor(top: onboardingCategoryView.onboardingTitle.bottomAnchor, left: view.leftAnchor, bottom: onboardingCategoryView.bottomStackView.topAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 20, paddingRight: 10)
    }
    
    func buttonActions() {
        onboardingCategoryView.continueButton.addTarget(self, action: #selector(didTapContinue(sender:)), for: .touchUpInside)
        onboardingCategoryView.skipButton.addTarget(self, action: #selector(didTapSkip(sender:)), for: .touchUpInside)
    }
    
    func saveUserDefaults() {
        defaults.set(defaultNewsURL, forKey: defaultKey)
    }
    
    func checkForCategoryPreference() {
        let prefersDefaultNews = defaults.bool(forKey: defaultNewsURL)
        
        if prefersDefaultNews {
            
        }
    }

// MARK: - Selectors
    
    @objc func didTapContinue(sender: UIButton) {
        Onboarding.shared.setIsNotNewUser()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapSkip(sender: UIButton) {
        saveUserDefaults()
        Onboarding.shared.setIsNotNewUser()
        dismiss(animated: true, completion: nil)
    }
    
// MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.categoryLabel.text = category[indexPath.row].category
        return cell
    } 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 250)
    }
    
// MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
//            var defaultCategory = [Category]()
//            defaultCategory.append(category[indexPath.row])
//
//            defaults.set(defaultCategory, forKey: defaultKey)
            cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//
//            print(category[indexPath.row].category)
//            print(defaultCategory)
//        } else {
//            defaults.set(defaultNewsURL, forKey: defaultKey)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = .white
        }
    }
    
}
