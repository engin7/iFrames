//
//  Labels.swift
//  iFrames
//
//  Created by Engin KUK on 5.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {

@IBInspectable var topInset: CGFloat = 2.0
@IBInspectable var bottomInset: CGFloat = 2.0
@IBInspectable var leftInset: CGFloat = 2.0
@IBInspectable var rightInset: CGFloat = 2.0

override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))
}

override var intrinsicContentSize: CGSize {
    get {
        var contentSize = super.intrinsicContentSize
        contentSize.height += topInset + bottomInset
        contentSize.width += leftInset + rightInset
        return contentSize
    }
}
}
