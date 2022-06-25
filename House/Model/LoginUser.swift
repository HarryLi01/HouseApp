//
//  LoginUser.swift
//  House
//
//  Created by Li Li on 2022/6/25.
//

import Foundation

struct LoginUser: Codable {
    var uID: Int = 0
    var uName: String?
    var uPassword: String?
    var uPhoneNumber: String?
    var uNickName: String?
}
