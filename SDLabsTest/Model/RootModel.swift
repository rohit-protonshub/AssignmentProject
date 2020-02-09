//
//  RootModel.swift
//  SDLabsTest
//
//  Created by Lokesh Dudhat on 09/02/20.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation

struct RootModel: Codable {
    var status: Bool
    var message: String?
    var error: String?
    var data: SubRootModel
}

struct SubRootModel: Codable {
    var users: [UserModel]
    var has_more: Bool
}
