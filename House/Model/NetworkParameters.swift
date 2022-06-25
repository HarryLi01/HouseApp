//
//  NetworkParameters.swift
//  House
//
//  Created by Li Li on 2022/6/25.
//

import Foundation

struct NetworkParameters: Codable {
    let username: String
    let password: String
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
