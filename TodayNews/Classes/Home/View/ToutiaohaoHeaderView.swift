//
//  ToutiaohaoHeaderView.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/27.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit
import SnapKit

protocol ToutiaohaoHeaderViewDelegate {
    func toutiaohaoHeaderViewMoreConcernButtonClickded()
}

class ToutiaohaoHeaderView: UIView {

    var delegate: ToutiaohaoHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        addSubview(moreButton)
        
        
    }
    fileprivate lazy var moreButton: UIButton = {
        let moreButton = UIButton(frame: CGRect(x: 10, y: 10, width: screenWidth - 20, height: 36))
        moreButton.addTarget(self, action: #selector(moreConcernButtonClicked), for: .touchUpInside)
        moreButton.setTitle("关注更多头条号", for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moreButton.setImage(UIImage(named: "addpgc_subscribe_16x16_"), for: .normal)
        moreButton.layer.borderColor = UIColor(r: 235, g: 235, b: 235).cgColor
        moreButton.layer.borderWidth = 1
        moreButton.layer.cornerRadius = 5
        moreButton.layer.masksToBounds = true
        moreButton.layer.shouldRasterize = true
        moreButton.layer.rasterizationScale = UIScreen.main.scale
        return moreButton
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func moreConcernButtonClicked() {
        delegate?.toutiaohaoHeaderViewMoreConcernButtonClickded()
    }

}













