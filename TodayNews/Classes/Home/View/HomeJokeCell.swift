//
//  HomeJokeCell.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/31.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

class HomeJokeCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var isJoke:Bool? {
        didSet {
            girlImageView.isHidden = isJoke!
        }
    }
    
    var joke: WeiTouTiao? {
        didSet {
            if let content = joke!.content {
                jokeLabel.text = content as String
            }
            if joke!.comment_count! == 0 {
                commentButton.setTitle("评论", for: .normal)
            } else {
                commentButton.setTitle(String.init(describing: joke!.comment_count!), for: .normal)
            }
            likeButton.setTitle(joke!.diggCount, for: .normal)
            dislikeButton.setTitle(joke?.buryCount!, for: .normal)
            if let largeImage = joke?.large_image {
                girlImageView.kf.setImage(with: URL.init(string: largeImage.url!))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        starButton.setImage(UIImage(named: "love_video_press_20x20_"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
