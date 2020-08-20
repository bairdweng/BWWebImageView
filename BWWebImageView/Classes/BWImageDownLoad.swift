//
//  BWImageDownLoad.swift
//  BWWebImageView
//
//  Created by bairdweng on 2020/8/17.
//

import UIKit

class BWImageDownLoad: NSObject,URLSessionDelegate {
    static let single = BWImageDownLoad()
     func downLoad(url:String,callBack: @escaping(_ data:Data?)->Void) {
        if let r_url = URL(string: url) {
            var request = URLRequest(url: r_url)
            request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            request.httpMethod = "GET"
            let session = URLSession(configuration: .default, delegate: .none, delegateQueue: nil)
            let dataTask = session.dataTask(with: request) { (data, resp, err) in
                print("当前线程:\(Thread.current)")
                callBack(data)
            }
            dataTask.resume()
//            BWImageQueueManage.single.downQueue.addOperation(dataTask)
        }
    }
 
}
