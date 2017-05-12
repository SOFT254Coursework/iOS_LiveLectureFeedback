//
//  LectureTableViewCell.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 12/05/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit

class LectureTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
