//
//  User.swift
//  CombineExample
//
//  Created by Prabhdeep Singh on 19/01/21.
//  Copyright © 2021 Phoenix. All rights reserved.
//

import Foundation

struct User: Decodable, Identifiable {
    var id: Int
    var name: String
}
