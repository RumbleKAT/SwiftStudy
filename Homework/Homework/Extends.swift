//
//  Extends.swift
//  Homework
//
//  Created by 송명진 on 2017. 11. 2..
//  Copyright © 2017년 송명진. All rights reserved.
//

import Foundation

extension String {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
