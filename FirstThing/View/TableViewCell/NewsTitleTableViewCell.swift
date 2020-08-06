//
//  NewsTitleTableViewCell.swift
//  FirstThing
//
//  Created by Stephanie on 8/6/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class NewsTitleTableViewCell: UITableViewCell {
    
// MARK: - Properties
    var newsTitleLabel = UILabel()

        
// MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setupCellLayout()
        
        addSubview(newsTitleLabel)
        newsTitleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)

        }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Helper Functions
    func setupCellLayout() {
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.lineBreakMode = .byWordWrapping
        newsTitleLabel.textColor = .label
        newsTitleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    }
    
}
