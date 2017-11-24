//
//  TheyUseCollectionCell.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/31.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

class TheyUseCollectionCell: UICollectionViewCell {

    @IBOutlet weak var closeButton: UIButton!
    /// 关注
    @IBOutlet weak var concernButton: UIButton!
    /// 头像
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    /// 名称
    @IBOutlet weak var nameLabel: UILabel!
    /// 子标题
    @IBOutlet weak var subtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        closeButton.theme_setImage("images.iconPopupClose", forState: .normal)
    }

}
