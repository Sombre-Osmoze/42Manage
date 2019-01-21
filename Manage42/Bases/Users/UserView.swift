//
//  UserView.swift
//  Manage42
//
//  Created by Marcus Florentin on 13/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit

@IBDesignable
class UserImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

	override func layoutSublayers(of layer: CALayer) {
		super.layoutSublayers(of: layer)
		self.layer.cornerRadius = (bounds.height > bounds.width ? bounds.height : bounds.width) / 2
	}

}



@IBDesignable
class UserButton: UIButton {

	/*
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func draw(_ rect: CGRect) {
	// Drawing code
	}
	*/

	override func layoutSublayers(of layer: CALayer) {
		super.layoutSublayers(of: layer)
		self.layer.cornerRadius = (bounds.height > bounds.width ? bounds.height : bounds.width) / 2
	}

}
