//
//  ZYRootModel.swift
//  ZYBase
//
//  Created by Mzywx on 2016/12/29.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

open class ZYRootModel: NSObject {
    public var data : Any!
    public var map : Any!
    public var message : String!
    public var status : String!
    public var statusCode : String!
    public init(fromJson json:JSON!,dataClass:ZYDataModel.Type?,mapClass:ZYMapModel.Type?) {
        if json.isEmpty {
            return
        }
        let dataArrJson = json["data"].arrayValue
        if !dataArrJson.isEmpty {
            var dicArr : Array<ZYDataModel> = []
            for dataDic in dataArrJson {
                let dataModel = dataClass?.init(fromJson: dataDic)
                dicArr.append(dataModel!)
            }
            data = dicArr
        }
        let dataDicJson = json["data"].dictionaryValue
        if !dataDicJson.isEmpty{
            let dataDic = json["data"]
            data = dataClass?.init(fromJson: dataDic)
        }
    
        let mapArrJosn = json["map"].arrayValue
        if !mapArrJosn.isEmpty {
            var dicArr : Array<ZYMapModel> = []
            for dataDic in mapArrJosn {
                let mapModel = mapClass?.init(fromJson: dataDic)
                dicArr.append(mapModel!)
            }
            map = dicArr
        }

        let mapDicJosn = json["map"].dictionaryValue
        if  !mapDicJosn.isEmpty {
            let mapDic = json["map"]
            map = mapClass?.init(fromJson: mapDic)
        }
        message = json["message"].stringValue
        status = json["status"].stringValue
        statusCode = json["statusCode"].stringValue
    }
}
protocol HandleJson {
     init(fromJson json:JSON!)
}
open class ZYDataModel: NSObject,HandleJson {
    required public init(fromJson json:JSON!) {
        
    }
}
open class ZYMapModel: NSObject,HandleJson {
    required public init(fromJson json:JSON!) {
        
    }
}
