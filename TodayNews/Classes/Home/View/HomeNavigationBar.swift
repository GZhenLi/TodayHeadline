//
//  HomeNavigationBar.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/25.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit
import SnapKit
class HomeNavigationBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加今日头条 图片
        addSubview(toutiaoImageView)
        //添加搜索框
        addSubview(searchBar)
        
        toutiaoImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kMargin)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 72, height: 20))
        }
        
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(toutiaoImageView.snp.right).offset(kMargin)
            make.right.equalTo(self).offset(-kMargin)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
            
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //今日头条 图片
    lazy var toutiaoImageView: UIImageView = {
        let toutiaoImageView = UIImageView(image: UIImage(named: UserDefaults.standard.bool(forKey: isNight) ? "title_night_72x20_" : "title_72x20_"))
        toutiaoImageView.contentMode = .scaleAspectFill
        return toutiaoImageView
        
    }()
    //搜索框
    lazy var searchBar: HomeSearchBar = {
        let searchBar = HomeSearchBar.searchBar()
        searchBar.placeholder = "搜你想搜的"
        searchBar.background = UIImage(named: "searchbox_search_20x28_")
        return searchBar
    }()
    ///重写frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
            super.frame = newFrame
        }
    }
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
    
    
}





