//
//  StudentSessionViewController.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 31/03/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SessionViewController: UIViewController {

    @IBOutlet weak var lbl_courseCode: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var btn_submit: UIButton!
    
    var sessionId: String!
    var courseCode: String!
    var sessionTitle: String!
    var studentId: String!
    
    var question = false
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbl_courseCode.text = courseCode
        lbl_title.text = sessionTitle
        
        ref = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSubmitClick(_ sender: Any) {
        if !question {
            question = true
            btn_submit.setImage(#imageLiteral(resourceName: "RedButtonPressed"), for: UIControlState.normal)
            
            ref.child("participants/\(sessionId)/\(studentId)").setValue(["question": true])
        } else {
            question = false
            btn_submit.setImage(#imageLiteral(resourceName: "RedButton"), for: UIControlState.normal)
            
            ref.child("participants/\(sessionId)/\(studentId)").setValue(["question": false])
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
