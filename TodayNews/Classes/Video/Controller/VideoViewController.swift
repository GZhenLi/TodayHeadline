//
//  VideoViewController.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/24.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

protocol VideoViewControllerDelegate: class {
    func videoViewController(_ videoViewController : VideoViewController , targetIndex: Int)
}

class VideoViewController: UIViewController {

    weak var delegate: VideoViewControllerDelegate?
    
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScroll: Bool = false
    
    var titles = [TopicTitle]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        NetworkTool.loadVideoTitlesData { (videoTitles, videoTopicVCs) in
            self.titles = videoTitles
            self.titleView.titles = videoTitles
            for childVC in videoTopicVCs {
                self.addChildViewController(childVC)
            }
            self.collectionView.reloadData()
        }
        
    }
    
    fileprivate lazy var titleView: VideoTitleView = {
       let titleView = VideoTitleView()
        titleView.delegate = self as? VideoTitleViewDelegate
        return titleView
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight - kNavBarHeight - 40)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "VideoTopicViewCell")
        collectionView.isPrefetchingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: setupUI
extension VideoViewController {
    // 设置UI
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.globalBackgroundColor()
        
        //设置导航栏颜色
        navigationController?.navigationBar.theme_barTintColor = "colors.otherNavBarTintColor"
        navigationController?.navigationBar.shadowImage = UIImage()
        //不要自动调整inset
        if #available(iOS 11, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        //设置标题view
        navigationItem.titleView = titleView
        delegate = titleView as? VideoViewControllerDelegate
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(kNavBarHeight)
            make.left.bottom.right.equalTo(view)
        }
    }
}

extension VideoViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoTopicViewCell", for: indexPath)
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let childVc = childViewControllers[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
        
    }
}
// MARK: - UICollectionView的delegate
extension VideoViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
        scrollView.isScrollEnabled = true
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        } else {
            scrollView.isScrollEnabled = false
        }
    }
    
    private func contentEndScroll() {
        //获取滚动到的位置
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        //通知titleView进行调整
        delegate?.videoViewController(self, targetIndex: currentIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScroll = false
        startOffsetX = scrollView.contentOffset.x
    }
}
// MARK: - 遵守HYTitleViewDelegate
extension VideoViewController : VideoTitleViewDelegate {
    func titleView(_ titleView: VideoTitleView, targetIndex: Int) {
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    //顶部搜索按钮点击
    func videoTitle(videoTitle: VideoTitleView, didClickSearchButton searchButton: UIButton) {
        
    }
}

