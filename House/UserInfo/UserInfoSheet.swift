//
//  UserInfoSheet.swift
//  House
//
//  Created by Li Li on 2022/6/24.
//

import SwiftUI

struct UserInfoSheet: View {
    @State private var toRentalInfo = false
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("用户信息管理")) {
                    NavigationLink(destination: MyRentalInfo()) {
                        HStack {
                            Image(systemName: "house.circle")
                            Text("我的租房信息")
                        }
                        
                    }
                    NavigationLink(destination: UpdateUserPassword()) {
                        HStack {
                            Image(systemName: "lock")
                            Text("修改我的密码")
                        }
                        
                    }
                }
                
                Section(header: Text("房源信息管理")) {
                    NavigationLink(destination: PublishUserHouse()) {
                        HStack {
                            Image(systemName: "house.circle.fill")
                            Text("发布房源信息")
                        }
                        
                    }
                    NavigationLink(destination: MyPublished()) {
                        HStack {
                            Image(systemName: "person.crop.circle.badge.checkmark")
                            Text("我发布的信息")
                        }
                        
                    }
                }
            }
            .navigationTitle("个人信息")
        }
        
    }
}

struct UserInfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoSheet()
    }
}
