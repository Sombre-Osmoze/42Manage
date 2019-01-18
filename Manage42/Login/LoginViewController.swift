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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func login(_ sender: UIButton) {

		sender.isEnabled = false
		stepLabel.isHidden = false
		stepProgress.isHidden = false
		auth = AuthenticationHandler(completion: { (step, error) in
			self.eventHandling(step)
			if step == .owner, error == nil, auth!.owner?.imageUrl != nil  {
				controller?.user(image: auth!.owner!.imageUrl!, completion: { (data, error) in
						if error == nil, let data = data {
							DispatchQueue.main.async {
								self.userPicture.image = UIImage(data: data)
							}
						}
						auth?.step = .terminated
					})
			} else if step == .session {
				controller = auth?.controller
			}
		})

		present(auth!.createSafariView(), animated: true, completion: nil)
	}

	func eventHandling(_ step: AuthenticationHandler.AuthStep) -> Void {
		DispatchQueue.main.async {
			switch step {
			case .terminated:
				self.stepLabel.text = "Finishing..."
				self.stepProgress.progress = 7/7
				sleep(2)
				self.stepProgress.isHidden = true
				self.stepLabel.isHidden = true
				self.performSegue(withIdentifier: "Load", sender: auth!.owner)
			case .code:
				self.stepLabel.text = "Credentials storage..."
				self.stepProgress.progress = 3/7
			case .session:
				self.stepLabel.text = "Building session..."
				self.stepProgress.progress = 4/7
			case .owner:
				self.stepLabel.text = "Collecting user informations..."
				self.stepProgress.progress = 6/7
				let owner = auth!.owner!
				self.nameLabel.text = owner.displayName
				self.loginLabel.text = owner.login
				self.loginLabel.isHidden = false
			case .oath2:
				self.stepLabel.text = "Metadata sorting"
				self.stepProgress.progress = 2/7
			case .token:
				self.stepLabel.text = "Keychain cache..."
				self.stepProgress.progress = 5/7
			default:
				print(step)
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
