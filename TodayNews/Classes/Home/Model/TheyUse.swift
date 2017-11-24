//
//  TheyUse.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/31.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import Foundation

class UserCard {
    
    var stats_place_holder: String?
    var recommend_reason: String?
    var recommend_type: String?
    var user: CardUser?
    
    init(dict: [String: AnyObject]) {
        stats_place_holder = dict["stas_place_holder"] as? String
        recommend_reason = dict["recommend_reason"] as? String
        recommend_type = dict["recommend_type"] as? String
        user = CardUser.init(dict: dict["user"] as! [String: AnyObject])
    }
    
}

class CardUser {
    var user_id: Int?
    var name: String?
    var avatar_url: String?
    var desc: String?
    var schema: String?
    var user_auth_info: CardUserAuthInfo?
    
    init(dict: [String: AnyObject]) {
        user_auth_info = CardUserAuthInfo(dict: dict["user_auth_info"] as! [String: AnyObject])
        user_id = dict["user_id"] as? Int
        name = dict["name"] as? String
        avatar_url = dict["avatar_url"] as? String
        desc = dict["desc"] as? String
        schema = dict["schema"] as? String
    }
}

class CardUserAuthInfo {
    var auth_type: String?
    var auth_info: String?
    init(dict: [String: AnyObject]) {
        auth_type = dict["auth_type"] as? String
        auth_info = dict["auth_info"] as? String
    }
}

class CardUserRelation {
    var stats_place_holder: String?
    var recommend_reason: String?
    var recommend_type: Int?
    init(dict:[String: AnyObject]) {
        stats_place_holder = dict["stats_place_holder"] as? String
        recommend_reason = dict["recommend_reason"] as? String
        recommend_type = dict["recommend_type"] as? Int
    }
}



