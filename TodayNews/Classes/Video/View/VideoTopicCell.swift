//
//  VideoTopicCell.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/30.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit
import Kingfisher
class VideoTopicCell: UITableViewCell, RegisterCellOrNib {
    ///用户头像
    @IBOutlet weak var headButton: UIButton!
    ///
    @IBOutlet weak var bottomLineView: UIView!
    ///更多按钮
    @IBOutlet weak var moreButton: UIButton!
    ///评论数量
    @IBOutlet weak var commentButton: UIButton!
    ///关注数量
    @IBOutlet weak var concernButton: UIButton!
    ///用户昵称
    @IBOutlet weak var nameLable: UILabel!
    ///
    @IBOutlet weak var headCoverButton: UIButton!
    ///时间label
    @IBOutlet weak var timeLabel: UILabel!
    ///播放数量
    @IBOutlet weak var playCountLabel: UILabel!
    ///标题label
    @IBOutlet weak var titleLabel: UILabel!
    ///背景图片
    @IBOutlet weak var bgImageButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        headButton.layer.cornerRadius = 15
        headButton.layer.masksToBounds = true
        contentView.theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.videoTitleColor"
        nameLable.theme_textColor = "colors.black"
        commentButton.theme_setTitleColor("colors.black", forState: .normal)
        concernButton.theme_setTitleColor("colors.black", forState: .normal)
        bottomLineView.theme_backgroundColor = "colors.separatorColor"
        playCountLabel.theme_textColor = "colors.playCountColor"
        concernButton.theme_setImage("images.videoConcernButton", forState: .normal)
        commentButton.theme_setImage("images.videoCommentButton", forState: .normal)
        moreButton.theme_setImage("images.videoMoreButton", forState: .normal)
        bgImageButton.theme_setImage("images.videoBgImageButton", forState: .normal)
    }
    var videoTopic: WeiTouTiao? {
        didSet {
            bgImageButton.kf.setBackgroundImage(with: URL.init(string: (videoTopic?.video_detail_info?.detail_video_large_image?.url)!), for: .normal)
            titleLabel.text = String(describing: videoTopic!.title!)
            if let user_info = videoTopic!.user_info {
                headButton.kf.setBackgroundImage(with: URL.init(string: user_info.avatar_url!)!, for: .normal)
                nameLable.text = user_info.name!
            }
            if videoTopic!.comment_count! == 0 {
                commentButton.setTitle("评论", for: .normal)
            } else {
                commentButton.setTitle(String.init(describing: videoTopic!.comment_count!), for: .normal)
            }
            playCountLabel.text = (videoTopic?.readCount)! + "次播放"
            timeLabel.text = videoTopic?.video_duration
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /// 背景按钮点击
    @IBAction func bgImageButtonClick(_ sender: UIButton) {
        ///获取视频的真实链接
//        NetworkTool.parse
    }
}
