//
//  ViewController.swift
//  animation-first
//
//  Created by Hiromasa Nagamine on 5/24/15.
//  Copyright (c) 2015 hiro nagami. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var largeButton: UIButton!
    var smallButton: UIButton!
    var deleteButton: UIButton!
    var moveButton: UIButton!
    
    var buttonsAreaView: UIView!
    var animationAreaView: UIView?
    var animationView: UIView?
    
    static let screenSizeWidth: CGFloat = UIScreen.mainScreen().bounds.width

    let animationAreaWidth: CGFloat = ViewController.screenSizeWidth
    let animationAreaHeight: CGFloat = 300

    let buttonsAreaOriginY: CGFloat = 302
    let buttonsAreaWidth: CGFloat = ViewController.screenSizeWidth
    let buttonsAreaHeight: CGFloat = 300
    
    let buttonWidth: CGFloat = (ViewController.screenSizeWidth - 6) / 2
    let buttonHeight: CGFloat = 70
    
    let animationViewTag = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureButtons()
        configureAnimationView()
    }
    
    func configureButtons()
    {
        largeButton = UIButton(frame: CGRectMake(2, 2, buttonWidth, buttonHeight))
        largeButton.backgroundColor = .lightGrayColor()
        largeButton.setTitle("Large", forState: .Normal)
        largeButton.addTarget(self, action: Selector("largeAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        smallButton = UIButton(frame: CGRectMake(largeButton.frame.maxX+2, 2, buttonWidth, buttonHeight))
        smallButton.backgroundColor = .lightGrayColor()
        smallButton.setTitle("Small", forState: .Normal)
        smallButton.addTarget(self, action: Selector("smallAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        deleteButton = UIButton(frame: CGRectMake(2, largeButton.frame.maxY+2, buttonWidth, buttonHeight))
        deleteButton.backgroundColor = .lightGrayColor()
        deleteButton.setTitle("Delete", forState: .Normal)
        deleteButton.addTarget(self, action: Selector("deleteAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        moveButton = UIButton(frame: CGRectMake(largeButton.frame.maxX+2, largeButton.frame.maxY+2, buttonWidth, buttonHeight))
        moveButton.backgroundColor = .lightGrayColor()
        moveButton.setTitle("Move", forState: .Normal)
        moveButton.addTarget(self, action: Selector("moveAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        buttonsAreaView = UIView(frame: CGRectMake(0, buttonsAreaOriginY, buttonsAreaWidth, buttonsAreaHeight))
        
        buttonsAreaView.addSubview(largeButton)
        buttonsAreaView.addSubview(smallButton)
        buttonsAreaView.addSubview(deleteButton)
        buttonsAreaView.addSubview(moveButton)
        
        view.addSubview(buttonsAreaView)
    }
    
    func configureAnimationView()
    {
        if let _animationAreaView = animationAreaView {
            animationView?.removeFromSuperview()
            animationView = makeAnimationView()
            _animationAreaView.addSubview(animationView!)
        }
        else {
            animationAreaView = UIView(frame: CGRectMake(0, 0, animationAreaWidth, animationAreaHeight))
            animationAreaView!.layer.borderColor = UIColor.greenColor().CGColor
            animationAreaView!.layer.borderWidth = 1
            
            animationView = makeAnimationView()
            
            animationAreaView!.addSubview(animationView!)
            
            view.addSubview(animationAreaView!)
        }
    }
    
    func makeAnimationView() -> UIView! {
        var animationView = UIView(frame: CGRectMake(0, 0, 100, 100))
        animationView.backgroundColor = UIColor.blueColor()
        animationView.center = CGPointMake(animationAreaView!.bounds.size.width / 2, animationAreaView!.bounds.size.height / 2)
        animationView.tag = animationViewTag
        return animationView
    }
    
    func largeAction()
    {
        if let _animationView = animationView {
            var viewCenter = _animationView.center
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                _animationView.frame.size.width = _animationView.frame.size.width * 2
                _animationView.frame.size.height = _animationView.frame.size.height * 2
                _animationView.center = viewCenter
            }) { (isTrue) -> Void in
                self.configureAnimationView()
            }
        }
    }

    func smallAction()
    {
        if let _animationView = animationView {
            var viewCenter = _animationView.center
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                _animationView.frame.size.width = _animationView.frame.size.width / 2
                _animationView.frame.size.height = _animationView.frame.size.height / 2
                _animationView.center = viewCenter
                }) { (isTrue) -> Void in
                    self.configureAnimationView()
            }
        }
    }

    func deleteAction()
    {
        if animationView != nil {
            var viewCenter = self.animationView!.center
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.animationView!.alpha = 0
                }) { (isTrue) -> Void in
                    self.animationView?.removeFromSuperview()
                    self.animationView = nil
                    self.deleteButton.setTitle("Add", forState: .Normal)
            }
        }
        else {
            configureAnimationView()
            self.deleteButton.setTitle("Delete", forState: .Normal)
        }
    }
    
    func moveAction()
    {
        if let _animationView = animationView {
            var viewCenter = _animationView.center
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                _animationView.frame.origin.x = 0
                _animationView.frame.origin.y = 0
                }) { (isTrue) -> Void in
                    self.configureAnimationView()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

