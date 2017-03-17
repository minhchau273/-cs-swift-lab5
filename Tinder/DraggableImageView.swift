//
//  DraggableImageView.swift
//  Tinder
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import UIKit

@objc protocol DraggableImageViewDelegate {
    @objc optional func draggableImageViewDidTapPhoto(_ draggableImageView: DraggableImageView)
}

class DraggableImageView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var initialPhotoCenter: CGPoint!
    weak var delegate: DraggableImageViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    @IBAction func onPhotoPanGesture(_ sender: UIPanGestureRecognizer) {
        if let view = superview {
            let state = sender.state
            let translation = sender.translation(in: view)
            
            switch state {
            case .began:
                initialPhotoCenter = photoImageView.center
                
            case .changed:
                photoImageView.center = CGPoint(x: initialPhotoCenter.x + translation.x, y: initialPhotoCenter.y)
                
                var angle = CGFloat(M_PI) * translation.x / 304
                let dragInBottomHalf = sender.location(in: self).y > initialPhotoCenter.y
                angle = dragInBottomHalf ? -angle : angle
                
                photoImageView.transform = CGAffineTransform(rotationAngle: angle)
                
            case .ended:
                if translation.x > -50 && translation.x < 50 {
                    photoImageView.center = initialPhotoCenter
                    photoImageView.transform = CGAffineTransform.identity
                } else {
                    let outScreenX = translation.x >= 50 ? photoImageView.center.x + 304 : photoImageView.center.x - 304
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self.photoImageView.alpha = 0
                        self.photoImageView.center = CGPoint(x: outScreenX, y: self.photoImageView.center.y)
                    }, completion: { finished in
                        self.photoImageView.center = self.initialPhotoCenter
                        self.photoImageView.transform = CGAffineTransform.identity
                        self.photoImageView.alpha = 1
                    })
                }
                
            default:
                break
            }
        }
    }
    
    @IBAction func onPhotoTapped(_ sender: UITapGestureRecognizer) {
        delegate?.draggableImageViewDidTapPhoto?(self)
    }
    
}
