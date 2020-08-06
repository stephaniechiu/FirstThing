//
//  NewsTableViewCell.swift
//  FirstThing
//
//  Created by Stephanie on 8/5/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

// MARK: - Properties
    var descriptionText = UILabel()
    var readMoreButton = UIButton()
    
// MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellLayout()
        
        addSubview(descriptionText)
        descriptionText.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        addSubview(readMoreButton)
        readMoreButton.anchor(top: descriptionText.bottomAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingBottom: 10, paddingRight: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Helper Functions
    func setupCellLayout() {
        descriptionText.numberOfLines = 0
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.textColor = .label
        
        readMoreButton.titleLabel?.text = "Read More"
        readMoreButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        readMoreButton.titleLabel?.textColor = .label
        readMoreButton.backgroundColor = .red
    }
}
