//
//  ProjectsTableViewController.swift
//  Manage42
//
//  Created by Marcus Florentin on 04/06/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class ProjectsTableViewController: UITableViewController, UITableViewDataSourcePrefetching {

	private var projects : [Project] = []

	private var page : Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

		fetchData()
    }


	private func fetchData() {
		controller?.projects(page, handler: { (result) in
			switch result {
			case .success(let results):
				self.projects = results
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			case .failure(let error):
				print(error)
			}


		})
	}

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return projects.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath)

        // Configure the cell...
		let project = projects[indexPath.row]

		cell.textLabel?.text = project.name
		cell.detailTextLabel?.text = project.objectives?.first

        return cell
    }


	// MARK: - Table View Data Source Prefetching

	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		page += 1
		fetchData()
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
		super.prepare(for: segue, sender: sender)

		if segue.identifier == "ProjectDetail" {
			let dest = segue.destination as! ProjectTableViewController

			let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!

			dest.project = projects[indexPath.row]

		}

    }

}
