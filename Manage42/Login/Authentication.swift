//
//  Authentication.swift
//  Manage42
//
//  Created by Marcus Florentin on 05/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import Foundation
import SafariServices

class AuthenticationHandler: NSObject, SFSafariViewControllerDelegate {

	let requestController : UIViewController

	init(view controller: UIViewController) {
		requestController = controller
		super.init()
	}

	func presentAuthentication() -> Void {
		let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=5a9e4a1d069dd749fc0ae3b972c8b60474d070dd07f4d75b297912e1804f391f&redirect_uri=https%3A%2F%2Fcom.osmoze.Manage42&response_type=code")!

		let sf = SFSafariViewController(url: url)
		sf.delegate = self
		requestController.present(sf, animated: true, completion: nil)
	}


	func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
		if URL.host == "com.osmoze.manage42", let token = URL.query?.replacingOccurrences(of: "code=", with: "") {

			controller.dismiss(animated: true, completion: nil)
		}
	}

	func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
		print("Finish")
	}

}
