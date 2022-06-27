//
//  PublishUserHouse.swift
//  House
//
//  Created by Li Li on 2022/6/24.
//

import SwiftUI
import Alamofire

struct PublishUserHouse: View {
    let loginParameters: LoginParameters = .sharedLoginParam
    @State var loginUser: LoginUser = LoginUser()
    @State private var houseDesc = ""
    @State private var houseModel = ""
    @State private var houseArea = ""
    @State private var houseFloor = ""
    @State private var houseType = ""
    @State private var housePrice = ""
    @State private var houseAddress = ""
    let houseOriented = ["东西", "南北"]
    let houseTypeArray = ["整租", "合租"]
    @State private var selectedHouseType = "整租"
    @State private var oriented = "东西"
    @State private var showAlert = false
    enum ActiveAlert {
        case success, fail
    }
    @State private var activeAlert: ActiveAlert = .fail
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Section(header: Text("发布房源信息")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                ) {
                    Group {
                        Divider()
                        HStack {
                            Spacer()
                            Text("房源标题")
                                .frame(width: 90, alignment: .leading)
                            TextField("房源标题", text: $houseDesc)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("房屋类型")
                                .frame(width: 90, alignment: .leading)
                            TextField("几室几厅", text: $houseModel)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("房屋面积")
                                .frame(width: 90, alignment: .leading)
                            TextField("房屋面积", text: $houseArea)
                            Spacer()
                        }
                        Divider()
                    }

                    Group {
                        HStack {
                            Spacer()
                            Text("房屋楼层")
                                .frame(width: 90, alignment: .leading)
                            TextField("高层/低层/几楼", text: $houseFloor)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("房屋地址")
                                .frame(width: 90, alignment: .leading)
                            TextField("房屋地址", text: $houseAddress)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("出租方式")
                                .frame(width: 90, alignment: .leading)
                            Picker(selection: $selectedHouseType, label: Text("出租方式")) {
                                ForEach(houseTypeArray, id: \.self) { t in
                                    Text("\(t)")
                                }
                            }
                            .pickerStyle(.segmented)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("房屋朝向")
                                .frame(width: 90, alignment: .leading)
                            Picker(selection: $oriented, label: Text("房屋朝向")) {
                                ForEach(houseOriented, id: \.self) { o in
                                    Text("\(o)")
                                }
                            }
                            .pickerStyle(.segmented)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Spacer()
                            Text("房屋价格")
                                .frame(width: 90, alignment: .leading)
                            TextField("每月租金", text: $housePrice)
                            Spacer()
                        }
                        Divider()
                    }
                }
                HStack {
                    Spacer(minLength: 70)
                    //submit button
                    Button(action: {submit()}) {
                        Text("提交")
                            .frame(width: 80)
                    }
                    .shadow(radius: 1)
                    .buttonStyle(.borderedProminent)
                    .alert(isPresented: $showAlert) {
                        switch activeAlert {
                        case .success:
                            return Alert(title: Text("发布成功"),
                                  message: Text("您的房源信息已经发布成功!"),
                                  primaryButton: .default(Text("取消")),
                                  secondaryButton: .default(Text("确认")))
                        case .fail:
                            return Alert(title: Text("发布失败"),
                                  message: Text("您的房源信息发布失败!"))
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
                Spacer()
            }
        }
    }
    func reset() {
        houseDesc = ""
        houseModel = ""
        houseArea = ""
        houseFloor = ""
        housePrice = ""
    }
    func submit() {
        //get login user
        let networkParameters = NetworkParameters(username: loginParameters.username ?? "", password: loginParameters.password ?? "")
        let reqeuest1 = AF.request("http://localhost:8090/app/getLoginUser", method: .post, parameters: networkParameters)
        reqeuest1.responseData { response in
            let userJson = String(bytes: response.data!, encoding: .utf8)
            loginUser = Bundle.main.decodeJson(userJson ?? "")
        }
        
        let appPublishHouse: AppPublishHouse = AppPublishHouse(houseDesc: houseDesc, houseModel: houseModel, houseArea: houseArea, houseFloor: houseFloor, houseAddress: houseAddress, houseType: houseType, houseOriented: oriented, housePrice: housePrice, publisher: loginUser.uName ?? "")
        let request2 = AF.request("http://localhost:8090/app/uploadHouse", method: .post, parameters: appPublishHouse)
        request2.responseData { response in
            guard let responseMessage = String(bytes: response.data!, encoding: .utf8) else {
                fatalError("There is an error processing app upload house.")
            }
            if responseMessage == "1" {
                activeAlert = .success
            }
            else {
                activeAlert = .fail
            }
        }
        showAlert = true
    }
}

struct PublishUserHouse_Previews: PreviewProvider {
    static var previews: some View {
        PublishUserHouse()
    }
}
