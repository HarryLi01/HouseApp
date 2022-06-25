//
//  Login.swift
//  House
//
//  Created by Li Li on 2022/6/23.
//

import SwiftUI
import Alamofire

struct Login: View {
    @State private var username = ""
    @State private var password = ""
    @State private var responseBody = ""
    @State private var showAlert = false
    @State private var toIndexPage = false
    var networkParameters: NetworkParameters {
        get {
            return NetworkParameters(username: username, password: password)
        }
    }
    enum ActiveAlert {
        case server, fail
    }
    @State private var activeAlert: ActiveAlert = .fail
    var loginParameters: LoginParameters = .sharedLoginParam
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.7, green: 0.7, blue: 0.6, opacity: 0.2)
                    .ignoresSafeArea()
                VStack {
                    Text("欢迎来到房屋租赁网")
                        .font(.title)
                        .padding(.bottom, 20)
                    
                    Image(systemName: "house.circle")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding(.bottom, 20)
                    
                    HStack {
                        Spacer()
                        Spacer()
                        TextField("用户名", text: $username)
                            .padding()
                            .background(Color(red: 0.2, green: 0.3, blue: 0.4, opacity: 0.1))
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        Spacer()
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Spacer()
                        SecureField("密码", text: $password)
                            .padding()
                            .background(Color(red: 0.2, green: 0.3, blue: 0.4, opacity: 0.1))
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            
                            
                        Spacer()
                        Spacer()
                    }
                    
                    NavigationLink(destination: Index(), isActive: $toIndexPage) {
                        Button(action: login,
                               label: {
                            Text("登录")
                                .font(.headline)
                                .frame(width: 120, height: 1)
                                .foregroundColor(.white)
                                .padding()
                        })
                        .buttonStyle(.borderedProminent)
                        .shadow(radius: 5)
                        .alert(isPresented: $showAlert) {
                            switch activeAlert {
                            case .server:
                                return Alert(
                                    title:
                                        Text("Oops!服务器出现了问题")
                                    .foregroundColor(.red),
                                      message:
                                        Text("服务器出现错误")
                                )
                            case .fail:
                                return Alert(
                                    title:
                                        Text("登录失败!")
                                            .foregroundColor(.red),
                                      message: Text("您输入的用户名或密码不正确")
                                )
                            }
                        }
                    }
                                          
                    HStack {
                        Text("新用户？")
                        NavigationLink(destination: Register()) {
                            Text("注册")
                                .foregroundColor(.red)
                                .underline()
                        }
                    }
                }
            }
        }
    }
    
    func login() {
//        let networkParameters = NetworkParameters(username: username, password: password)
        let request = AF.request("http://localhost:8090/login", method: .post, parameters: networkParameters)
        request.responseData { response in
            guard let responseBody = String(bytes: response.data ?? "500".data(using: .utf8)!, encoding: .utf8) else {
                return
            }
            if responseBody == "500" {
                activeAlert = .server
                showAlert = true
            }
            if responseBody == "OK" {
                loginParameters.username = username
                loginParameters.password = password
                toIndexPage = true
            } else if responseBody == "FAIL" {
                activeAlert = .fail
                showAlert = true
            }
        }
        
    }
    

}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
