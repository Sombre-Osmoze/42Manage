//
//  SearchTableViewController.swift
//  Manage42
//
//  Created by Marcus Florentin on 18/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class SearchTableViewController: UITableViewController, UITableViewDataSourcePrefetching, UISearchResultsUpdating {

	let searchController = UISearchController(searchResultsController: nil)

	private var pages : Int = 1
	private var users : [User] = []
	private var currentSearch : String = "a"


	func search() -> Void {
		controller?.search(user: searchController.searchBar.text!, page: pages, completion: { (usersData, error) in
			if error == nil, let users = usersData {
				self.users += users
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			} else {
				print(error!)
			}
		})
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		searchController.searchResultsUpdater = self
		navigationItem.searchController = searchController
		search()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()

		users.removeAll()
		search()
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath)

		let user = users[indexPath.row]

        // Configure the cell...
		cell.textLabel?.text = user.login
		cell.detailTextLabel?.text = user.id.description
        return cell
    }


	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		
		

	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

	// MARK: - UITableViewDataSourcePrefetching

	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

		if indexPaths.contains(where: { $0.row > users.count - 5 }), !currentSearch.isEmpty {
			pages += 1
			search()
		}
	}

	func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {

	}

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.


		
    }


	// MARK: - Search Results Updating

	func updateSearchResults(for searchController: UISearchController) {

		if searchController.searchBar.text != nil, !searchController.searchBar.text!.isEmpty {
			users.removeAll()
			pages = 1
			currentSearch = searchController.searchBar.text!
			search()
		} else {
//			currentSearch = ""
//			users.removeAll()
//			pages = 1
//			tableView.reloadData()
		}
	}

}
