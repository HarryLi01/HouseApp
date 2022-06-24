//
//  LoginParameters.swift
//  House
//
//  Created by Li Li on 2022/6/23.
//

import Foundation

class LoginParameters: Encodable {
    let username: String
    let password: String
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
