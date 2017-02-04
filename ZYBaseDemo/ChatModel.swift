//
//  ChatModel.swift
//  ZYBaseDemo
//
//  Created by Mzywx on 2017/2/4.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit

class ChatModel: ZYDataModel {
    var senderimg : String!
    var content : String!
    var createdate : Double!
    
    required init(fromJson json: JSON!) {
        super.init(fromJson: json)
        senderimg = json["senderimg"].stringValue
        content = json["content"].stringValue
        createdate = json["createdate"].doubleValue
    }
    
}
