//
//  Int+Extension.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import Foundation

extension Int {
    var formattedId: String {
        "#" + String(format: "%03d", self)
    }
}
