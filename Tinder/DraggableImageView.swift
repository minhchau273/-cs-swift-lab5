//
//  DraggableImageView.swift
//  Tinder
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import UIKit

@objc protocol DraggableImageViewDelegate {
  optional func draggableImageViewDidTapPhoto(draggableImageView: DraggableImageView)
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
    nib.instantiateWithOwner(self, options: nil)
    contentView.frame = bounds
    addSubview(contentView)
  }

  @IBAction func onPhotoPanGesture(sender: UIPanGestureRecognizer) {
    if let view = superview {
      let state = sender.state
      let translation = sender.translationInView(view)

      switch state {
      case .Began:
        initialPhotoCenter = photoImageView.center

      case .Changed:
        photoImageView.center = CGPoint(x: initialPhotoCenter.x + translation.x, y: initialPhotoCenter.y)

        var angle = CGFloat(M_PI) * translation.x / 304
        let dragInBottomHalf = sender.locationInView(self).y > initialPhotoCenter.y
        angle = dragInBottomHalf ? -angle : angle

        photoImageView.transform = CGAffineTransformMakeRotation(angle)

      case .Ended:
        if translation.x > -50 && translation.x < 50 {
          photoImageView.center = initialPhotoCenter
          photoImageView.transform = CGAffineTransformIdentity
        } else {
          let outScreenX = translation.x >= 50 ? photoImageView.center.x + 304 : photoImageView.center.x - 304

          UIView.animateWithDuration(0.5, animations: {
            self.photoImageView.alpha = 0
            self.photoImageView.center = CGPoint(x: outScreenX, y: self.photoImageView.center.y)
            }, completion: { finished in
              self.photoImageView.center = self.initialPhotoCenter
              self.photoImageView.transform = CGAffineTransformIdentity
              self.photoImageView.alpha = 1
          })
        }

      default:
        break
      }
    }
  }

  @IBAction func onPhotoTapped(sender: UITapGestureRecognizer) {
    delegate?.draggableImageViewDidTapPhoto?(self)
  }

}
