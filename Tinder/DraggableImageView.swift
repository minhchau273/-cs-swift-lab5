//
//  DraggableImageView.swift
//  Tinder
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import UIKit

class DraggableImageView: UIView {

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var photoImageView: UIImageView!

  var initialPhotoCenter: CGPoint!

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
      default:
        break
      }
    }
  }

}
