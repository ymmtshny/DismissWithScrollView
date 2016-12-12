//
//  DismissAnimator.swift
//  ScrollBackVC
//
//  Created by Shinya Yamamoto on 2016/12/11.
//  Copyright © 2016年 plantio. All rights reserved.
//

import UIKit

class DismissAnimator : NSObject {
    
    
}

extension DismissAnimator : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {return}
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {return}
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
     
        
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromVC.view.frame = finalFrame
        }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
        
    }
}
