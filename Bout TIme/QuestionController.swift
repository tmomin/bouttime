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
    @IBOutlet weak var countDownTimer: UILabel!
    
    var counter = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Apply cornerRadius to the event boxes
        eventOne.layer.cornerRadius = 3
        eventTwo.layer.cornerRadius = 3
        eventThree.layer.cornerRadius = 3
        eventFour.layer.cornerRadius = 3
        
        // Start timer
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // func to update counter once timer starts
    func updateCounter() {
        if counter > 0 {
            counter -= 1
            countDownTimer.text = "\(counter)"
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            dismiss(animated: true, completion: nil)
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
