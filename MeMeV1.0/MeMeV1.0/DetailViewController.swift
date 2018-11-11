//
//  DetailView.swift
//  MeMeV1.0
//
//  Created by Ohud Alessa on 06/11/2018.
//  Copyright © 2018 OHUD. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    var meme: MeMe!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme.memedImage
        imageView.contentMode = .scaleAspectFit
        self.tabBarController?.tabBar.isHidden = true
    }
}
