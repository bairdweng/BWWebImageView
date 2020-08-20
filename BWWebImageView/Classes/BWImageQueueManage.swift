//
//  BWImageQueueManage.swift
//  BWWebImageView
//
//  Created by bairdweng on 2020/8/18.
//

import UIKit
typealias BWImageLoadCallBack = (_ data:Data?,_ url:String?)->Void

//队列管理
open class BWImageQueueManage: NSObject {
    public static let single = BWImageQueueManage()
    /// 下载队列
    public  let downQueue = OperationQueue()
    /// 读写队列
    let readWriteQueue = DispatchQueue(label: "com.ffib.blog.queue", qos: .utility, attributes: .concurrent)
    var callBacks:[[String:BWImageLoadCallBack]] = []
    override init() {
        /// 设置最大并发数。用多少线程去并行是系统决定。如果设置为1，相当于是串行队列
        downQueue.maxConcurrentOperationCount = 2
    }
    func addOperation( callBack: @escaping()->Void) {
        let oper = BlockOperation.init {
            callBack()
        }
        ///执行完成会移除
        downQueue.addOperation(oper)
    }
    open func cancelOperation() {
        print("取消所有队列的执行")
        downQueue.cancelAllOperations()
    }
}
