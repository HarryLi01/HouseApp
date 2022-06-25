//
//  UpdateUserPassword.swift
//  House
//
//  Created by Li Li on 2022/6/24.
//

import SwiftUI
import Alamofire

struct UpdateUserPassword: View {
    let loginParameters: LoginParameters = .sharedLoginParam
    @State private var oldPassword = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State var user: LoginUser = LoginUser()
    enum ActiveAlert {
        case success, fail, different
    }
    @State private var activeAlert: ActiveAlert = .fail
    var body: some View {
        ScrollView {
                VStack {
                    //form section
                    Section {
                        Spacer(minLength: 20)
                        Divider()
                        HStack {
                            Spacer()
                            Text("原密码")
                                .frame(width: 90, alignment: .leading)
                            TextField("原密码", text: $oldPassword)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("新密码")
                                .frame(width: 90, alignment: .leading)
                            TextField("新密码", text: $newPassword)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("确认新密码")
                                .frame(width: 90, alignment: .leading)
                            TextField("确认新密码", text: $confirmPassword)
                            Spacer()
                        }
                        Divider()
                    }
                    Spacer(minLength: 20)
                    
                    //submit and reset button
                    HStack {
                        Spacer(minLength: 70)
                        //submit button
                        Button(action: {
                            if newPassword != confirmPassword {
                                activeAlert = .different
                                showAlert = true
                                return
                            }
                            submit()
                        }) {
                            Text("提交")
                                .frame(width: 80)
                        }
                        .shadow(radius: 1)
                        .buttonStyle(.borderedProminent)
                        .alert(isPresented: $showAlert) {
                            switch activeAlert {
                            case .success:
                                return Alert(
                                      title: Text("修改成功"),
                                      message: Text("你的密码已经修改成功"),
                                      primaryButton: .default(
                                        Text("取消")
                                      ),
                                      secondaryButton: .default(
                                        Text("确认")
                                    )
                                )
                            case .fail:
                                return Alert(
                                    title: Text("修改失败"),
                                    message: Text("您输入的原密码不正确")
                                )
                            case .different:
                                 return Alert(
                                    title: Text("密码不一致!"),
                                    message: Text("两次输入的密码不一致")
                                 )
                            }
                        }
                        Spacer()
                        
                        //reset button
                        Button(action: reset) {
                            Text("重置")
                                .frame(width: 80)
                        }
                        .foregroundColor(.red)
                        .shadow(radius: 1)
                        .buttonStyle(.bordered)
                        Spacer(minLength: 70)
                    }
                    
                    
                }
        }
        .navigationTitle(Text("修改密码"))
        
    }
    
    //decode user json from server
    func decodeUserJson(userJson: String) -> LoginUser {
        let decoder = JSONDecoder()
        guard let user = try? decoder.decode(LoginUser.self, from: userJson.data(using: .utf8)!) else {
            fatalError("There is an error decoding login user json")
        }
        return user
    }
    
    func submit() {
        //get current login user
        let networkParameters = NetworkParameters(username: loginParameters.username ?? "", password: loginParameters.password ?? "")
        let reqeuest1 = AF.request("http://localhost:8090/getLoginUser", method: .post, parameters: networkParameters)
        reqeuest1.responseData { response in
            let userJson = String(bytes: response.data!, encoding: .utf8)
            user = decodeUserJson(userJson: userJson ?? "")
        }
        
        //update password
        let parameters = ["id": user.uID ?? 0, "newPwd": newPassword, "oldPwd": oldPassword] as [String: Any]
        let request2 = AF.request("http://localhost:8090/updateUserPwd", method: .post, parameters: parameters)
        request2.responseData { response in
            guard let responseMessage = String(bytes:  response.data!, encoding: .utf8) else {
                return
            }
            if responseMessage == "OK" {
                activeAlert = .success
                loginParameters.password = newPassword
                reset()
                showAlert = true
            }
            else {
                activeAlert = .fail
                showAlert = true
            }
        }
    }
    
    func reset() {
        oldPassword = ""
        newPassword = ""
        confirmPassword = ""
    }
}

struct UpdateUserPassword_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserPassword()
    }
}
