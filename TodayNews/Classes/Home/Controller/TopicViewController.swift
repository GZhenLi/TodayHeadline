//
//  TopicViewController.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/24.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BMPlayer
import SnapKit
import MJRefresh
import SVProgressHUD

class TopicViewController: UIViewController {

    var lastSelectedIndex = 0
    
    /// 播放器
    fileprivate lazy var player = BMPlayer()
    
    fileprivate let disposeBag = DisposeBag()
    // 记录点击的顶部标题
    var topicTitle: TopicTitle?
    
    //存放新闻主题的数组
    fileprivate var newsTopics = [WeiTouTiao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if self.topicTitle!.category == "subscription" {//头条号
            tableView.tableHeaderView = toutiaohaoHeaderView
        }
        /// 设置上拉和下拉刷新
        setRefresh()
        ///设置通知监听 tabbar 点击
        NotificationCenter.default.addObserver(self, selector: #selector(tabbarSelected), name: NSNotification.Name.init(rawValue: TabBarDidSelectedNotification), object: nil)
        
    }
    
    fileprivate lazy var toutiaohaoHeaderView: ToutiaohaoHeaderView = {
        let toutiaohaoHeaderView = ToutiaohaoHeaderView()
        toutiaohaoHeaderView.height = 56
        toutiaohaoHeaderView.delegate = self as? ToutiaohaoHeaderViewDelegate
        return toutiaohaoHeaderView
    }()
    fileprivate lazy var tableView: UITableView = {
       
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 232
        tableView.dataSource = self as? UITableViewDataSource
        tableView.delegate = (self as! UITableViewDelegate)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0)
        //        tableView.register(UINib(nibName: String(describing: HomeTopicCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HomeTopicCell.self))
        //        tableView.register(UINib(nibName: String(describing: VideoTopicCell.self), bundle: nil), forCellReuseIdentifier: String(describing: VideoTopicCell.self))
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
//MARK: - 头条号的代理
extension TopicViewController: ToutiaohaoHeaderViewDelegate {
    func toutiaohaoHeaderViewMoreConcernButtonClickded() {
//        navigationController?.pushViewController(concern, animated: <#T##Bool#>)
    }
}

extension TopicViewController {
    /// 设置UI
    fileprivate func setupUI() {
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(view)
        }
    }
    /// 设置上拉和下拉刷新
    @objc fileprivate func setRefresh() {
        let header = RefreshHeader(refreshingBlock: { [weak self] in
            NetworkTool.loadHomeCategoryNewsFeed(category: self!.topicTitle!.category!) { (nowTime, newsTopics) in
                self!.tableView.mj_header.endRefreshing()
                self!.newsTopics = newsTopics
                self!.tableView.reloadData()
            }
        })
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_header = header
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            NetworkTool.loadHomeCategoryNewsFeed(category: self!.topicTitle!.category!) { (nowTime, newsTopics) in
                self!.tableView.mj_footer.endRefreshing()
                if newsTopics.count == 0 {
                    SVProgressHUD.setForegroundColor(UIColor.white)
                    SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                    SVProgressHUD.showInfo(withStatus: "没有更多新闻啦~")
                    return
                }
                self!.newsTopics += newsTopics
                self!.tableView.reloadData()
            }
        })
        
        
        
    }
    /// 监听 tabbar 点击
    @objc fileprivate func tabbarSelected() {
        if lastSelectedIndex != tabBarController!.selectedIndex{
            tableView.mj_header.beginRefreshing()
        }
        lastSelectedIndex = tabBarController!.selectedIndex
    }
}
// MARK - Table view data source
extension TopicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if topicTitle!.category == "video" {
            return screenHeight * 0.4
        }else if topicTitle!.category == "subscription" {//头条号
            return 68
        }else if topicTitle!.category == "essay_joke" {//段子
            let weitoutiao = newsTopics[indexPath.row]
            return weitoutiao.jokeCellHeight!
        }else if topicTitle!.category == "组图" {//组图
            let weitoutiao = newsTopics[indexPath.row]
            return weitoutiao.imageCellHeight!
        }else if topicTitle!.category == "image_ppmm" {//组图
            let weitoutiao = newsTopics[indexPath.row]
            return weitoutiao.girlCellHeight!
        }else{
            let weitoutiao = newsTopics[indexPath.row]
            if weitoutiao.cell_type! == 32 {//用户
                let weitoutiao = newsTopics[indexPath.row]
                return weitoutiao.contentHeight!
            }else if weitoutiao.cell_type! == 50 {//他们也在用头条
                return 290
            }
            return weitoutiao.homeCellHeight!
        }
    }
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if topicTitle!.category == "subscription" {
            return 10
        } else {
            return newsTopics.count
        }
    }
    
    /// 说明是视频，显示视频 cell
    private func showVideoCell(indexPath: NSIndexPath) -> VideoTopicCell {
        let cell = Bundle.main.loadNibNamed(String.init(describing: VideoTopicCell.self), owner: nil, options: nil)?.last as! VideoTopicCell
        cell.videoTopic = newsTopics[indexPath.row]
        cell.headCoverButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            

        })
        .addDisposableTo(disposeBag)
        //评论按钮点击
        cell.commentButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[weak self] in
            
        }).addDisposableTo(disposeBag)
        //播放按钮点击
        cell.bgImageButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            
        }).addDisposableTo(disposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if topicTitle!.category == "video" {// 视频
            return showVideoCell(indexPath: indexPath as NSIndexPath)
        } else if topicTitle?.category == "subscription" {//头条号
            let cell = Bundle.main.loadNibNamed(String.init(describing: ToutiaohaoCell.self), owner: nil, options: nil)?.last as! ToutiaohaoCell
            return cell
        }else if topicTitle!.category == "essay_joke" { // 段子
            let cell = Bundle.main.loadNibNamed(String(describing: HomeJokeCell.self), owner: nil, options: nil)?.last as! HomeJokeCell
            cell.isJoke = true
            cell.joke = newsTopics[indexPath.row]
            return cell
        } else if topicTitle!.category == "组图" { // 组图
            let cell = Bundle.main.loadNibNamed(String(describing:  HomeImageTableCell.self), owner: nil, options: nil)?.last as! HomeImageTableCell
            cell.homeImage = newsTopics[indexPath.row]
            return cell
        } else if topicTitle!.category == "image_ppmm" { // 组图
            let cell = Bundle.main.loadNibNamed(String(describing:  HomeJokeCell.self), owner: nil, options: nil)?.last as! HomeJokeCell
            cell.isJoke = false
            cell.joke = newsTopics[indexPath.row]
            return cell
        } else {
            let weitoutiao = newsTopics[indexPath.row]
            if weitoutiao.cell_type! == 32 { //用户
                let cell = Bundle.main.loadNibNamed(String(describing:  HomeUserCell.self), owner: nil, options: nil)?.last as! HomeUserCell
                cell.weitoutiao = newsTopics[indexPath.row]
                return cell
            } else if weitoutiao.cell_type! == 50 { // 相关关注
                let cell = Bundle.main.loadNibNamed(String.init(describing: TheyAlsoUseCell()), owner: nil, options: nil)?.last as! TheyAlsoUseCell
                cell.theyUse = newsTopics[indexPath.row]
                return cell
            }
            let cell = Bundle.main.loadNibNamed(String.init(describing: HomeTopicCell.self), owner: nil, options: nil)?.last as! HomeTopicCell
            cell.weitoutiao = weitoutiao
            if weitoutiao.has_video! {// 说明是视频
                cell.videoView.imageButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
                    /// 获取视频真实链接跳转到视频详情控制器
//                    self!.getRealVideoURL(weitoutiao: weitoutiao)
                }).addDisposableTo(disposeBag)
            }
            return cell
        }
     }
    
    ///获取视频的真实链接跳转到视频详情控制器
    private func getRealVideoURL(weitoutiao: WeiTouTiao) {
//        NetworkTool.parseVideoRealURL(video_id: weitoutiao.video_id!) { (realVideo) in
//            let videoDetailVC = VideoDetailController()
//            videoDetailVC.videoTopic = weitoutiao
//            videoDetailVC.realVideo = realVideo
//            self.navigationController?.pushViewController(videoDetailVC, animated: true)
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}



