//
//  NewsTableViewCell.swift
//  FirstThing
//
//  Created by Stephanie on 8/5/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class NewsDetailsTableViewCell: UITableViewCell {

// MARK: - Properties
    var descriptionLabel = UILabel()
    var readMoreButton = UIButton()
    
// MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellLayout()
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        
        addSubview(readMoreButton)
        readMoreButton.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Helper Functions
    func setupCellLayout() {
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textColor = .label
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        readMoreButton.setTitleColor(.label, for: .normal)
    }
}
