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

	@IBOutlet weak var walletLabel: UILabel!
	@IBOutlet weak var evaluationPointsLabel: UILabel!
	@IBOutlet weak var cursusLabel: UILabel!
	@IBOutlet weak var gradeLabel: UILabel!
	@IBOutlet weak var etecLabel: UILabel!

	func load(user info: UserInformation, cursus id: Int) -> Void {

		let current = info.cursusUsers.first(where: { $0.id == id })

		walletLabel.text = "\(info.wallet) ₳"
		evaluationPointsLabel.text = info.correctionPoint.description
		cursusLabel.text = current?.cursus.name
		gradeLabel.text = current?.grade ?? "Novice"

	}
}
