//
//  LoginParameters.swift
//  House
//
//  Created by Li Li on 2022/6/23.
//

import Foundation

class LoginParameters: ObservableObject, Codable {
    
    static let sharedLoginParam = LoginParameters()
    
    @Published var username: String
    @Published var password: String
    
    init() {
        
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
