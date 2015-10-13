//
//  GanksCell.swift
//  SoGank
//
//  Created by ule_shengyangyu on 15/10/12.
//  Copyright © 2015年 ule_shengyangyu. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

class GanksCell: UICollectionViewCell {
    var imageView: UIImageView
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        imageView = UIImageView()
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.alpha = 0
    }
    
    func commonInit() -> Void {
        self.clipsToBounds = false
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.shadowColor = UIColor(red: 187 / 255.0, green: 187 / 255.0, blue: 187 / 255.0, alpha: 0.7).CGColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSizeMake(2, 6)
        
        self.imageView.clipsToBounds = true
        self.imageView.frame = self.bounds
        self.imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.imageView.contentMode = .ScaleAspectFill
        self.addSubview(self.imageView)
    }
    
    func bindData(entity: SGBaseEntiy) -> Void {
        let urlString = entity.url
        if urlString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0 {
            if let url = NSURL(string: urlString) {
                self.imageView.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: nil, completionHandler: {
                    [weak self](image, error, cacheType, imageURL) -> () in
                    UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
                        self?.imageView.alpha = 1
                        }, completion: nil)
                    })
            }
        }
    }
}
