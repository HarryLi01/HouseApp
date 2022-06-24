//
//  UpdateUserPassword.swift
//  House
//
//  Created by Li Li on 2022/6/24.
//

import SwiftUI
import Alamofire


struct UpdateUserPassword: View {
    @ObservedObject var loginParameters: LoginParameters = .sharedLoginParam
    @State private var initialPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var id = 0
    enum ActiveAlert {
        case success, fail
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
                            SecureField("原密码", text: $initialPassword)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("新密码")
                                .frame(width: 90, alignment: .leading)
                            SecureField("新密码", text: $newPassword)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("确认新密码")
                                .frame(width: 90, alignment: .leading)
                            SecureField("确认新密码", text: $confirmPassword)
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
                            submit()
                            showAlert = true
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
    
    func submit() {
        let reqeuest = AF.request("http://localhost:8090/getLoginUser", method: .post, parameters: loginParameters)
        reqeuest.responseData { response in
            print(String(bytes: response.data!, encoding: .utf8))
        }
        let decoder = JSONDecoder()
        let parameters = ["id": 1, "newPwd": newPassword, "oldPwd": initialPassword] as [String: Any]
        let request = AF.request("http://localhost:8090/updateUserPwd", method: .post, parameters: parameters)
        request.responseData { response in
            guard let responseMessage = String(bytes:  response.data!, encoding: .utf8) else {
                return
            }
            if responseMessage == "OK" {
                activeAlert = .success
                reset()
            }
            else {
                activeAlert = .fail
            }
        }
    }
    
    func reset() {
        initialPassword = ""
        newPassword = ""
        confirmPassword = ""
    }
}

struct UpdateUserPassword_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserPassword()
    }
}
