//
//  TheyAlsoUseCell.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/31.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

class TheyAlsoUseCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rightButton: UIButton!
    var userCards = [UserCard]()
    var theyUse: WeiTouTiao? {
        didSet {
            leftLabel.text = theyUse!.title! as String
            rightButton.setTitle(theyUse!.show_more, for: .normal)
            userCards = theyUse!.user_cards
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView.theme_backgroundColor = "colors.separatorColor"
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170, height: 215)
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.register(UINib(nibName: String(describing: TheyUseCollectionCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TheyUseCollectionCell.self))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
