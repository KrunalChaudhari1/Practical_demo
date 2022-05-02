//
//  LaunchViewController.swift
//  Practical_demo
//
//  Created by Mac on 02/05/22.
//

import UIKit

class LaunchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNextVC()
    }

    func loadNextVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Code to push/present new view controller
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
