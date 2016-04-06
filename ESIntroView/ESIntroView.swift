//
//  ESIntroView.swift
//  ESIntroViewDemo
//
//  Created by 翟泉 on 16/3/28.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

import UIKit


public class ESIntroView: UIScrollView, UIScrollViewDelegate {
    let views: [UIView]
    public var currentIndex: Int = 0 {
        didSet {
            if currentIndex < views.count {
                pageControl.currentPage = currentIndex
            }
        }
    }
    
    var pageControl = UIPageControl()
    
    public init(views: [UIView]) {
        self.views = views
        super.init(frame: UIScreen.mainScreen().bounds)
        
        UIApplication.sharedApplication().delegate!.window!!.windowLevel = UIWindowLevelAlert
        
        backgroundColor                = UIColor.blackColor()
        pagingEnabled                  = true
        showsHorizontalScrollIndicator = false
        contentSize                    = CGSizeMake(frame.width * CGFloat(views.count+1), 0)
        delegate                       = self

        let pageControlWidth           = CGFloat(15 * views.count) + 20
        pageControl.frame.size         = CGSize(width: pageControlWidth, height: 20)
        pageControl.numberOfPages      = views.count
        pageControl.backgroundColor    = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        pageControl.layer.cornerRadius = 10
        
        for (index, view) in views.enumerate() {
            addSubview(view)
        }
        let view = UIView(frame: CGRectMake(frame.width * CGFloat(views.count), 0, frame.width, frame.height))
        addSubview(view)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        UIApplication.sharedApplication().delegate!.window!!.windowLevel = UIWindowLevelNormal
        pageControl.removeFromSuperview()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        frame              = UIScreen.mainScreen().bounds
        
        pageControl.center = CGPoint(x: frame.width/2, y: frame.height-20)
        
        for (index, view) in views.enumerate() {
            view.frame = CGRectMake(frame.width * CGFloat(index), 0, frame.width, frame.height)
        }
        
    }
    
    override public func didMoveToSuperview() {
        if superview != nil {
            superview?.addSubview(pageControl)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        currentIndex = Int(contentOffset.x / frame.width)
        if currentIndex == views.count {
            removeFromSuperview()
        }
    }
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let index = Int(contentOffset.x / frame.width)
        if index == views.count-1 {
            alpha = 1.0 - ((contentOffset.x - frame.width * CGFloat(index)) / frame.width)
        }
    }
    
}
