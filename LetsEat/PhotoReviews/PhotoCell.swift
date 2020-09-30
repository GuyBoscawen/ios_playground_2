//
//  PhotoCell.swift
//  LetsEat
//
//  Created by Guy  Boscawen on 27/06/2020.
//  Copyright © 2020 Guy  Boscawen. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imgReview: UIImageView!
}

extension PhotoCell {
    func set(image: UIImage) {
        imgReview.image = image
        roundedCorners()
    }
    
    func roundedCorners() {
        imgReview.layer.cornerRadius = 9
        imgReview.layer.masksToBounds = true
    }
}
