//
//  LevelHistoricsTableViewController.swift
//  Manage42
//
//  Created by Marcus Florentin on 21/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import API42

class LevelHistoricsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	// MARK: - Level Historic TableView Controller

	private var historicProject : [ArraySlice<ProjectsUsers>] = []


	func historic(_ projects: [ProjectsUsers], for cursus: Int) -> Void {
		guard !projects.isEmpty else { return }

		var filteredProject = projects.filter({ $0.isValidated != nil && $0.isValidated! && $0.cursusIds.contains(cursus) && $0.finalMark! > 0 })
		filteredProject.sort(by: { $0.markedAt! > $1.markedAt! })
//		var prevDate = filteredProject.first!.markedAt!

		 historicProject = filteredProject.split(whereSeparator: { (project) -> Bool in
//			if Calendar.autoupdatingCurrent.isDate(project.markedAt!, inSameDayAs: prevDate) {
//				prevDate = project.markedAt!
//				return true
//			}
			return false
		})
	}


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

	func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return historicProject.count
    }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historicProject[section].count
    }


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryProject", for: indexPath)

		let section = historicProject[indexPath.section]
		let project = section[section.startIndex + indexPath.row]
        // Configure the cell...
		cell.textLabel?.text = project.project.name
		cell.detailTextLabel?.text = project.finalMark!.description

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
	func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
	func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
	func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
