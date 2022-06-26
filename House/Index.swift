//
//  Index.swift
//  House
//
//  Created by Li Li on 2022/6/23.
//

import SwiftUI
import Alamofire

struct Index: View {
    @State private var showInfo = false
    @State private var indexHouseData: [JsonHouse] = []
    var body: some View {
        ScrollView {
            NavigationView {
                VStack {
                    ForEach (indexHouseData, id: \.self) { houseData in
                        Text(houseData.hosueDesc ?? "无数据")
                    }
                }
            }
            .navigationTitle(Text("房屋租赁网"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: getIndexHouseData) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: showUserInfo) {
                        Image(systemName: "person")
                    }
                    .sheet(isPresented: $showInfo) {
                        UserInfoSheet()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            Text("Index Page")
        }
    }
    
    func showUserInfo() {
        showInfo = true
    }
    func getIndexHouseData() {
        let request = AF.request("http://localhost:8090/app/getIndexPageInfo", method: .post)
        request.responseData { response in
            guard let responseJson = String(bytes: response.data ?? "500".data(using: .utf8)!, encoding: .utf8) else {
                //throw fatal error if program have trouble during getting data
                fatalError("There is an error processing index page house data")
            }
            indexHouseData = Bundle.main.decodeJson(responseJson)
        }
    }
}

struct Index_Previews: PreviewProvider {
    static var previews: some View {
        Index()
    }
}
