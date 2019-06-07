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


	func load(user: User) -> Void {



		controller?.userInformation(id: user.id, handler: { (userInfo, error) in
			if error == nil, let info = userInfo {
				// Update UI
			} else {
				// TODO: handle error
				print(error!)
			}


		})


	}

}
