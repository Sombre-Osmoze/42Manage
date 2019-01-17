//
//  BasicInformationCollectionViewCell.swift
//  Manage42
//
//  Created by Marcus Florentin on 17/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class BasicInformationCollectionViewCell: UICollectionViewCell {

	var collection : HomeCollectionViewController!

	@IBOutlet weak var walletLabel: UILabel!
	@IBOutlet weak var evaluationPointsLabel: UILabel!
	@IBOutlet weak var cursusButton: UIButton!
	@IBOutlet weak var gradeLabel: UILabel!
	@IBOutlet weak var etecLabel: UILabel!


	@IBAction func changeCursus(_ sender: Any) {

	}


	func load(user info: UserInformation) -> Void {

		walletLabel.text = "\(info.wallet) ₳"
		evaluationPointsLabel.text = info.correctionPoint.description
//		cursusButton.currentTitle = info

	}
}
