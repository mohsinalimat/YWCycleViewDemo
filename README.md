####前言
公司新项目采用Swift3.0开发，以前自己用的是OC 封装的，现在用不了，从github上拉下来的好像不行，都是以前老版本的，还要自己做版本提升，索性自己封装一个轮播，很多的轮播实现都是基于ScrollView水平添加多个ImageView实现，个人觉的不是很好，因为如果要播放的轮播图太多的话，这种方法会导致一次性创建多个ImageView,占用内存，所以推荐CollectionView。效果图如下：
![TextKitDemo1.gif](http://upload-images.jianshu.io/upload_images/2240549-47070dbe92fdb1fa.gif?imageMogr2/auto-orient/strip)


####使用说明
一切都在代码中，创建控件

```
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
    
```

模拟请求数据：

``` 
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
```
点击事件代理回调：

```
extension ViewController: YWCycleViewDelegate {
    func cycleViewDidSelected(cycleView: YWCycleView, selectedIndex: NSInteger) {
        print("打印了\(selectedIndex)")
    }
} 
```
这样一个轮播模块就完成了

####结语
只是展示如何使用的代码，有兴趣的同学欢迎去我的github下载相对应的代码Demo，如果觉得还行，可以放在以后项目中使用。如果代码哪里有问题，欢迎指教~~~~
ps:因为时间关系，很多属性来不及封装，我会在有时间的时候，多封装几种样式的。

####用到的三方
* SDWebImage (近期换掉)
