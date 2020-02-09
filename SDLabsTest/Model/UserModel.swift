//
//  UserModel.swift
//  SDLabsTest
//
//  Created by Lokesh Dudhat on 09/02/20.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    var name: String
    var image: String
    var items: [String]
}
