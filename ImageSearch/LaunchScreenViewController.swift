//
//  LaunchScreenViewController.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 06/03/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation
import UIKit
import Hero

class LaunchScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.launchApp()
    }

    private func launchApp() {
        if let app = UIApplication.shared.delegate as? AppDelegate {
            let imageSearchVC = ImageSearchViewController()
            let navVC = UINavigationController(rootViewController: imageSearchVC)
            navVC.hero.isEnabled = true
            app.window?.rootViewController = navVC
            app.window?.makeKeyAndVisible()
        }
    }
}
