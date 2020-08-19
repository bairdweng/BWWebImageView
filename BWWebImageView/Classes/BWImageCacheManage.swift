//
//  BWImageCacheManage.swift
//  BWWebImageView
//
//  Created by bairdweng on 2020/8/18.
//

import UIKit

class BWImageCacheManage: NSObject {
    static let fileNameKey = "BWIMAGECACHEMANAGECACRACH"
    /// 获取图片的缓存
    /// - Parameter url: 图片的URL
    /// - Returns: 图片data
    static func getCache(url:String,callBack: @escaping(_ data:Data?)->Void) {
        /// 获取文件名
        let readWork = DispatchWorkItem{
            if let fileName = getFileName(url: url) {
                let filePath = getFilePath(fileName: fileName)
                do {
                    print("图片正在读取")
                    let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
                    callBack(data)
                } catch _ {
                    print("读取失败")
                    callBack(nil)
                }
            }
            else {
                print("url为空")
                callBack(nil)
            }
        }
        BWImageQueueManage.single.readWriteQueue.async(execute: readWork)
    }
    
    static func getFileName(url:String)->String? {
        let fileName = UserDefaults.standard.object(forKey: url) as? String
        return fileName
    }
    
    /// 保存图片
    /// - Parameters:
    ///   - url: url作为key
    ///   - data: data
    static func saveData(url:String,data:Data) {
        let fileName = "\(NSDate().timeIntervalSince1970).png"
        let home = NSHomeDirectory() as NSString
        let docPath = home.appendingPathComponent("Documents") as NSString
        let filePath = docPath.appendingPathComponent(fileName)
        UserDefaults.standard.set(fileName, forKey: url)
        /// 写入隔离，文件写入的时候不允许读
        let writeWorkItem = DispatchWorkItem(flags:.barrier) {
            do {
                print("图片正在写入")
                try data.write(to: URL(fileURLWithPath: filePath), options: .atomic)
            } catch let err {
                print("=====\(err)")
            }
        }
        BWImageQueueManage.single.readWriteQueue.async(execute: writeWorkItem)
    }
    
    static func getFilePath(fileName:String)->String {
        let home = NSHomeDirectory() as NSString
        let docPath = home.appendingPathComponent("Documents") as NSString
        let filePath = docPath.appendingPathComponent(fileName)
        return filePath
    }
}
