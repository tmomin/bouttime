//
//  QuestionController.swift
//  Bout TIme
//
//  Created by Tanveer Momin on 12/5/16.
//  Copyright © 2016 Tanveer Momin. All rights reserved.
//

import UIKit

class QuestionController: UIViewController {
    
    
    @IBOutlet weak var eventOneLabel: UILabel!
    @IBOutlet weak var eventTwoLabel: UILabel!
    @IBOutlet weak var eventThreeLabel: UILabel!
    @IBOutlet weak var eventFourLabel: UILabel!
    @IBOutlet weak var countDownTimer: UILabel!
    
    var counter = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Apply cornerRadius to the event boxes and disable user interaction
        eventOneLabel.layer.cornerRadius = 3
        eventTwoLabel.layer.cornerRadius = 3
        eventThreeLabel.layer.cornerRadius = 3
        eventFourLabel.layer.cornerRadius = 3
        
        
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
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0: eventOneTwoSwap()
        case 1: eventOneTwoSwap()
        case 2: eventTwoThreeSwap()
        case 3: eventTwoThreeSwap()
        case 4: eventThreeFourSwap()
        case 5: eventThreeFourSwap()
        default: return
        }
    }
    

    func eventOneTwoSwap() {
        let temp = eventOneLabel.text
        eventOneLabel.text = eventTwoLabel.text
        eventTwoLabel.text = temp
    }
    
    func eventTwoThreeSwap() {
        let temp = eventTwoLabel.text
        eventTwoLabel.text = eventThreeLabel.text
        eventThreeLabel.text = temp
    }
    
    func eventThreeFourSwap() {
        let temp = eventThreeLabel.text
        eventThreeLabel.text = eventFourLabel.text
        eventFourLabel.text = temp
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
