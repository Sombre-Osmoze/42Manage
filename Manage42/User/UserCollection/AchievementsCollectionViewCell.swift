//
//  AchievementsCollectionViewCell.swift
//  Manage42
//
//  Created by Marcus Florentin on 13/05/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class AchievementsCollectionViewCell: UICollectionViewCell, UITableViewDataSource {

	// MARK: - Storyboard

	@IBOutlet weak var tableView: UITableView!

	// MARK: - AchievementsCollectionViewCell

	var achievements : [Achievements] = []

	func load(_ achievements: [Achievements]) -> Void {
		self.achievements = achievements
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

	// MARK: - UI Table View Datasource

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return achievements.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementCell", for: indexPath)

		let achievement = achievements[indexPath.row]
		cell.textLabel?.text = achievement.name
		cell.detailTextLabel?.text = achievement.description

		return cell
	}

}
