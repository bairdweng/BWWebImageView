//
//  BWDownloadOpration.swift
//  BWWebImageView
//
//  Created by bairdweng on 2020/8/19.
//

import UIKit

/// 定义一个协议
protocol BWDownloadOprationDelegate {
    /// 下载完成
    func downLoadCompled(_ data:Data?,url:String?);
}

/// 定义一个下载操作
class BWDownloadOpration: Operation,URLSessionDataDelegate,URLSessionTaskDelegate {
    /// 请求的url
    var url:String?
    private var imageData:NSMutableData?
    var delegate:BWDownloadOprationDelegate?
    
    
    private var _isFinished = false
    private var _isExecuting = false
    private var _isCancelled = false
    
    override var isCancelled: Bool {
        return _isCancelled
    }
    override var isFinished: Bool {
        return _isFinished
    }
    override var isExecuting: Bool {
        return _isExecuting
    }
    /// 重写Start方法
    override func start() {
        super.start()
        /// 如果操作背取消。需要标记finish
        if self.isCancelled == true {
            self.complete()
            return
        }
        self.willChangeValue(forKey: "isExecuting")
        _isExecuting = true
        self.didChangeValue(forKey: "isExecuting")
        if let r_url = URL(string: url ?? "" ) {
            var request = URLRequest(url: r_url)
            request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            request.httpMethod = "GET"
            let session = URLSession(configuration: .default, delegate: self, delegateQueue:nil)
            let dataTask = session.dataTask(with: request)
            dataTask.resume()
            imageData = NSMutableData()
        }
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("==================\(data)")
        imageData?.append(data)
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("下载失败啦：\(String(describing: error))")
            //            self.isFinished = true
        }
        else {
            print("下载完成：\(imageData ?? NSMutableData())")
            self.delegate?.downLoadCompled(imageData as Data?,url: self.url)
        }
        self.complete()
    }
    func complete() {
        self.willChangeValue(forKey: "isFinished")
        self.willChangeValue(forKey: "isExecuting")
        _isFinished = true
        _isExecuting = false
        self.didChangeValue(forKey: "isFinished")
        self.didChangeValue(forKey: "isExecuting")
    }
    override func cancel() {
        if self.isFinished == true {
            return
        }
        super.cancel()
        self.willChangeValue(forKey: "isCancelled")
        _isCancelled = true
        self.didChangeValue(forKey: "isCancelled")
    }
}
