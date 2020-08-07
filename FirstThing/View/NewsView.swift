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
    
    enum TimeOfDay {
        case morning, afternoon, evening
    }
    
    let firstThingTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.text = "First thing this"
        title.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        return title
    }()
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        setupLayout()
//        changeTimeOfDayTitle()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Helper Functions
    func setupLayout() {
        addSubview(firstThingTitle)
        firstThingTitle.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15)
    }
    
    func changeTimeOfDayTitle() {
        var changeTimeOfDay = TimeOfDay.morning
        switch changeTimeOfDay {
        case .morning:
            print("morning")
        case .afternoon:
            print("afternoon")
        case .evening:
            print("evening")
        default:
            print("Error: \(Error.self)")
        }
    }
}
