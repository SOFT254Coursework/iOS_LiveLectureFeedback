//
//  SignUpViewController.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 31/03/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txt_sessionId: UITextField!
    
    let limitLength = 6
    
    var ref: FIRDatabaseReference!
    
    var sessionId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txt_sessionId.delegate = self
        
        ref = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSubmitTouchDown(_ sender: Any) {
        guard let sId = txt_sessionId.text, !sId.isEmpty else {
            return
        }
        
        sessionId = sId
        
        signUpSession(sessionId: sId)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let newLength = text.characters.count + string.characters.count - range.length
        
        return newLength <= limitLength
    }
    
    private func signUpSession(sessionId : String) {
        ref.child("sessions").child(sessionId).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            print(value!)
            self.performSegue(withIdentifier: "SIGNIN", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SIGNIN") {
            let nextVC = segue.destination as! SessionViewController
            nextVC.sessionId = sessionId
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
