//
//  BWImageViewDownload.swift
//  BWWebImageView
//
//  Created by bairdweng on 2020/8/17.
//

import UIKit

extension UIImageView {
    
    open func bw_setUrl(url:String) {
        self.image = nil
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
        /*
        BWImageQueueManage.single.addOperation {
            print("当前线程：\(Thread.current)")
            if let m_url = URL(string: url) {
                do {
                    let imageData = try Data(contentsOf: m_url)
                    OperationQueue.main.addOperation {
                        self.image = UIImage(data: imageData)
                    }
                } catch _ {
                    
                }
            }
        }*/
//        return
        BWImageDownLoad.downLoad(url: url) { (data) in
            if let imageData = data {
                /// 这里执行
                BWImageCacheManage.saveData(url: url, data: imageData)
                /// 主队列
                OperationQueue.main.addOperation {
                    /// 等待线程执行完成后调用
                    print("完成啦")
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
