//
//  ThumbCollectionViewCell.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/31.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit
import Kingfisher
class ThumbCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var galleryCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.borderColor = UIColor(r: 240, g: 240, b: 240).cgColor
        thumbImageView.layer.borderWidth = 1
    }
    var thumbImageURL : String? {
        didSet {
            thumbImageView.kf.setImage(with: URL.init(string: thumbImageURL!))
        }
    }

}
