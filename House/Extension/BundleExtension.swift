//
//  BundleExtension.swift
//  House
//
//  Created by Li Li on 2022/6/26.
//

import Foundation

extension Bundle {
    //decode json
    func decodeJson<T: Codable>(_ jsonString: String) -> T {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: jsonString.data(using: .utf8) ?? "DecodeError".data(using: .utf8)!) else {
            fatalError("There is an error decoding json data.")
        }
        return decodedData
    }
}
