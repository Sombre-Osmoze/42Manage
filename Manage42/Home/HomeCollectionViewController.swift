//
//  HomeCollectionViewController.swift
//  Manage42
//
//  Created by Marcus Florentin on 14/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController, UIPickerViewDataSource, UIPickerViewDelegate {

	// MARK: - Storyboard


	@IBOutlet var cursusPicker: UIPickerView!
	@IBOutlet weak var cursusBarButton: UIBarButtonItem!


	@IBAction func changeCursus(_ sender: Any) {
		cursusPicker.isHidden = false
	}

	// MARK: - HomeCollectionViewController


	var me : UserInformation!
	var currentCursus : Int = 1

	func refreshOwnerData() -> Void {
		controller?.ownerInformation(completion: { (owner, error) in
			if error == nil, owner != nil {
				self.me = owner!
				controller?.user(image: owner!.imageUrl!, completion: { (data, error) in
					if error == nil, let dataC = data {
						self.me.image = dataC
						if let file = try? JSONEncoder().encode(self.me) {
							UserDefaults.standard.setValue(file, forKey: "user")
							UserDefaults.standard.set(self.me.image!, forKey: "picture")
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
		self.currentCursus = self.me.cursusUsers.first(where: { $0.cursus.name == "42" })!.id
		self.collectionView.reloadData()
	}

	// MARK: - UIViewController

    override func viewDidLoad() {

		if let file = UserDefaults.standard.value(forKey: "user") as? Data {
			me = try? JSONDecoder().decode(UserInformation.self, from: file)
			self.currentCursus = self.me.cursusUsers.first(where: { $0.cursus.name == "42" })!.id
			me.image = UserDefaults.standard.value(forKey: "picture") as? Data
		} else {
			fatalError("No owner file")
		}

        super.viewDidLoad()
		navigationItem.title?.append(contentsOf: " " + me.firstName)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		refreshOwnerData()
	}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
		return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


		switch indexPath.row {
		case 0:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! PictureCollectionViewCell
			cell.load(user: me)
			return cell
		case 1:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Basic", for: indexPath) as! BasicInformationCollectionViewCell
				cell.load(user: me, cursus: currentCursus)
				return cell
		case 2:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Graphic", for: indexPath) as! GraphCollectionViewCell
			cell.load(user: me, cursus: currentCursus)
			return cell
		default:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Graph", for: indexPath)

			// Configure the cell
			return cell
		}
    }

	func refresh() -> Void {

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
		return me.cursusUsers.count
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}


	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return me.cursusUsers[row].cursus.name
	}


	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		currentCursus = me.cursusUsers[row].id

		pickerView.isHidden = true
		self.collectionView.reloadData()
	}


}
