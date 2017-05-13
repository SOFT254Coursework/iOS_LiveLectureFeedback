//
//  TextEntryCell.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 13/05/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit

class TextEntryCell: UITableViewCell {

    @IBOutlet weak var dataEntryTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func dataEntryTextField(_ sender: Any) {
    }

}
