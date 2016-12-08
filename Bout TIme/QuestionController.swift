//
//  QuestionController.swift
//  Bout TIme
//
//  Created by Tanveer Momin on 12/5/16.
//  Copyright © 2016 Tanveer Momin. All rights reserved.
//

import UIKit

class QuestionController: UIViewController {
    
    let eventsController = EventsController()
    var eventOne: Int = 0
    var eventTwo: Int = 0
    var eventThree: Int = 0
    var eventFour: Int = 0
    var gameTimer: Timer!
    var score: Int = 0
    var round: Int = 1
    
    @IBOutlet weak var eventOneButton: UIButton!
    @IBOutlet weak var eventTwoButton: UIButton!
    @IBOutlet weak var eventThreeButton: UIButton!
    @IBOutlet weak var eventFourButton: UIButton!
    @IBOutlet weak var countDownTimer: UILabel!
    @IBOutlet weak var shakeToComplete: UILabel!
    @IBOutlet weak var successButton: UIButton!
    @IBOutlet weak var failButton: UIButton!
    
    var counter = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Apply cornerRadius to the event boxes and disable user interaction
        eventOneButton.layer.cornerRadius = 3
        eventTwoButton.layer.cornerRadius = 3
        eventThreeButton.layer.cornerRadius = 3
        eventFourButton.layer.cornerRadius = 3
        
        assignEvent()
        
        // Start timer
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
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
            checkAnswer()
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            checkAnswer()
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
        case 6: nextRound()
        default: return
        }
    }

    func eventOneTwoSwap() {
        let temp = eventOneButton.currentTitle
        eventOneButton.setTitle(eventTwoButton.currentTitle, for: .normal)
        eventTwoButton.setTitle(temp, for: .normal)
        swap(&eventOne, &eventTwo)
    }
    
    func eventTwoThreeSwap() {
        let temp = eventTwoButton.currentTitle
        eventTwoButton.setTitle(eventThreeButton.currentTitle, for: .normal)
        eventThreeButton.setTitle(temp, for: .normal)
        swap(&eventTwo, &eventThree)
    }
    
    func eventThreeFourSwap() {
        let temp = eventThreeButton.currentTitle
        eventThreeButton.setTitle(eventFourButton.currentTitle, for: .normal)
        eventFourButton.setTitle(temp, for: .normal)
        swap(&eventThree, &eventFour)
    }
    
    func assignEvent() {
        print(round)
        eventOne = eventsController.getRandomNumber()
        eventTwo = eventsController.getRandomNumber()
        eventThree = eventsController.getRandomNumber()
        eventFour = eventsController.getRandomNumber()
        displayEvent()
    }
    
    func displayEvent() {
        do {
            try eventOneButton.setTitle(eventsController.getEvent(index: eventOne), for: .normal)
            try eventTwoButton.setTitle(eventsController.getEvent(index: eventTwo), for: .normal)
            try eventThreeButton.setTitle(eventsController.getEvent(index: eventThree), for: .normal)
            try eventFourButton.setTitle(eventsController.getEvent(index: eventFour), for: .normal)
        } catch {
            fatalError("\(error)")
        }
    }
    
    func checkAnswer() {
        gameTimer.invalidate()
        countDownTimer.isHidden = true
        shakeToComplete.isHidden = true
        
        if (eventOne < eventTwo) && (eventTwo < eventThree) && (eventThree < eventFour) {
            successButton.isHidden = false
            score += 1
        } else {
            failButton.isHidden = false
        }
    }
    
    func nextRound() {
        counter = 60
        round += 1
        successButton.isHidden = true
        failButton.isHidden = true
        countDownTimer.isHidden = false
        shakeToComplete.isHidden = false
        assignEvent()
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
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
