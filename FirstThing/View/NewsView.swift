//
//  NewsView.swift
//  FirstThing
//
//  Created by Stephanie on 8/4/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class NewsView: UIView {
    
// MARK: - Properties
    
    let firstThingTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = UIFont(name: "AvenirNext-Bold", size: 24)
        
        let currentTime = Date()
        let hour = Calendar.current.component(.hour, from: currentTime)
        if hour < 12 {
            title.text = "First thing this morning"
        } else if hour >= 12 && hour < 18 {
            title.text = "First thing this afternoon"
        } else if hour >= 18 && hour <= 24 {
            title.text = "First thing this evening"
        }
        
        return title
    }()
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Helper Functions
    func setupLayout() {
        addSubview(firstThingTitle)
        firstThingTitle.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15)
    }
}
