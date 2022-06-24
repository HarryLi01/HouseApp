//
//  House.swift
//  House
//
//  Created by Li Li on 2022/6/24.
//

import Foundation

struct House: Identifiable {
    let id = UUID()
    var hosueDesc:String
    var houseModel: String
    var houseArea: String
    var houseFloor: String
    var houseType: String
    var housePrice: Int
    var houseAddress: String
    var houseImage: String
    var communityName: String
    var houseLinkMan: String
    var houseOriented: String
    var houseDetailsImg: String
    var publisher: String
    var publishTime: Date
}
