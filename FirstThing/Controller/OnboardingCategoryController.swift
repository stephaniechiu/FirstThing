//
//  CategoriesController.swift
//  FirstThing
//
//  Created by Stephanie on 8/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class CategoriesController: UIViewController {
    
// MARK: - Properties
    let categoriesView = OnboardingView
    var category: [Category] = []
    
// MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        category = createCategory()
    }
    
// MARK: - Helper Functions
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
    
}
