//
//  LoginViewController.swift
//  Manage42
//
//  Created by Marcus Florentin on 04/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import SafariServices
import API42

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func login(_ sender: Any) {
		auth.afterAuth = {
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: "Load", sender: nil)
			}
		}
		present(auth.safariController, animated: true, completion: nil)
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

	// MARK: - Safari Services


}
