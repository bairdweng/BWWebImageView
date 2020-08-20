//
//  ViewController.swift
//  BWWebImageView
//
//  Created by bairdweng on 08/17/2020.
//  Copyright (c) 2020 bairdweng. All rights reserved.
//

import UIKit
import BWWebImageView
import Kingfisher
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table_view_cell", for: indexPath) as! TestTableViewCell
        let url = indexPath.row % 2 == 0 ? dataSources[0] : dataSources[1]
        cell.url = url
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    var dataSources = [
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597678171120&di=9786b0feda3ad11df3e7a941068bedf1&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg",
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597678593054&di=ebd028b96d0fbd6db683f88dfebaf55b&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F20%2F56%2F19300001056606131348564606754.jpg"
    ];
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "table_view_cell")
        
    
        
        
//        KingfisherManager.shared.cache.removeImage(forKey: "")

        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickOntheStop(_ sender: Any) {
        BWImageQueueManage.single.cancelOperation()
    }
    
    @IBAction func clickOntheRef(_ sender: Any) {
        /// 刷新是手动取消之前的下载
        BWImageQueueManage.single.cancelOperation()
        tableView.reloadData()
    }
    @IBAction func clickOntheShowQueue(_ sender: Any) {
        let downQueue = BWImageQueueManage.single.downQueue.operationCount
        print("\(downQueue)")
    }
    
}

