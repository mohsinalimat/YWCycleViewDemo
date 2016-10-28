//
//  ViewController.swift
//  YWCycleViewDemo
//
//  Created by 姚巍 on 16/10/26.
//  Copyright © 2016年 Guangxi City Network Technology Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var tableView = UITableView()
    lazy var modelMArr = [YWCycleModel]()
    var cycleView : YWCycleView?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        cycleView = YWCycleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
        guard let cycleView = cycleView else {
            return
        }
        cycleView.delegate = self
        tableView.tableHeaderView = cycleView
        requestData()
    }
    
    func requestData() {
        let tempArr = [["title":"中国奥运军团三金回顾","imageUrl":"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg"],
                       ["title":"《封神传奇》进世界电影特效榜单？山寨的!","imageUrl":"http://imgstore.cdn.sogou.com/app/a/100540002/503008.png"],
                       ["title":"奥运男子4x100自由泳接力 菲尔普斯","imageUrl":"http://i1.hexunimg.cn/2014-08-15/167580248.jpg"],
                       ["title":"顶住丢金压力 孙杨晋级200自决赛","imageUrl":"http://pic6.huitu.com/res/20130116/84481_20130116142820494200_1.jpg"]];
        for dic in tempArr {
            let model = YWCycleModel()
            model.imageStr = dic["imageUrl"]
            model.title = dic["title"]
            modelMArr.append(model)
        }
        guard let cycleView = cycleView else {
            return
        }
        cycleView.dataArr = modelMArr
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "哈哈哈\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension ViewController: YWCycleViewDelegate {
    func cycleViewDidSelected(cycleView: YWCycleView, selectedIndex: NSInteger) {
        print("打印了\(selectedIndex)")
    }
}
