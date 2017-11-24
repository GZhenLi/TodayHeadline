//
//  String+Extension.swift
//  TodayNews
//
//  Created by 郭振礼 on 2017/10/27.
//  Copyright © 2017年 郭振礼. All rights reserved.
//

import UIKit

extension String {
    subscript (range: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
           return String(self[Range(startIndex..<endIndex)])
        }
        set {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            let strRange = Range(startIndex..<endIndex)
            self.replaceSubrange(strRange, with: newValue)
        }
    }
}

extension NSString {
    /// 计算文本的高度
    func getTextHeight(width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        return (self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 16)], context: nil).size.height)
    }
}
