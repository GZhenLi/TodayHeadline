//
//  HomeImageTableCell.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/31.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

class HomeImageTableCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var homeImage: WeiTouTiao? {
        didSet {
            if let gallaryImageCount = homeImage!.gallary_image_count {
                if gallaryImageCount > 0 {
                    imageCountLabel.text = "\(gallaryImageCount)图"
                }
            }
            imageTitleLabel.text = homeImage!.title! as String
            timeLabel.text = homeImage!.commentCount! + "评论"
            if let mediaInfo = homeImage?.media_info {
                usernameLabel.text = mediaInfo.name
            }
            let firstImage = homeImage?.image_list.first
            bgImageView.kf.setImage(with: URL.init(string: (firstImage!.url)!))
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
