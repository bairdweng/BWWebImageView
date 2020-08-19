//
//  ExampleViewController.swift
//  BWWebImageView_Example
//
//  Created by bairdweng on 2020/8/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
    
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
    
    func example2() {
        let queue = DispatchQueue(label: "com.ffib.blog.initiallyInactive.queue", qos: .utility)
        queue.async {
            for i in 0..<5 {
                print(i)
            }
        }
        queue.async {
            for i in 5..<10 {
                print(i)
            }
        }
        queue.async {
            for i in 10..<15 {
                print(i)
            }
        }
    }
    
}
