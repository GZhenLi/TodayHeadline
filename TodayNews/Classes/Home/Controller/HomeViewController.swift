//
//  HomeViewController.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/24.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit
import SnapKit
class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置导航栏颜色
        navigationController?.navigationBar.theme_barTintColor = "colors.homeNavBarTintColor"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.globalBackgroundColor()
        //设置状态栏属性
        navigationController?.navigationBar.barStyle = .black
        //自定义导航栏
        navigationItem.titleView = homeNavigationBar
        
        automaticallyAdjustsScrollViewInsets = false
        
        /// 获取标题数据
        NetworkTool.loadHomeTitlesData(fromViewController: String(describing: HomeViewController.self)) { (topTitles, homeTopicVCs) in
            //将所有自控制器添加到父控制器中
            for childVc in homeTopicVCs {
                self.addChildViewController(childVc)
            }
            self.setupUI()
            self.pageView.titles = topTitles
            self.pageView.childVcs = self.childViewControllers as? [TopicViewController]
        }
    }

    fileprivate lazy var pageView: HomePageView = {
       let pageView = HomePageView()
        return pageView
    }()
    //自定义导航栏
    fileprivate lazy var homeNavigationBar: HomeNavigationBar = {
       let homeNavigationBar = HomeNavigationBar()
        homeNavigationBar.searchBar.delegate = self as? UITextFieldDelegate
        return homeNavigationBar
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
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

extension HomeViewController {
    fileprivate func setupUI() {
        view.addSubview(pageView)
        
        pageView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.top.equalTo(view).offset(kNavBarHeight)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(homeTitleAddButtonClicked(notification:)), name: NSNotification.Name(rawValue: "homeTitleAddButtonClicked"), object: nil)
    }
    /// 点击了加好按钮
    @objc func homeTitleAddButtonClicked(notification: Notification) {
        let titles = notification.object as! [TopicTitle]
//        let homeAddCategoryVC = home
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeViewController: UITextFieldDelegate {
    /// UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
}





