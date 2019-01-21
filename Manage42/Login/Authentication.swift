//
//  Authentication.swift
//  Manage42
//
//  Created by Marcus Florentin on 05/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import Foundation
import SafariServices
import API42

extension AuthenticationHandler:  SFSafariViewControllerDelegate {

	// MARK: - Safari Services
	var oathURL : URL {
		return URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(uid)&redirect_uri=\(redirect)&response_type=code")!
	}

	func createSafariView() -> SFSafariViewController {
		let sf = SFSafariViewController(url: oathURL)
		sf.delegate = self
		step = .oath2
		return sf
	}

	public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
		step = .none
	}

	public func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {

		if URL.host == Foundation.URL(string: redirect)!.host!, let code = URL.query?.replacingOccurrences(of: "code=", with: "") {
			controller.dismiss(animated: true, completion: {
				self.store(auth: code)
				self.obtainToken(auth: code)
			})
		}
	}

}
