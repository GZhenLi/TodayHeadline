//
//  HomePageView.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/24.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

protocol HomePageViewDelegate : class {
    func pageView(_ pageView : HomePageView, targetIndex: Int)
}

class HomePageView: UIView {

    weak var homePageDelegate: HomePageViewDelegate?
    
    fileprivate var oldIndex: Int = 0
    fileprivate var currentIndex: Int = 0
    fileprivate var starOffsetX: CGFloat = 0
    
    var titles: [TopicTitle]? {
        didSet {
            titleView.titles = titles
        }
    }
    var childVcs: [TopicViewController]? {
        didSet {
            let vc = childVcs![currentIndex]
            vc.view.frame = CGRect(x: 0, y: 0, width: collectionView.width, height: collectionView.height)
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    fileprivate lazy var titleView: HomeTitleView = {
       let titleView = HomeTitleView()
        titleView.delegate = self as? HomeTitleViewDelegate
        return titleView
    }()
    //使用collectionView作为容器
    fileprivate lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight - kNavBarHeight - 40)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: String(describing: HomeCollectionViewCell.self), bundle: nil),  forCellWithReuseIdentifier: String(describing: HomeCollectionViewCell.self))
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
}

extension HomePageView {
    fileprivate func setupUI() {
        backgroundColor = UIColor.white
        addSubview(titleView)
        addSubview(collectionView)
        
        titleView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(40)
            make.bottom.equalTo(collectionView.snp.top)
        }
        collectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
        }
        homePageDelegate = titleView
    }
}

extension HomePageView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: HomeCollectionViewCell.self), for: indexPath) as! HomeCollectionViewCell
        for subView in cell.contentView.subviews {
            subView .removeFromSuperview()
        }
        let childVc = childVcs![indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
// MARKL:- UICollectionView的delegate
extension HomePageView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isScrollEnabled = true
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        }else{
            scrollView.isScrollEnabled = false
        }
    }
    
    private func contentEndScroll() {
        //获取滚动到的位置
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.width)
        //通知titleView进行调整
        homePageDelegate?.pageView(self, targetIndex: currentIndex)
    }
}
// MARK:- 遵守HYTitleViewDelegate
extension HomePageView: HomeTitleViewDelegate {
    func titleView(_ titleView: HomeTitleView, targetIndex: Int) {
        currentIndex = targetIndex
        //滚动到对应的index
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}

