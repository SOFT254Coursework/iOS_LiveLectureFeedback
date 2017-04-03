//
//  TutorCreateLectureViewController.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 31/03/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit

class TutorCreateLectureViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let listOfDays = Array(1...31)
    let listOfMonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let listOfYears = Array(2016...2020)
    
    let listOfHours = Array(9...18)
    let listOfMinutes = [00, 15, 30, 45]
    
    @IBOutlet weak var startDatePickerView: UIPickerView!
    @IBOutlet weak var endDatePickerView: UIPickerView!
    @IBOutlet weak var startTimePickerView: UIPickerView!
    @IBOutlet weak var endTimePickerView: UIPickerView!
    
    override func viewDidLoad() {
    super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView == startDatePickerView || pickerView == endDatePickerView){
            return 3}
        else{
            return 2
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView){
        case startDatePickerView, endDatePickerView:
            switch (component){
            case 0:
                return self.listOfDays.count
            case 1:
                return self.listOfMonths.count
            case 2:
                return self.listOfYears.count
            default:
                return 1
            }
        case startTimePickerView, endTimePickerView:
            switch (component){
            case 0:
                return self.listOfHours.count
            case 1:
                return self.listOfMinutes.count
            default:
                return 1
            }
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (pickerView){
        case startDatePickerView, endDatePickerView:
            switch (component){
            case 0:
                return String(self.listOfDays[row])
            case 1:
                return self.listOfMonths[row]
            case 2:
                return String(self.listOfYears[row])
            default:
                return ""
            }
        case startTimePickerView, endTimePickerView:
            switch (component){
            case 0:
                return String(self.listOfHours[row])
            case 1:
                return String(self.listOfMinutes[row])
            default:
                return ""
            }
        default:
            return ""
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
