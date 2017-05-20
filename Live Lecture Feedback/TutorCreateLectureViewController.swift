//
//  TutorCreateLectureViewController.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 31/03/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit

class TutorCreateLectureViewController: UITableViewController {

    
    var sectionState = [false, false, false, false]
    
    @IBOutlet weak var tutorSetLectureCancelOutlet: UIButton!
    @IBOutlet weak var tutorSetLectureCreteOutlet: UIButton!
    
    var titleCell: TextEntryCell?
    var courseCodeCell : TextEntryCell?
    var simpleTitleCell : SimpleTitleCell?
    var startDateCell: dateTimeEntryCell?
    var endDateCell: dateTimeEntryCell?
    
    override func viewDidLoad() {
    super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        let ident : String
        let cell_date : dateTimeEntryCell
        var count = 1
        
        if (indexPath.row==0) {
            ident = "SimpleTitle"
            //count += 1
            simpleTitleCell = tableView.dequeueReusableCell(withIdentifier: ident, for: indexPath) as? SimpleTitleCell
            if count == 1 {
                simpleTitleCell?.titleLabel.text = "Module Code"
                count += 1
                print(count)
            }
            //else if count == 2 {
                //simpleTitleCell?.titleLabel.text = "Module Name"
                //count += 1
                //print(count)
            //}
            //else if count == 3 {
                //simpleTitleCell?.titleLabel.text = "Start Date"
                //count += 1
                //print(count)
            //}
            //else if count == 4 {
                //simpleTitleCell?.titleLabel.text = "End Date"
                //count += 1
                //print(count)
            //}
        } else {
            if indexPath.section == 0 {
                ident = "TextEntry"
                titleCell = tableView.dequeueReusableCell(withIdentifier: ident, for: indexPath) as? TextEntryCell
                titleCell?.dataEntryTextField.text = "Text"
                return titleCell!
            } else if indexPath.section == 1 {
                ident = "TextEntry"
                courseCodeCell = tableView.dequeueReusableCell(withIdentifier: ident, for: indexPath) as? TextEntryCell

                courseCodeCell?.dataEntryTextField.text = "?"
                return courseCodeCell!
            } else if indexPath.section == 2{
                ident = "DateTimeEntry"
                cell_date = tableView.dequeueReusableCell(withIdentifier: ident, for: indexPath) as! dateTimeEntryCell
                cell_date.dateTimePicker.date = Date()
                return cell_date
            } else {
                ident = "DateTimeEntry"
                cell_date = tableView.dequeueReusableCell(withIdentifier: ident, for: indexPath) as! dateTimeEntryCell
                cell_date.dateTimePicker.date = Date()
                return cell_date
            }
            
        }
        return UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row \(indexPath.row) in section \(indexPath.section)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        sectionState[indexPath.section] = !sectionState[indexPath.section]
        self.tableView.reloadData()
    }
    
    @IBAction func onSaveClick(_ sender: Any) {
        print((courseCodeCell?.dataEntryTextField.text)! as String)
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
