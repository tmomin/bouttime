//
//  QuestionController.swift
//  Bout TIme
//
//  Created by Tanveer Momin on 12/5/16.
//  Copyright © 2016 Tanveer Momin. All rights reserved.
//

import UIKit

class QuestionController: UIViewController {
    
    @IBOutlet weak var eventOne: UIButton!
    @IBOutlet weak var eventTwo: UIButton!
    @IBOutlet weak var eventThree: UIButton!
    @IBOutlet weak var eventFour: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        eventOne.layer.cornerRadius = 3
        eventTwo.layer.cornerRadius = 3
        eventThree.layer.cornerRadius = 3
        eventFour.layer.cornerRadius = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
