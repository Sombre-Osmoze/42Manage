//
//  HomeCollectionViewController.swift
//  Manage42
//
//  Created by Marcus Florentin on 14/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42


class HomeCollectionViewController: UserCollectionViewController {

	// MARK: - HomeCollectionViewController

	func refreshOwnerData() -> Void {
		controller?.ownerInformation(completion: { (owner, error) in
			if error == nil, owner != nil {
				self.user = owner!
				controller?.user(image: owner!.imageUrl!, completion: { (data, error) in
					if error == nil, let dataC = data {
						self.user.image = dataC
						if let file = try? JSONEncoder().encode(self.user) {
							UserDefaults.standard.setValue(file, forKey: "user")
							UserDefaults.standard.set(self.user.image!, forKey: "picture")
						}
					} else {
						print(error.debugDescription)
					}
					DispatchQueue.main.async {
						self.loadOwnerData()
					}
				})
			} else {
				print(error.debugDescription)
			}
		})
	}
 
	func loadOwnerData() -> Void {
		self.navigationItem.prompt = user.location
		self.currentCursus = self.user.cursusUsers.first(where: { $0.cursus.name == "42" })!.id
		self.collectionView.reloadData()
	}

	// MARK: - User Collection ViewController

	override func viewDidLoad() {

		guard let file = UserDefaults.standard.value(forKey: "user") as? Data else {
			controller?.logout()
			// TODO: Better Handling
			return
		}

		user = try? JSONDecoder().decode(UserInformation.self, from: file)

		if user != nil {
			self.currentCursus = self.user.cursusUsers.first(where: { $0.cursus.name == "42" })!.id
			user.image = UserDefaults.standard.value(forKey: "picture") as? Data
		} else {
			controller?.logout()
			// TODO: Better Handling
			fatalError("No owner file")
		}

		super.viewDidLoad()

		navigationItem.title = ("Welcome " + user.firstName)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		refreshOwnerData()
	}

}
