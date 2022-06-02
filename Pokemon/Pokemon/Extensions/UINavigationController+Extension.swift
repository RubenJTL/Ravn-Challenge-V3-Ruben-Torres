//
//  UINavigationController+Extension.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
