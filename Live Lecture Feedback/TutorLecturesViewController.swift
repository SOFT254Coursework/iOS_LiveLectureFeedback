//
//  TutorLecturesViewController.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 31/03/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TutorLecturesViewController: UITableViewController {

    @IBOutlet weak var tutorLecturesExitOutlet: UIButton!
    @IBOutlet weak var tutorLecturesCreateOutlet: UIButton!
    
    var staffId: String!
    
    var ref: FIRDatabaseReference?
    
    var totalSessions: Int = 0
    var sessions = [NSDictionary]()
    var sessionIds = [String]()
    
    var selectedSessionId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.plain, target: self, action:#selector(addTouched) )
        
        ref = FIRDatabase.database().reference()
        updateList()
    }

    @IBAction func addTouched(_ sender: Any) {        
        self.performSegue(withIdentifier: "TutorCreateLecture", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        let formatter = ISO8601DateFormatter()
//        let now = Date()
        
//        ref?.child("sessions").observeSingleEvent(of: .value, with: { (snapshot) in
//            if snapshot.childrenCount != 0 {
//                for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
//                    let value = rest.value as? NSDictionary
//                    if value?["creator"] as? String ?? "" == self.staffId {
//                        let endTime = value?["end_time"] as? String ?? ""
//                        if endTime != "" {
//                            let result = formatter.date(from: endTime)! > now
//                            if result {
//                                self.totalSessions += 1
//                                let id = snapshot.key
//                                self.sessionIds.append(id)
//                                self.sessions.append(value!)
//                                print(self.totalSessions)
//                            } // end if result
//                        } // end if endTime != ""
//                    } // end if creator == staffId
//                } // end for
//            } // end if
//        })
        
        return totalSessions
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell", for: indexPath)
        
        let formatter = ISO8601DateFormatter()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let nextCell = cell as? LectureTableViewCell {
            let value = sessions[indexPath.row]
            nextCell.sessionId = sessionIds[indexPath.row]
            nextCell.sessionTitle.text = value["course_code"] as? String ?? ""
            
            let startTime = formatter.date(from: value["start_time"] as? String ?? "")
            let endTime = formatter.date(from: value["end_time"] as? String ?? "")
            
            nextCell.startDate.text = dateFormatter.string(from: startTime!)
            nextCell.endDate.text = dateFormatter.string(from: endTime!)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TutorCreateLecture" {
            let nextVC = segue.destination as! TutorCreateLectureViewController
            nextVC.staffId = staffId
        } else if segue.identifier == "ShowSession" {
            let nextVC = segue.destination as! TutorLectureStatusViewController
            nextVC.sessionID = selectedSessionId
        }
    }
    
    func updateList() {
        let formatter = ISO8601DateFormatter()
        let now = Date()
        
        ref?.child("sessions").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount != 0 {
                for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    let value = rest.value as? NSDictionary
                    if value?["creator"] as? String ?? "" == self.staffId {
                        let endTime = value?["end_time"] as? String ?? ""
                        if endTime != "" {
                            let result = formatter.date(from: endTime)! > now
                            if result {
                                self.totalSessions += 1
                                let id = rest.key
                                self.sessionIds.append(id)
                                self.sessions.append(value!)
                                print(self.totalSessions)
                            } // end if result
                        } // end if endTime != ""
                    } // end if creator == staffId
                } // end for
            } // end if
            self.tableView.reloadData()
        })
    }
}
