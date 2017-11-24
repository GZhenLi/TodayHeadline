//
//  AdvertiseViewController.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/23.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

class AdvertiseViewController: UIViewController {
    //延迟2秒
    private var time: TimeInterval = 4.0
    
    private var countdownTimer: Timer?
    
    @IBOutlet weak var timeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       
    }
    @objc func updateTime() {
        if time == 1 {
            countdownTimer?.invalidate()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let tabBarVC = sb.instantiateViewController(withIdentifier: String(describing: MyTabBarController.self)) as! MyTabBarController
            tabBarVC.delegate = self
            UIApplication.shared.keyWindow?.rootViewController = tabBarVC
        }else{
            time -= 1
            timeButton.setTitle(String(format: "%.0f s 跳过", time), for: .normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timeButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let tabBarVC = sb.instantiateViewController(withIdentifier: String.init(describing: MyTabBarController.self))as! MyTabBarController
        tabBarVC.delegate = self
        UIApplication.shared.keyWindow?.rootViewController = tabBarVC
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
extension AdvertiseViewController: UITabBarControllerDelegate {
    /// 点击了哪个 tabbar
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TabBarDidSelectedNotification"), object: nil)
    }
}
