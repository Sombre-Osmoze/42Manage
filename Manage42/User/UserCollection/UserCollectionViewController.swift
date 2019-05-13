//
//  UserCollectionViewController.swift
//  Manage42
//
//  Created by Marcus Florentin on 21/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class UserCollectionViewController: UICollectionViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	// MARK: - StoryBoard

	@IBOutlet var cursusPicker: UIPickerView!



//	@IBOutlet weak var achievementsTableView: UITableView!


	// MARK: - User CollectionView Controller

	var user : UserInformation!
	var currentCursus : Int = 1

	private var cursusTextField : UITextField? = nil

	// MARK: - UIViewController

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title? = user.displayName

		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Register cell classes
		//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		// Do any additional setup after loading the view.
	}


    // MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		// Get the new view controller using [segue destinationViewController].
		// Pass the selected object to the new view controller.

		switch segue.identifier {
		case "showHistorics":
			let dest = segue.destination as! LevelHistoricsViewController
			dest.historic(user.projectsUsers, for: user.cursusUsers.first(where: { $0.id == currentCursus})!.cursus.id)
		default:
			fatalError("Unexpected segue identifier: \(segue.debugDescription)")
		}
	}

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		switch indexPath.row {
		case 0:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! PictureCollectionViewCell
			cell.load(user: user)
			return cell
		case 1:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Basic", for: indexPath) as! BasicInformationCollectionViewCell
			cursusTextField = cell.cursusTextField
			cell.cursusTextField.inputView = cursusPicker
			cell.load(user: user, cursus: currentCursus)
			return cell
		case 2:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Graphic", for: indexPath) as! GraphCollectionViewCell
			cell.load(user: user, cursus: currentCursus)
			return cell
		case 3:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Achievements", for: indexPath) as! AchievementsCollectionViewCell
			cell.load(user.achievements.filter({ $0.visible }))
			return cell

		default: 
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Graph", for: indexPath)

			// Configure the cell
			return cell
		}
	}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

	// MARK: - UIPickerViewDataSource

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return user.cursusUsers.count
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}


	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return user.cursusUsers[row].cursus.name
	}


	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		currentCursus = user.cursusUsers[row].id

		cursusTextField?.resignFirstResponder()
		self.collectionView.reloadData()
	}
}
