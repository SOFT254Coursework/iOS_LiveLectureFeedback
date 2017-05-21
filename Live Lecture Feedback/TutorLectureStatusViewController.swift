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
    var warningRate: Double!
    
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
                self.btn_start.titleLabel?.text = "Stop"
                self.lbl_status.text = "On going"
            }
            self.lbl_courseCode.text = (value as AnyObject)["course_code"] as? String ?? ""
            self.lbl_title.text = (value as AnyObject)["title"] as? String ?? ""
            self.warningRate = (value as AnyObject)["warning_rate"] as? Double ?? 0.0
        })
        
        ref.child("sessions").child(sessionID).observe(FIRDataEventType.value, with: { (snapshot) in
            let value = snapshot.value
            let participants = (value as AnyObject)["participants"] as! Int
            let question = (value as AnyObject)["question"] as! Int
            if (question != 0) && (participants != 0) {
                if Double(question) > (Double(participants) * self.warningRate) {
                    self.lbl_status.text = "\(question) out of \(participants) students got question"
                    self.lbl_status.textColor = UIColor.red
                }
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func start(_ sender: Any) {
        if (!status) {
            status = true
            lbl_status.text = "On going"
            btn_start.titleLabel?.text = "Stop"
            ref.child("sessions").child(sessionID).child("running").setValue(true)
        } else {
            status = false
            lbl_status.text = "Inactive"
            btn_start.titleLabel?.text = "Start"
            ref.child("sessions").child(sessionID).child("running").setValue(false)
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        ref.child("sessions").child(sessionID).child("question").setValue(0)
        lbl_status.textColor = UIColor.darkText
        lbl_status.text = "On going"
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
