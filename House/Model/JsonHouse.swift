//
//  JsonHouse.swift
//  House
//
//  Created by Li Li on 2022/6/26.
//

import Foundation

struct JsonHouse: Codable, Hashable {
    var hID: Int
    var houseArea: String?
    var hosueDesc: String?
    var houseFloor: String?
    var houseImage: String?
    var houseModel: String?
    var housePrice: Int?
    var houseType: String?
}
