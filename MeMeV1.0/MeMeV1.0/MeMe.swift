//
//  MeMe.swift
//  MeMeV1.0
//
//  Created by Ohud Alessa on 06/11/2018.
//  Copyright © 2018 OHUD. All rights reserved.
//

import Foundation
import UIKit

struct MeMe {
    
    var original: UIImage
    var topTxt: String
    var bottomTxt: String
    var memedImage: UIImage
    
    init(_ original: UIImage, _ topTxt: String, _ bottomTxt: String, _ memedImage: UIImage) {
        self.original = original
        self.topTxt = topTxt
        self.bottomTxt = bottomTxt
        self.memedImage = memedImage
    }
}
