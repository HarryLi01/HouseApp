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
    
    var loginParameters: LoginParameters {
        get {
            return LoginParameters(username: username, password: password)
        }
    }

    
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
                            Alert(
                                title:
                                    Text("登录失败!")
                                        .foregroundColor(.red),
                                  message: Text("您输入的用户名或密码不正确")
                            )
                        }

                    }
                                          
                    
                    HStack {
                        Text("新用户？")
                        NavigationLink(destination: Register()) {
                            Text("注册")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
    }
    
    func login() {
        let request = AF.request("http://localhost:8090/login", method: .post, parameters: loginParameters)
        request.responseData { response in
            guard let responseBody = String(bytes: response.data!, encoding: .utf8) else {
                showAlert = true
                print("error getting response data!")
                return
            }
            if responseBody == "OK" {
                toIndexPage = true
            } else if responseBody == "FAIL" {
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
