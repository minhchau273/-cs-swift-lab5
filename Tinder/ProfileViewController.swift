//
//  ProfileViewController.swift
//  Tinder
//
//  Created by Chau Vo on 7/14/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    var photoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if photoImage != nil {
            photoImageView.image = photoImage
        }
    }
    
    @IBAction func onNavigationBarTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
