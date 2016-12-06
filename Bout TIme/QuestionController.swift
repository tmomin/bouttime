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
    
    enum EventErrors: Error {
        case OneTwoError
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Apply cornerRadius to the event boxes and disable user interaction
        eventOne.layer.cornerRadius = 3
        eventOne.isUserInteractionEnabled = false
        eventTwo.layer.cornerRadius = 3
        eventTwo.isUserInteractionEnabled = false
        eventThree.layer.cornerRadius = 3
        eventThree.isUserInteractionEnabled = false
        eventFour.layer.cornerRadius = 3
        eventFour.isUserInteractionEnabled = false
        
        
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
    
    @IBAction func eventOneDown(_ sender: Any) {
        do {
            try eventOneTwoSwap()
        } catch {
            fatalError("\(error)")
        }
    }
    @IBAction func eventTwoUp(_ sender: Any) {
        do {
            try eventOneTwoSwap()
        } catch {
            fatalError("\(error)")
        }
    }
    @IBAction func eventTwoDown(_ sender: Any) {
        do {
            try eventTwoThreeSwap()
        } catch {
            fatalError("\(error)")
        }
    }
    @IBAction func eventThreeUp(_ sender: Any) {
        do {
            try eventTwoThreeSwap()
        } catch {
            fatalError("\(error)")
        }
    }
    @IBAction func eventThreeDown(_ sender: Any) {
        do {
            try eventThreeFourSwap()
        } catch {
            fatalError("\(error)")
        }
    }
    @IBAction func eventFourUp(_ sender: Any) {
        do {
            try eventThreeFourSwap()
        } catch {
            fatalError("\(error)")
        }
    }
    
    func eventOneTwoSwap() throws {
        guard let temp = eventOne.currentTitle else {
            throw EventErrors.OneTwoError
        }
        eventOne.setTitle(eventTwo.currentTitle, for: .normal)
        eventTwo.setTitle(temp, for: .normal)
    }
    
    func eventTwoThreeSwap() throws {
        guard let temp = eventTwo.currentTitle else {
            throw EventErrors.OneTwoError
        }
        eventTwo.setTitle(eventThree.currentTitle, for: .normal)
        eventThree.setTitle(temp, for: .normal)
    }
    
    func eventThreeFourSwap() throws {
        guard let temp = eventThree.currentTitle else {
            throw EventErrors.OneTwoError
        }
        eventThree.setTitle(eventFour.currentTitle, for: .normal)
        eventFour.setTitle(temp, for: .normal)
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
