//
//  YWCycleViewCell.swift
//  CarouselView(轮播图)
//
//  Created by yao wei on 16/10/25.
//  Copyright © 2016年 yao wei. All rights reserved.
//

import UIKit
private let KMargin = CGFloat(8)
class YWCycleViewCell: UICollectionViewCell {
    
    /// 轮播图片
    lazy var imageView = UIImageView()
    /// 轮播标题
    lazy var titleLab = UILabel()
    
    var cycleModel: YWCycleModel? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:bounds.width , height: bounds.height))
        addSubview(imageView)
        
        titleLab = UILabel(frame: CGRect(x: KMargin, y: bounds.height - 50, width: bounds.width - 2*KMargin, height: 30))
        titleLab.backgroundColor = UIColor.black
        titleLab.tag = 2
        titleLab.textColor = UIColor.white
        titleLab.textAlignment = .center
        titleLab.font = UIFont.systemFont(ofSize: 15)
        titleLab.alpha = 0.6
        addSubview(titleLab)
    }
}
