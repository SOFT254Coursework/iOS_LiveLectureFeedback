//
//  ViewController.swift
//  Live Lecture Feedback
//
//  Created by Wing Chau on 24/3/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txt_id: UITextField!
    @IBOutlet weak var txt_pwd: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    
    var sessions: [NSDictionary]?
    var totalSessions: Int!
    
    //TODO: Get rid of this
    @IBAction func doUITest(_ sender: Any) {
        self.performSegue(withIdentifier: "TutorLogin", sender: self)
        
    }
    
    let limitLength = 8
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            print ("Application logged in anonymously with uid " + user!.uid)
        })
        
        txt_id.delegate = self
        txt_pwd.delegate = self
        
        ref = FIRDatabase.database().reference()
        totalSessions = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isEqual(txt_id) {
            guard let text = textField.text else {
                return true
            }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= limitLength
        }
        return true
    }
    
    @IBAction func onLoginTouchDown(_ sender: Any) {
        guard let id = txt_id.text, !id.isEmpty else {
            return
        }
        guard let pwd = txt_pwd.text, !pwd.isEmpty else {
            return
        }
        
        
        ref.child("users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if pwd == value?["pwd"] as? String ?? "" {
                let userType = value?["type"] as? String ?? ""
                
                switch userType {
                case "staff":
                    
                    let formatter = ISO8601DateFormatter()
                    let now = Date()
                    
                    self.ref.child("sessions").observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.childrenCount != 0 {
                            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                                let value = rest.value as? NSDictionary
                                if value?["creator"] as? String ?? "" == id {
                                    let endTime = value?["end_time"] as? String ?? ""
                                    if endTime != "" {
                                        let result = formatter.date(from: endTime)! > now
                                        if result {
                                            self.totalSessions! += 1
                                            self.sessions?.append(value!)
                                            print(self.totalSessions)
                                        } // end if result
                                    } // end if endTime != ""
                                } // end if creator == staffId
                            } // end for
                        } // end if
                        
                        self.performSegue(withIdentifier: "StaffLogin", sender: self)
                    })
                case "student":
                    self.performSegue(withIdentifier: "StudentLogin", sender: self)
                default:
                    return
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StudentLogin" {
            let nextVC = segue.destination as! SignUpViewController
            nextVC.studentId = txt_id.text
        } else if segue.identifier == "StaffLogin" {
            let nextVC = segue.destination as! TutorLecturesViewController
            nextVC.staffId = txt_id.text
            nextVC.sessions = sessions
            nextVC.totalSessions = totalSessions
        }
    }
}
