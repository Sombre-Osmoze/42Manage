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

	@IBOutlet weak var userPicture: UserImageView!
	@IBOutlet weak var stepLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var stepProgress: UIProgressView!
	@IBOutlet weak var loginLabel: UILabel!
	@IBOutlet weak var signButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func login(_ sender: UIButton) {

		signButton.isEnabled = false
		stepLabel.text = "Starting..."
		stepProgress.setProgress(0/7, animated: true)
		stepLabel.isHidden = false
		stepProgress.isHidden = false
		auth = AuthenticationHandler(completion: { (step, error) in
			self.eventHandling(step)
			if step == .owner, error == nil, auth!.owner?.imageUrl != nil  {
				controller?.user(image: auth!.owner!.imageUrl!) { (data, error) in
						if error == nil, let dataC = data {
							DispatchQueue.main.async {
								self.userPicture.image = UIImage(data: dataC)
							}
							auth?.owner?.image = dataC
							if let file = try? JSONEncoder().encode(auth!.owner!) {
								UserDefaults.standard.setValue(file, forKey: "user")
								UserDefaults.standard.set(auth!.owner!.image!, forKey: "picture")
							}
						}
						auth?.step = .terminated
					}
			} else if step == .session {
				controller = auth?.controller
			}
		})

		present(auth!.createSafariView(), animated: true, completion: nil)
	}

	private var user : UserInformation? = nil

	func eventHandling(_ step: AuthenticationHandler.AuthStep) -> Void {
		DispatchQueue.main.async {
			switch step {
			case .none:
				self.stepProgress.isHidden = true
				self.stepLabel.isHidden = true
				self.signButton.isEnabled = true
			case .terminated:
				self.stepLabel.text = "Finishing..."
				self.stepProgress.setProgress(7/7, animated: true)
				self.performSegue(withIdentifier: "Load", sender: nil)
				auth = nil
			case .code:
				self.stepLabel.text = "Credentials storage..."
				self.stepProgress.setProgress(3/7, animated: true)
			case .session:
				self.stepLabel.text = "Building session..."
				self.stepProgress.setProgress(4/7, animated: true)
			case .owner:
				self.stepLabel.text = "Collecting user informations..."
				self.stepProgress.setProgress(6/7, animated: true)
				let user = auth!.owner!
				self.nameLabel.text = user.displayName
				self.loginLabel.text = user.login
				self.loginLabel.isHidden = false
				if let file = try? JSONEncoder().encode(auth!.owner!) {
					UserDefaults.standard.setValue(file, forKey: "user")
				}
			case .oath2:
				self.stepLabel.text = "Metadata sorting"
				self.stepProgress.setProgress(2/7, animated: true)
			case .token:
				self.stepLabel.text = "Keychain cache..."
				self.stepProgress.setProgress(5/7, animated: true)

			}
		}
	}


    // MARK: - Navigation
	/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
	}
	*/

}
