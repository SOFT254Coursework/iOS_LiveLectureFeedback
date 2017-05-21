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
    
    var staffId: String?
    
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
                startDateCell?.dateTimePicker.date = Date()
                return startDateCell!
            } else {
                ident = "DateTimeEntry"
                endDateCell = tableView.dequeueReusableCell(withIdentifier: ident) as? dateTimeEntryCell
                endDateCell?.dateTimePicker.date = Date()
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
        guard let startDate = startDateCell?.dateTimePicker.date, startDate > Date() else {
            return
        }
        guard let endDate = endDateCell?.dateTimePicker.date, endDate < startDate else {
            return
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
