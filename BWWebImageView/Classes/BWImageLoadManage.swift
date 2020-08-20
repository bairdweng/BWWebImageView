//
//  BWImageLoadManage.swift
//  BWWebImageView
//
//  Created by bairdweng on 2020/8/19.
//

import UIKit

class BWImageLoadManage: NSObject,BWDownloadOprationDelegate {
    func downLoadCompled(_ data: Data?, url: String?) {
        if let r_data = data,let r_url = url {
            BWImageCacheManage.saveData(url: r_url, data: r_data)
        }
        /// 倒序，查找url是否存在列表。
        if let c_url = url {
            for (index,item) in BWImageQueueManage.single.callBacks.enumerated().reversed() {
                let myUrl = item.keys.first
                if c_url == myUrl {
                    let call = item[c_url]
                    if let myCall = call {
                        myCall(data,url)
                    }
                    /// 回调后删除callback
                    BWImageQueueManage.single.callBacks.remove(at: index)
                }
            }
        }
    }
    static func manage()->BWImageLoadManage {
        return BWImageLoadManage()
    }
    private var templeCallBack:BWImageLoadCallBack?
    override init() {
        super.init()
    }
    
    func startTask(opration:BWDownloadOpration,callBack:BWImageLoadCallBack?) {
        opration.delegate = self
        stopLastOpration(opration: opration)
        let dic = [opration.url ?? "" : callBack!]
        BWImageQueueManage.single.callBacks.append(dic)
    }
    
    /// 查找队列是否已存在相同url的操作，存在将停止
    /// - Parameter opration。
    func stopLastOpration(opration:BWDownloadOpration) {
        let downQuere = BWImageQueueManage.single.downQueue
        var ishave = false
        for  op in downQuere.operations {
            if let bwOp = op as? BWDownloadOpration {
                if opration.url == bwOp.url {
                    ishave = true
                }
            }
        }
        if ishave == false {
            downQuere.addOperation(opration)
        }
    }
}
