//
//  BWImageViewDownload.swift
//  BWWebImageView
//
//  Created by bairdweng on 2020/8/17.
//

import UIKit
var myNameKey = 100

extension UIImageView {
       var myToken: String {
        set {
            objc_setAssociatedObject(self, &myNameKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            if let rs = objc_getAssociatedObject(self, &myNameKey) as? String {
                return rs
            }
            return ""
        }
    }
    open func bw_setUrl(url:String) {
        self.image = nil
        myToken = url
        //        BWImageCacheManage.getCache(url: url) { (data) in
        //            if let imageData = data {
        //                print("获取缓存图片")
        //                OperationQueue.main.addOperation {
        //                    self.image = UIImage(data: imageData)
        //                }
        //            } else {
        //                self.downImage(url: url)
        //            }
        //        }
        self.downImage(url: url)
    }
    func downImage(url:String) {
        let operation = BWDownloadOpration()
        operation.url = url
        BWImageLoadManage.manage().startTask(opration: operation) { (data,c_url) in
//            print("回来了")
            if let imageData = data {
                if c_url != self.myToken {
                    print("url==============不匹配")
                    return;
                }
                OperationQueue.main.addOperation {
                    self.image = UIImage(data: imageData)
                }
                
            }
        }
    }
}
