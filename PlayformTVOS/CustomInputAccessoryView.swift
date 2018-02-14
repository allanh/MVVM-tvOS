/*
 * Copyright (C) 2017 Mattel, Inc. All rights reserved.
 *
 * All information and code contained herein is the property of
 * Mattel, Inc.
 *
 * Any unauthorized use, storage, duplication, and redistribution of
 * this material without written permission from Mattel, Inc. is
 * strictly prohibited.
 *
 * CustomInputAccessoryView
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/11.
 */

import UIKit

enum IAVConstraintType: Int {
    case titleHorizontal = 0
    case descriptionHorizontal
    case titleVertical
    case titleWithDescriptionVertical
    
    static let formatStrings = [
        // Key:                         Visual Format Language
        titleHorizontal:                "H:|-[titleLabel]-|",
        descriptionHorizontal:          "H:|-[descriptionView(800)]-|",
        titleVertical:                  "V:|-[titleLabel]-60-|",
        titleWithDescriptionVertical:   "V:|-[titleLabel]-5-[descriptionView(130)]-40-|"
    ]
    
    func formatString() -> String {
        return IAVConstraintType.formatStrings[self] ?? ""
    }
    
    func constraints(views: [String: Any]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: self.formatString(),
                                              options: [],
                                              metrics: nil,
                                              views: views)
    }
}

enum HintLevel {
    case Normal
    case Warning
}

class CustomInputAccessoryView: UIView {
    // MARK: Properties
    
    let titleLabel = UILabel(frame: CGRect.zero)
    var descriptionView = UITextView(frame: CGRect.zero)
    var descriptionString: String?

    var viewsDictionary: [String: Any] {
        if self.descriptionString != nil {
            return ["titleLabel": self.titleLabel,
                    "descriptionView": self.descriptionView]
        } else {
            return ["titleLabel": self.titleLabel]
        }
    }
    
    func changeTitle (title: String)
    {
        titleLabel.text = title
    }
    
    // MARK: Constraints
    
    var titleHorizontalConstraints: [NSLayoutConstraint] {
        return IAVConstraintType.titleHorizontal.constraints(views: self.viewsDictionary)
    }
    
    var descriptionHorizontalConstraints: [NSLayoutConstraint] {
        return IAVConstraintType.descriptionHorizontal.constraints(views: self.viewsDictionary)
    }
    
    var verticalConstraints: [NSLayoutConstraint] {
        if self.descriptionString != nil {
            return IAVConstraintType.titleWithDescriptionVertical.constraints(views: self.viewsDictionary)
        } else {
            return IAVConstraintType.titleVertical.constraints(views: self.viewsDictionary)
        }
    }

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(title: String) {
        /*
            Call the designated initializer with an inital zero frame. The final
            frame will be determined by the layout constraints added later.
        */
        super.init(frame: CGRect.zero)

        // Setup the label with the text view.
        self.titleLabel.font = UIFont.systemFont(ofSize: 60, weight: UIFontWeightMedium)
        self.titleLabel.text = title
        self.titleLabel.textAlignment = .center
        self.addSubview(self.titleLabel)
        
        self.descriptionView.font = UIFont.systemFont(ofSize: 29, weight: UIFontWeightMedium)
        self.descriptionView.textColor = .red
        self.descriptionView.textAlignment = .center
        self.addSubview(self.descriptionView)

        /*
         Turn off automatic transaltion of resizing masks into constraints as
         we'll be specifying our own layout constraints.
         */
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(self.titleHorizontalConstraints)
        NSLayoutConstraint.activate(self.verticalConstraints)
    }
}
