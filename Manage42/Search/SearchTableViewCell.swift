//
//  SearchTableViewCell.swift
//  Manage42
//
//  Created by Marcus Florentin on 07/06/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class SearchTableViewCell: UITableViewCell {

	@IBOutlet weak var userPicture: UserImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!

	private var userInformation : UserInformation? = nil

	func load(user: User) -> Void {

		loginLabel.text = user.login


		controller?.userInformation(id: user.id, handler: { (userInfo, error) in

			if error == nil, let info = userInfo {
				// Update UI
				controller?.user(image: user.url, handler: { (data, error) in
					if error == nil, let data = data {
						DispatchQueue.main.async {
							self.userPicture.image = UIImage(data: data)
						}
					} else {
						print(error)
					}
				})
				self.userInformation = info
				DispatchQueue.main.async {
					self.nameLabel?.text = info.displayName
					self.nameLabel.isHidden = false
					self.levelLabel.isHidden = false
					self.levelLabel.text = info.cursusUsers.first?.level.description
				}


			} else {
				// TODO: handle error
				print(error!)
			}


		})


	}

}
