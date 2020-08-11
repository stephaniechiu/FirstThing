//
//  CategoryHeaderView.swift
//  FirstThing
//
//  Created by Stephanie on 8/10/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class CategoryHeaderView: UITableViewHeaderFooterView {

// MARK: - Properties
    
    let categoryHeader: UILabel = {
        let title = UILabel()
        title.textColor = .label
        return title
    }()
    
// MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Properties
    
    func setupLayout() {
        addSubview(categoryHeader)
        categoryHeader.anchor(left: leftAnchor, paddingLeft: 10)
        categoryHeader.centerY(inView: self)
    }
    
}
