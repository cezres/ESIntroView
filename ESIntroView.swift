//
//  ESIntroView.swift
//  ESIntroViewDemo
//
//  Created by 翟泉 on 16/3/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

import UIKit

class ESIntroView: UIScrollView, UIScrollViewDelegate {
    let views: [UIView]
    var currentIndex: Int = 0 {
        didSet {
            if currentIndex < views.count {
                pageControl.currentPage = currentIndex
            }
        }
    }
    
    var pageControl = UIPageControl()
    
    init(views: [UIView]) {
        self.views = views
        super.init(frame: UIScreen.mainScreen().bounds)
        UIApplication.sharedApplication().delegate!.window!!.windowLevel = UIWindowLevelAlert
        
        backgroundColor = UIColor.whiteColor()
        pagingEnabled = true
        contentSize = CGSizeMake(frame.width * CGFloat(views.count+1), 0)
        delegate = self
        
        for (index, view) in views.enumerate() {
            view.frame = CGRectMake(frame.width * CGFloat(index), 0, frame.width, frame.height)
            addSubview(view)
        }
        
        let view = UIView(frame: CGRectMake(frame.width * CGFloat(views.count), 0, frame.width, frame.height))
        addSubview(view)
        
        pageControl.frame = CGRectMake((frame.width-100)/2, frame.height-20-10, 100, 20)
        pageControl.numberOfPages = views.count
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        UIApplication.sharedApplication().delegate!.window!!.windowLevel = UIWindowLevelNormal
        print(classForCoder, __FUNCTION__)
        pageControl.removeFromSuperview()
    }
    
    override func didMoveToSuperview() {
        if superview != nil {
            superview?.addSubview(pageControl)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        currentIndex = Int(contentOffset.x / frame.width)
        if currentIndex == views.count {
            removeFromSuperview()
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let index = Int(contentOffset.x / frame.width)
        if index == views.count-1 {
            alpha = 1.0 - ((contentOffset.x - frame.width * CGFloat(index)) / frame.width)
        }
    }
    
}
