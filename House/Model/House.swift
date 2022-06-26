//
//  House.swift
//  House
//
//  Created by Li Li on 2022/6/24.
//

import Foundation

struct House: Identifiable, Codable {
    var id = UUID()
    var hID: Int
    var houseArea: String?
    var hosueDesc: String?
    var houseFloor: String?
    var houseImage: String?
    var houseModel: String?
    var housePrice: Int?
    var houseType: String?
    
    var houseAddress: String?
    
    var communityName: String?
    var houseLinkMan: String?
    var houseOriented: String?
    var houseDetailsImg: String?
    var publisher: String?
    var publishTime: Date?
}
