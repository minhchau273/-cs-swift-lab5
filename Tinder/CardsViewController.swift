//
//  CardsViewController.swift
//  Tinder
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, DraggableImageViewDelegate {
    
    @IBOutlet weak var draggableImageView: DraggableImageView!
    
    var isPresenting: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        draggableImageView.delegate = self
    }
    
    func draggableImageViewDidTapPhoto(_ draggableImageView: DraggableImageView) {
        let profileVC = ProfileViewController()
        profileVC.photoImage = draggableImageView.photoImageView.image
        
        profileVC.modalPresentationStyle = UIModalPresentationStyle.custom
        profileVC.transitioningDelegate = self
        
        present(profileVC, animated: true, completion: nil)
    }
    
}

extension CardsViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // TODO: animate the transition in Step 3 below
        print("animating transition")
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
                fromViewController.view.removeFromSuperview()
            })
        }
    }
}
