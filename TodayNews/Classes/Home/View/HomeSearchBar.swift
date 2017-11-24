//
//  HomeSearchBar.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/25.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit
/// 自定义搜索框
class HomeSearchBar: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let searchIcon = UIImageView()
        searchIcon.image = UIImage(named: "searchicon_search_20x20_")
        searchIcon.width = 30
        searchIcon.height = 30
        searchIcon.contentMode = .center
        leftView = searchIcon
        leftViewMode = .always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func searchBar() -> HomeSearchBar {
        return HomeSearchBar()
    }

}
