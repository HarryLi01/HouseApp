//
//  Index.swift
//  House
//
//  Created by Li Li on 2022/6/23.
//

import SwiftUI

struct Index: View {
    @State private var showInfo = false
    var body: some View {
        NavigationView {
            
        }
        .navigationTitle(Text("房屋租赁网"))
        .toolbar {
            ToolbarItem(id: "userInfo") {
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
    
    func showUserInfo() {
        showInfo = true
    }
}

struct Index_Previews: PreviewProvider {
    static var previews: some View {
        Index()
    }
}
