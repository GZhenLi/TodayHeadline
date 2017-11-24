//
//  RelateVideoNewsCell.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/11/7.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

class RelateVideoNewsCell: UITableViewCell {
    @IBOutlet weak var videoTimeLabel: UILabel!
    
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var adLabel: UILabel!
    @IBOutlet weak var newTitleLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    var relateNews: WeiTouTiao? {
        didSet {
            newTitleLabel.text = relateNews!.title! as String
            if let mediaName = relateNews!.media_name {
                usernameLabel.text = mediaName
            }
            if let middleImage = relateNews!.middle_image {
                thumbImageView.kf.setImage(with: URL(string: middleImage.url!)!)
            }
            if let videoDetal = relateNews!.video_detail_info {
                playCountLabel.text = videoDetal.videoWatchCount! + "次播放"
            }
            videoTimeLabel.text = relateNews!.video_duration!
            if let showTag = relateNews!.show_tag {
                if showTag == "广告" {
                    usernameLabel.text = relateNews?.source
                    adLabel.text = showTag
                    adLabel.layer.cornerRadius = 2
                    adLabel.layer.borderColor = UIColor(r: 72, g: 107, b: 157).cgColor
                    adLabel.layer.borderWidth = 0.5
                    playCountLabel.isHidden = true
                    videoTimeLabel.isHidden = true
                    
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
