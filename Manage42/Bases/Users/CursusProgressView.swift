//
//  CursusProgressView.swift
//  Manage42
//
//  Created by Marcus Florentin on 14/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class CursusProgressView: UIProgressView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

	override func setProgress(_ progress: Level, animated: Bool) {
		super.setProgress(progress.truncatingRemainder(dividingBy: 1), animated: animated)
	}

}
