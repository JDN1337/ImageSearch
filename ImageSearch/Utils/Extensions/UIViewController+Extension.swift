//
//  UIViewController+Extension.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 06/03/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static var nibName: String {
        return String(describing: self)
    }
}
