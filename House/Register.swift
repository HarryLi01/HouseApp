//
//  Register.swift
//  House
//
//  Created by Li Li on 2022/6/23.
//

import SwiftUI
import Alamofire

struct Register: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var phoneNumber = ""
    @State private var nickName = ""
    @State private var showAlert = false
    var registerParameters: RegisterParameters {
        get {
            return RegisterParameters(uName: username, uPassword: password, uPhoneNumber: phoneNumber, uNickName: nickName)
        }
    }
    enum ActiveAlert {
        case success, fail
    }
    @State private var activeAlert : ActiveAlert = .fail
    
    var body: some View {
        ZStack {
            Color(red: 0.7, green: 0.7, blue: 0.6, opacity: 0.2)
                .ignoresSafeArea()
            VStack {
                Text("注册账号")
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
                
                HStack {
                    Spacer()
                    Spacer()
                    TextField("电话号码", text: $phoneNumber)
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
                    TextField("昵称", text: $nickName)
                        .padding()
                        .background(Color(red: 0.2, green: 0.3, blue: 0.4, opacity: 0.1))
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        
                    Spacer()
                    Spacer()
                }
                Button(action: register,
                       label: {
                    Text("注册")
                        .font(.headline)
                        .frame(width: 120, height: 1)
                        .foregroundColor(.white)
                        .padding()
                })
                .buttonStyle(.borderedProminent)
                .shadow(radius: 5)
                .alert(isPresented: $showAlert) {
                    switch activeAlert {
                    case .success:
                        return Alert(
                            title: Text("注册成功!"),
                            message: Text("用户已经成功注册!")
                        )
                    case .fail:
                        return Alert(
                            title: Text("注册失败!"),
                            message: Text("用户已经注册或输入错误!")
                        )
                    }
                    
                }
                
            }
        }
    }
    func reset() {
        username = ""
        password = ""
        phoneNumber = ""
        nickName = ""
    }
    func register() {
        let request = AF.request("http://localhost:8090/regist", method: .post, parameters: registerParameters)
        request.responseData { response in
            guard let responseBody = String(bytes: response.data!, encoding: .utf8) else {
                showAlert = true
                print("error getting response data!")
                return
            }
            if responseBody == "OK" {
                activeAlert = .success
                showAlert = true
                reset()
            } else {
                //remind user you register failed
                showAlert = true
            }
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
