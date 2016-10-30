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

  override func viewDidLoad() {
    super.viewDidLoad()
    draggableImageView.delegate = self
  }

  func draggableImageViewDidTapPhoto(_ draggableImageView: DraggableImageView) {
    let profileVC = ProfileViewController()
    profileVC.photoImage = draggableImageView.photoImageView.image
    present(profileVC, animated: true, completion: nil)
  }

}
