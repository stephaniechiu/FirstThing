//
//  Categories.swift
//  FirstThing
//
//  Created by Stephanie on 8/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class OnboardingCategoryView: UIView {

// MARK: - Properties
    
    let onboardingTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.text = "Pick topics to read what interests you or choose none to read everything"
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.textColor = .label
        title.font = UIFont(name: "AvenirNext", size: 20)
        return title
    }()
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Helper Functions
    func setupLayout() {
        backgroundColor = .systemBackground
        
        addSubview(onboardingTitle)
        onboardingTitle.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
    }
}
