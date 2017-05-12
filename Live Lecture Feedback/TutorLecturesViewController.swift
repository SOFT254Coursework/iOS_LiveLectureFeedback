//
//  TutorLecturesViewController.swift
//  Live Lecture Feedback
//
//  Created by (s) Mark Thompson on 31/03/2017.
//  Copyright © 2017 Devtography. All rights reserved.
//

import UIKit

class TutorLecturesViewController: UITableViewController {

    @IBOutlet weak var tutorLecturesExitOutlet: UIButton!
    @IBOutlet weak var tutorLecturesCreateOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.plain, target: self, action:#selector(addTouched) )
    }

    @IBAction func addTouched(_ sender: Any) {
        print("Touchy!")
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
        return 3 //To be replaced by an int variable which will get it's value from the database.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell", for: indexPath)
        
        if let nextCell = cell as? LectureTableViewCell {
            nextCell.sessionTitle.text = "Hello World"
        }
        return cell
    }
    
    @IBAction func tutorsLecturesExitAction(_ sender: Any) {
    }

    @IBAction func tutorLecturesCreateAction(_ sender: Any) {
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
