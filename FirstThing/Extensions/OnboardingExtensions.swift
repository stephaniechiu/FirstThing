//
//  OnboardingExtensions.swift
//  FirstThing
//
//  Created by Stephanie on 8/10/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

extension UIView {
    static func actionButton(backgroundColor: UIColor, textColor: UIColor, text: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = backgroundColor
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext", size: 12)
        button.layer.cornerRadius = 15
        return button
    }
}
