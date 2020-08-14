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
        title.text = "Pick topics to read what interests you or skip to read everything"
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.textColor = .label
        title.font = UIFont(name: "AvenirNext-Bold", size: 24)
        return title
    }()
    
    var skipButton = UIView.actionButton(backgroundColor: .systemGray6, textColor: UIColor.label, text: "Skip")
    var continueButton = UIView.actionButton(backgroundColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), textColor: .white, text: "Continue")
    var bottomStackView: UIStackView
    
// MARK: - Init
    override init(frame: CGRect) {
        self.bottomStackView = UIStackView(arrangedSubviews: [skipButton, continueButton])
        bottomStackView.spacing = 10
        bottomStackView.distribution = .fillEqually
        bottomStackView.axis = .horizontal
        
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
        onboardingTitle.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15)

        addSubview(bottomStackView)
        bottomStackView.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
    }
}
