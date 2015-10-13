//
//  DetailsCell.swift
//  SoGank
//
//  Created by ule_shengyangyu on 15/10/12.
//  Copyright © 2015年 ule_shengyangyu. All rights reserved.
//

import UIKit
import Foundation

class DetailsCell: UITableViewCell {

    var title: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        title = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(entity: SGBaseEntiy) -> Void {
        let titleString = entity.desc
        if titleString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0 {
            title.text = titleString
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
