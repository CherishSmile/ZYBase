//
//  ZYNetWork.swift
//  ZYBase
//
//  Created by Mzywx on 2016/12/29.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import UIKit
import Alamofire


public class ZYUploadModel: NSObject {
    public var dataArr : [Data]!
    public var withName : String!
    public var fileName : String!
    public var mimeType : String!
    public init(uploadArr:[Data],name:String,fName:String,type:String) {
        super.init()
        dataArr = uploadArr
        withName = name
        fileName = fName
        mimeType = type
    }
}

public class ZYNetModel: NSObject {
    public var paramers : [String:Any]?
    public var url : String!
    public var dataClass : AnyClass?
    public var mapClass : AnyClass?
    public var headers : HTTPHeaders?
    
    public init(para:[String:Any]?,data:AnyClass?,map:AnyClass?,urlString:String,header:HTTPHeaders?) {
        super.init()
        paramers = para
        url = urlString
        dataClass = data
        mapClass = map
        headers = header
    }
}

public typealias SuccessClosure = (Bool,Any) -> ()
public typealias FailClosure = (Bool,Any) -> ()
public class ZYNetWork: NSObject {
    

    /**
     *  GET请求
     * - Parameters:
     *   - netModel: 参数配置Model
     *   - success: 成功回调
     *   - fail: 失败回调
     */
    public class func ZYGET(netModel:ZYNetModel,success:@escaping SuccessClosure,fail:@escaping FailClosure)  {
        Alamofire.request(netModel.url!, method: .get, parameters: netModel.paramers, encoding: URLEncoding.default, headers: netModel.headers).responseJSON { (response) in
            if  response.result.isSuccess {
                if let value = response.result.value {
                    let json = JSON(value)
                    if netModel.dataClass != nil {
                        let model = ZYRootModel(fromJson: json, dataClass: netModel.dataClass as? ZYDataModel.Type, mapClass: netModel.mapClass as? ZYMapModel.Type)
                        success(true,model)
                    }else{
                        success(true,json)
                    }
                }
            }else{
                fail(false,response.result.error!)
            }
        }
    }
    

    /**
     *  POST请求
     * - Parameters:
     *   - netModel: 参数配置Model
     *   - success: 成功回调
     *   - fail: 失败回调
     */
    public class func ZYPOST(netModel:ZYNetModel,success:@escaping SuccessClosure,fail:@escaping FailClosure) {
        Alamofire.request(netModel.url!, method: .post, parameters: netModel.paramers, encoding: URLEncoding.default,headers: netModel.headers).responseJSON { (response) in
            if  response.result.isSuccess {
                if let value = response.result.value {
                    let json = JSON(value)
                    if netModel.dataClass != nil {
                        let model = ZYRootModel(fromJson: json, dataClass: netModel.dataClass as? ZYDataModel.Type, mapClass: netModel.mapClass as? ZYMapModel.Type)
                        success(true,model)
                    }else{
                        success(true,json)
                    }
                }
            }else{
                fail(false,response.result.error!)
            }
        }
    }
    
  
    /**
     *  上传单个文件
     * - Parameters:
     *   - uploadModel: 上传参数配置model
     *   - success: 成功回调
     *   - fail: 失败回调
     */
    public class func ZYUPLOAD(netModel:ZYNetModel,uploadModel:ZYUploadModel,success:@escaping SuccessClosure,fail:@escaping FailClosure) {
        Alamofire.upload((uploadModel.dataArr?.first)!, to: netModel.url).responseJSON { (response) in
            if  response.result.isSuccess {
                if let value = response.result.value {
                    let json = JSON(value)
                    if netModel.dataClass != nil {
                        let model = ZYRootModel(fromJson: json, dataClass: netModel.dataClass as? ZYDataModel.Type, mapClass: netModel.mapClass as? ZYMapModel.Type)
                        success(true,model)
                    }else{
                        success(true,json)
                    }
                }
            }else{
                fail(false,response.result.error!)
            }
        }
    }
    
 
    /**
     *  上传多个文件
     * - Parameters:
     *   - netModel: 参数配置model
     *   - uploadModel: 上传配置model
     *   - success: 成功回调
     *   - fail: 失败回调
     */
    public class func ZYMULUPLOAD(netModel:ZYNetModel,uploadModel:ZYUploadModel,success:@escaping SuccessClosure,fail:@escaping FailClosure) {
        Alamofire.upload(multipartFormData: { multipartFormData in
            for data in uploadModel.dataArr!{
                multipartFormData.append(data, withName: uploadModel.withName, fileName: uploadModel.fileName, mimeType: uploadModel.mimeType)
            }
        }, to: netModel.url!) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON{ response in
                    if  response.result.isSuccess {
                        if let value = response.result.value {
                            let json = JSON(value)
                            if netModel.dataClass != nil {
                                let model = ZYRootModel(fromJson: json, dataClass: netModel.dataClass as? ZYDataModel.Type, mapClass: netModel.mapClass as? ZYMapModel.Type)
                                success(true,model)
                            }else{
                                success(true,json)
                            }
                        }
                    }else{
                        fail(false,response.result.error!)
                    }
                }
            case .failure(let encodingError):
                fail(false,encodingError)
            }
        }
    }
    
}
