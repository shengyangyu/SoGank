//
//  DetailsCell.swift
//  SoGank
//
//  Created by ule_shengyangyu on 15/10/12.
//  Copyright © 2015年 ule_shengyangyu. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class DetailsCell: UITableViewCell {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //detailImage = UIImageView.init()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        //detailImage = UIImageView.init()
        super.init(coder: aDecoder)
    }
    
    func bindData(entity: SGBaseEntiy) -> Void {
        self.detailImage.hidden = false;
        self.textLabel?.text = ""
        let urlString = entity.url
        if urlString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0 {
            if let url = NSURL(string: urlString) {
                detailImage.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: nil, completionHandler: {
                    /*[weak self]*/(image, error, cacheType, imageURL) -> () in
                    /*UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
                        self?.detailImage.alpha = 1
                        }, completion: nil)*/
                    })
            }
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
