//
//  TutorLectureStatusViewController.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 31/03/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TutorLectureStatusViewController: UIViewController {
    
    var status: Bool!
    var sessionID : String!
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_sessionId: UILabel!
    @IBOutlet weak var lbl_courseCode: UILabel!
    
    @IBOutlet weak var btn_start: UIButton!
    @IBOutlet weak var btn_reset: UIButton!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        status = false

        lbl_sessionId.text = sessionID
        lbl_status.text = "Inactive"
        
        ref = FIRDatabase.database().reference()
        
        ref.child("sessions").child(sessionID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value
            self.status = (value as AnyObject)["running"] as! Bool
            if self.status {
                self.btn_start.isEnabled = false
                self.lbl_status.text = "On going"
            }
            self.lbl_courseCode.text = (value as AnyObject)["course_code"] as? String ?? ""
            self.lbl_title.text = (value as AnyObject)["title"] as? String ?? ""
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func start(_ sender: Any) {
        status = true
        btn_start.isEnabled = false
        lbl_status.text = "On going"
        print(sessionID)
        ref.child("sessions").child(sessionID).child("running").setValue(true)
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
