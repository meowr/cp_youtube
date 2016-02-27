//
//  ViewController.swift
//  youtube
//
//  Created by Tina Chen on 2/25/16.
//  Copyright © 2016 tinachen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var feedView: UIView!
    
    var menuViewController: UIViewController!
    var feedViewController: UIViewController!
    
    var feedOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var menuViewController = storyboard.instantiateViewControllerWithIdentifier("menuView")
        var feedViewController = storyboard.instantiateViewControllerWithIdentifier("feedView")
        addChildViewController(menuViewController)
        addChildViewController(feedViewController)
        menuView.addSubview(menuViewController.view)
        feedView.addSubview(feedViewController.view)
        menuViewController.didMoveToParentViewController(self)
        feedViewController.didMoveToParentViewController(self)
        menuView.transform = CGAffineTransformMakeScale(0.9, 0.9)
        setAnchorPoint(CGPoint(x: 1.5, y: 0.5), forView: feedView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)

        if sender.state == UIGestureRecognizerState.Began {
        } else if sender.state == UIGestureRecognizerState.Changed {
            var scale = convertValue(translation.x, r1Min: 0, r1Max: 320, r2Min: 0.9, r2Max: 1)
            menuView.transform = CGAffineTransformMakeScale(scale, scale)
            var rotate = convertValue(translation.x, r1Min: 0, r1Max: 280, r2Min: 0, r2Max: 45)
            var transform = CATransform3DIdentity;
            transform.m34 = 1.0 / 500.0;
            transform = CATransform3DRotate(transform, CGFloat(Double(rotate) * M_PI/180), 0, 1, 0)
            feedView.layer.transform = transform

        } else if sender.state == UIGestureRecognizerState.Ended {
            var transform = CATransform3DIdentity;
            transform.m34 = 1.0 / 500.0;
            transform = CATransform3DRotate(transform,0, 0, 1, 0)
            var animation = CABasicAnimation(keyPath: "transform")
            animation.toValue = NSValue(CATransform3D: transform)
            animation.duration = 0.5
            feedView.layer.addAnimation(animation, forKey: "transform")
//            delay(0.5, closure: { () -> () in
//                self.feedView.layer.transform = transform
//            })
        }
    }

}

