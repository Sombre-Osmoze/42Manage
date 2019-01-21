//
//  GraphCollectionViewCell.swift
//  Manage42
//
//  Created by Marcus Florentin on 20/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class GraphCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var levelProgressView: CursusProgressView!
	@IBOutlet weak var levelLabel: UILabel!
	


	func load(user info: UserInformation, cursus id: Int) -> Void {

		if let current = info.cursusUsers.first(where: { $0.id == id }) {
			drawCursusProgress(cursus: current)
		}
	}


	func drawCursusProgress(cursus users: CursusUsers) -> Void {
		let level = Int(users.level.rounded(.down))
		let percent = Int(users.level.truncatingRemainder(dividingBy: 1) * 100)

		levelLabel.text = "Level " + level.description +
			" - " + percent.description + " %"
		levelProgressView.setProgress(users.level, animated: true)
	}
}
