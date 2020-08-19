//
//  TestTableViewCell.swift
//  BWWebImageView_Example
//
//  Created by bairdweng on 2020/8/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import BWWebImageView
class TestTableViewCell: UITableViewCell {
    @IBOutlet weak var faceImageView: UIImageView!
    var url:String? {
        didSet {
            faceImageView.bw_setUrl(url: url ?? "")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
