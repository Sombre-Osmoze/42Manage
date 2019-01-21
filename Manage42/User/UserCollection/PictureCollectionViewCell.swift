//
//  PictureCollectionViewCell.swift
//  Manage42
//
//  Created by Marcus Florentin on 18/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class PictureCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var pictureImageView: UserImageView!


	func load(user information: UserInformation) -> Void {

		if information.image != nil {
			pictureImageView.image = UIImage(data: information.image!)
		}
	}
	
}
