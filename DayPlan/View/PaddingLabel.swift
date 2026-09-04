//
//  PaddingLabel.swift
//  DayPlan
//
//  Created by Ahmet CILINGIR on 04.09.26.
//

import UIKit

final class PaddingLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        
        return CGSize(
            width: size.width + padding.left + padding.right,
            height: size.height + padding.bottom + padding.top
            )
    }
    
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: padding)
        super.drawText(in: insetRect)
    }

}
