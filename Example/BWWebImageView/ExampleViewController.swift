//
//  ExampleViewController.swift
//  BWWebImageView_Example
//
//  Created by bairdweng on 2020/8/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
    var ticket = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickOntheReadBarrier(_ sender: Any) {
        let queue = DispatchQueue(label: "com.ffib.blog.queue", qos: .utility, attributes: .concurrent)
        let path = NSHomeDirectory() + "/test.txt"
        print(path)
        
        let readWorkItem = DispatchWorkItem {
            do {
                let str = try String(contentsOfFile: path, encoding: .utf8)
                print(str)
            }catch {
                print(error)
            }
        }
        /// barrier判断读的时候是否有线程写入，有的话将暂停
        let writeWorkItem = DispatchWorkItem(flags: .barrier) {
            do {
                try "12312313".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                print("write")
            }catch {
                print(error)
            }
        }
        for _ in 0..<3 {
            queue.async(execute: readWorkItem)
        }
        queue.async(execute: writeWorkItem)
        for _ in 0..<3 {
            queue.async(execute: readWorkItem)
        }
    }
    
    @IBAction func clickOntheLock(_ sender: Any) {
        for i in 0...200 {
            buyTicket(userName: "hello\(i)")
        }
    }
    func buyTicket(userName: String) {
        DispatchQueue.global().async {
            objc_sync_enter(self.ticket)
            let count = self.ticket - 1
            self.ticket = count
            objc_sync_exit(self.ticket)
            print("\(userName)买了一张票，剩余票数\(self.ticket)")
        }
    }
}
