//
//  HomeUserCell.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/31.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

class HomeUserCell: UITableViewCell {
    @IBOutlet weak var concernButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var digButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var feedshareButton: UIButton!
    @IBOutlet weak var verifiedContentLabel: UILabel!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    
    var weitoutiao:WeiTouTiao? {
        didSet {
            /// 发布者
            if let source = weitoutiao!.source {
                nameLabel.text = source
            } else if let user = weitoutiao!.user {
                avatarImageView.kf.setImage(with: URL.init(string: user.avatar_url!))
                nameLabel.text = user.screen_name!
            } else if let userInfo = weitoutiao!.user_info {
                avatarImageView.kf.setImage(with: URL(string: userInfo.avatar_url!))
                nameLabel.text = userInfo.screen_name!
            } else if let mediaInfo = weitoutiao!.media_info {
                nameLabel.text = mediaInfo.name!
                avatarImageView.kf.setImage(with: URL.init(string: mediaInfo.avatar_url!))
            }
            readCountLabel.text = "\(weitoutiao!.readCount!)阅读"
            verifiedContentLabel.text = weitoutiao!.verified_content!
            digButton.setTitle(weitoutiao!.diggCount!, for: .normal)
            commentButton.setTitle("\(weitoutiao!.commentCount!)", for: .normal)
            feedshareButton.setTitle(weitoutiao!.forwardCount!, for: .normal)
            contentLabel.text = weitoutiao!.content! as String
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        closeButton.theme_setImage("images.dislikeicon", forState: .normal)
        nameLabel.theme_textColor = "colors.black"
        verifiedContentLabel.theme_textColor = "colors.mineOtherCellRightLabel"
        readCountLabel.theme_textColor = "colors.mineOtherCellRightLabel"
        contentView.theme_backgroundColor = "colors.cellBackgroundColor"
        digButton.theme_setImage("images.digButton", forState: .normal)
        digButton.theme_setImage("images.digButtonSelected", forState: .selected)
        separatorView.theme_backgroundColor = "colors.separatorColor"
        commentButton.theme_setImage("images.homeCommentFeed", forState: .normal)
        feedshareButton.theme_setImage("images.homeFeedShare", forState: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
