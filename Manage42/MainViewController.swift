//
//  MainViewController.swift
//  Manage42
//
//  Created by Marcus Florentin on 07/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import UIKit
import SafariServices
import API42

class MainViewController: UITabBarController, SFSafariViewControllerDelegate {

    override func viewDidLoad() {
		super.viewDidLoad()
		

		// Do any additional setup after loading the view.

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


	private func obtainToken(auth code: String, view auth: SFSafariViewController) -> Void {

		let url = URL(string: "https://api.intra.42.fr/oauth/token")!

		let data = "grant_type=authorization_code&client_id=5a9e4a1d069dd749fc0ae3b972c8b60474d070dd07f4d75b297912e1804f391f&client_secret=771c64dbcbdef6e3c3b12df235a9663b5bc047d104b92e093cc315ac26994178&code=\(code)&redirect_uri=https://com.osmoze.Manage42".data(using: .utf8)!
		var request = URLRequest(url: url)

		request.httpMethod = "POST"
		request.httpBody = data

		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if error == nil, let status = response as? HTTPURLResponse {

				switch status.statusCode {
				case 200:
					do {
						let token =  try JSONDecoder().decode(Token.self, from: data!)
						controller = ControllerAPI(token: token)
						DispatchQueue.main.async {
							auth.dismiss(animated: true, completion: nil)
						}
						try token.store()

					} catch {
						print(error)
					}
				default:
					print(status.statusCode)
				}
			}
		}.resume()

	}


	func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {

		if URL.host == "com.osmoze.manage42", let token = URL.query?.replacingOccurrences(of: "code=", with: "") {
			controller.dismiss(animated: true, completion: nil)
			obtainToken(auth: token, view: controller)
		}
	}
}
