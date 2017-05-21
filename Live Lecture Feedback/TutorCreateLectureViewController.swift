//
//  TutorCreateLectureViewController.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 31/03/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TutorCreateLectureViewController: UITableViewController {

    
    var sectionState = [false, false, false, false]
    
    @IBOutlet weak var tutorSetLectureCancelOutlet: UIButton!
    @IBOutlet weak var tutorSetLectureCreteOutlet: UIButton!
    
    var titleCell: TextEntryCell?
    var courseCodeCell : TextEntryCell?
    var startDateCell: dateTimeEntryCell?
    var endDateCell: dateTimeEntryCell?
    
    var staffId: String!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
    super.viewDidLoad()

        ref = FIRDatabase.database().reference()
    }  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionState[section] ? 2 : 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ident = ""
        let simpleTitleCell: SimpleTitleCell
        
        if (indexPath.row==0) {
            ident = "SimpleTitle"
            simpleTitleCell = tableView.dequeueReusableCell(withIdentifier: ident) as! SimpleTitleCell
            switch indexPath.section {
            case 0:
                simpleTitleCell.textLabel?.text = "Module Code"
            case 1:
                simpleTitleCell.textLabel?.text = "Session Title"
            case 2:
                simpleTitleCell.textLabel?.text = "Start"
            case 3:
                simpleTitleCell.textLabel?.text = "End"
            default:
                break
            }
            return simpleTitleCell
        } else {
            if indexPath.section == 0 {
                ident = "TextEntry"
                courseCodeCell = tableView.dequeueReusableCell(withIdentifier: ident) as? TextEntryCell
                return courseCodeCell!
            } else if indexPath.section == 1 {
                ident = "TextEntry"
                titleCell = tableView.dequeueReusableCell(withIdentifier: ident) as? TextEntryCell
                return titleCell!
            } else if indexPath.section == 2{
                ident = "DateTimeEntry"
                startDateCell = tableView.dequeueReusableCell(withIdentifier: ident) as? dateTimeEntryCell
                return startDateCell!
            } else {
                ident = "DateTimeEntry"
                endDateCell = tableView.dequeueReusableCell(withIdentifier: ident) as? dateTimeEntryCell
                return endDateCell!
            }
        } // end else
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row \(indexPath.row) in section \(indexPath.section)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        sectionState[indexPath.section] = !sectionState[indexPath.section]
        self.tableView.reloadData()
    }
    
    @IBAction func onSaveClick(_ sender: Any) {
        
        guard let courseCode = courseCodeCell?.dataEntryTextField.text, !courseCode.isEmpty else {
            return
        }
        guard let title = titleCell?.dataEntryTextField.text, !title.isEmpty else {
            return
        }
        guard let startTime = startDateCell?.dateTimePicker.date, startTime > Date() else {
            return
        }
        guard let endTime = endDateCell?.dateTimePicker.date, endTime > startTime else {
            return
        }
        
        ref.child("sessions").queryOrderedByKey().queryLimited(toLast: 1).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if value != nil {
                var lastSessionId: String = ""
                for key in (value?.allKeys)! {
                    lastSessionId = key as! String
                }
                let index = lastSessionId.index(lastSessionId.startIndex, offsetBy: 1)
                var char = lastSessionId.substring(to: index)
                var numbers = lastSessionId.substring(from: index)
                if numbers == "99999" {
                    char = self.nextLetter(char)!
                    numbers = "00000"
                } else {
                    let intValue = Int(numbers)! + 1
                    let tempNum = "\(intValue)"
                    var finalNum = tempNum
                    if tempNum.characters.count < 5 {
                        for _ in tempNum.characters.count ... 4 {
                            finalNum = "0" + finalNum
                        }
                        numbers = finalNum
                    } // end if
                } // end else
                let formatter = ISO8601DateFormatter()
                self.ref.child("sessions/\(char + numbers)").setValue([
                    "course_code": courseCode.uppercased().trim(),
                    "creator": self.staffId,
                    "start_time": formatter.string(from: startTime),
                    "end_time": formatter.string(from: endTime),
                    "participants": 0,
                    "question": false,
                    "running": false,
                    "title": title,
                    "warning_rate": 0.5])
            } // end if
        }) // end set value
    }
    
    func nextLetter(_ letter: String) -> String? {
        
        // Check if string is build from exactly one Unicode scalar:
        guard let uniCode = UnicodeScalar(letter) else {
            return nil
        }
        switch uniCode {
        case "A" ..< "Z":
            return String(UnicodeScalar(uniCode.value + 1)!)
        default:
            return nil
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
