//
//  CardsViewController.swift
//  Tinder
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

  @IBOutlet weak var photoImageView: UIImageView!

  var initialPhotoCenter: CGPoint!

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  @IBAction func onPhotoPanGesture(sender: UIPanGestureRecognizer) {
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
