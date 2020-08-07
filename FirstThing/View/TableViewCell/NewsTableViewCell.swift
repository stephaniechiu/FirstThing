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
    var lastUpdatedLabel = UILabel()

    
    //Closure created for Read More action to assign the parsed JSON url to it in NewsController cellForRowAtIndexPath
    var readMoreAction: ((UIButton) -> Void)?
    
// MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Helper Functions
    func setupCellLayout() {
        
        //Description of the article
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textColor = .label
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 40, paddingRight: 20)
        
        //How long ago since the article was published
        lastUpdatedLabel.textColor = .systemGray
        lastUpdatedLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        
        addSubview(lastUpdatedLabel)
        lastUpdatedLabel.anchor(top: descriptionLabel.bottomAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingBottom: 10, paddingRight: 40)
        
        //Users can click "Read More" to read the article within the app
        readMoreButton.setTitle("Read More", for: .normal)
        readMoreButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        readMoreButton.setTitleColor(.label, for: .normal)
        readMoreButton.addTarget(self, action: #selector(openURL(sender:)), for: .touchUpInside)
        
        addSubview(readMoreButton)
        readMoreButton.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 40, paddingBottom: 10)
    }
    
    @objc func openURL(sender: UIButton) {
        self.readMoreAction?(sender)
    }
    
}
