//
//  YWCycleView.swift
//  CarouselView(轮播图)
//
//  Created by yao wei on 16/10/25.
//  Copyright © 2016年 yao wei. All rights reserved.
//

import UIKit
import SDWebImage
@objc protocol YWCycleViewDelegate: NSObjectProtocol {
   func cycleViewDidSelected(cycleView: YWCycleView, selectedIndex: NSInteger)
}

private let CycleViewCell = "YWCycleViewCell"
class YWCycleView: UIView {
    weak var delegate: YWCycleViewDelegate?
    lazy var collectionView = UICollectionView()
    var dataArr: [YWCycleModel]?{
        didSet {
            addPageControl()
        }
    }
    fileprivate lazy var pageControl = UIPageControl()
    fileprivate var timer: Timer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    fileprivate func setupUI(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.register(YWCycleViewCell.self, forCellWithReuseIdentifier: CycleViewCell)
    }
    
    func addPageControl() {
        collectionView.scrollToItem(at: IndexPath.init(row: 0, section: 5000), at: .right, animated: false)
        pageControl = UIPageControl(frame: CGRect(x: 0, y: bounds.height - 20, width: bounds.width, height: 20))
        guard let dataArr = dataArr else {
            return
        }
        pageControl.numberOfPages = dataArr.count
        pageControl.isUserInteractionEnabled = false
        
        guard let path = Bundle.main.path(forResource: "YWCycleViewBundle", ofType: "bundle"),
            let bundle = Bundle(path: path) else{
                return
        }
        let pageControlSelectedImage = UIImage(named: "mn_pageControl_selected", in: bundle, compatibleWith: nil)
        let pageControlImage = UIImage(named: "mn_pageControl", in: bundle, compatibleWith: nil)
        pageControl.setValue(pageControlSelectedImage, forKey: "_currentPageImage")
        pageControl.setValue(pageControlImage, forKey: "_pageImage")
        addSubview(pageControl)
        beginScroll()
    }
    
    func beginScroll() {
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollAction), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollAction() {
        guard let cell = collectionView.visibleCells.first as? YWCycleViewCell,
        let currentIndexPath = collectionView.indexPath(for: cell) else {
            return
        }
        var section = currentIndexPath.section
        var item = currentIndexPath.item + 1
        guard let dataArr = dataArr else {
            return
        }
        
        if item == dataArr.count {
            section += 1
            item = 0
        }
        collectionView.scrollToItem(at: IndexPath.init(row: item, section: section), at: .right, animated: true)
        pageControl.currentPage = item
    }
}

// MARK: - scrollViewDelegate
extension YWCycleView {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        guard let dataArr = dataArr else {
            return
        }
        let page = NSInteger((scrollView.contentOffset.x / bounds.width)) % dataArr.count
        pageControl.currentPage = page
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let dataArr = dataArr else {
            return
        }
        
        let page = NSInteger((scrollView.contentOffset.x / bounds.width)) % dataArr.count
        pageControl.currentPage = page
        beginScroll()
    }
}


// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension YWCycleView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataArr = dataArr else {
            return 0
        }
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleViewCell, for: indexPath) as! YWCycleViewCell
        guard let dataArr = dataArr else {
            return UICollectionViewCell()
        }
        let cycleModel = dataArr[indexPath.row]
        if let imageStr = cycleModel.imageStr {
            cell.imageView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "placeHolder"))
        }
        cell.titleLab.text = cycleModel.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleViewDidSelected(cycleView: self, selectedIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
