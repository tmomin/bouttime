//
//  QuestionController.swift
//  Bout TIme
//
//  Created by Tanveer Momin on 12/5/16.
//  Copyright © 2016 Tanveer Momin. All rights reserved.
//

import UIKit

protocol QuesitonControllerDelegate {
    func acceptData(data: Int!) throws
}

class QuestionController: UIViewController {
    
    let eventsController = EventsController()
    let soundController = SoundController()
    var eventOne: Int = 0
    var eventTwo: Int = 0
    var eventThree: Int = 0
    var eventFour: Int = 0
    var gameTimer: Timer!
    var score: Int = 0
    var round: Int = 1
    var webLink: String = ""
    var counter: Int = 60

    // Delegate to send data back to ViewController
    var delegate : QuesitonControllerDelegate?
    var data: Int?
    
    @IBOutlet weak var eventOneButton: UIButton!
    @IBOutlet weak var eventTwoButton: UIButton!
    @IBOutlet weak var eventThreeButton: UIButton!
    @IBOutlet weak var eventFourButton: UIButton!
    @IBOutlet weak var countDownTimer: UILabel!
    @IBOutlet weak var shakeToComplete: UILabel!
    @IBOutlet weak var successButton: UIButton!
    @IBOutlet weak var failButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Apply cornerRadius to the event boxes and disable user interaction
        eventOneButton.layer.cornerRadius = 3
        eventTwoButton.layer.cornerRadius = 3
        eventThreeButton.layer.cornerRadius = 3
        eventFourButton.layer.cornerRadius = 3
        
        // Load Sounds
        soundController.loadCorrectSound()
        soundController.loadIncorrectSound()
        
        // Generate Event and Display to screen
        assignEvent()
        
        // Start timer
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    // allow data to be sent to WebViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueWebView" {
            
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! WebViewController
            
            controller.link = webLink
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Transfer data back to ViewController
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isBeingDismissed {
            do {
                try self.delegate?.acceptData(data: score)
            } catch {
                fatalError()
            }
        }
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
    
    // func to detect shaking of phone
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            checkAnswer()
        }
    }
    
    // func to control button presses
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0: eventOneTwoSwap()
        case 1: eventOneTwoSwap()
        case 2: eventTwoThreeSwap()
        case 3: eventTwoThreeSwap()
        case 4: eventThreeFourSwap()
        case 5: eventThreeFourSwap()
        case 6: if (round == 6) {
            finishGame()
        } else {
            nextRound()
        }
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
    
    // Generate events
    func assignEvent() {
        eventOne = eventsController.getRandomNumber()
        eventTwo = eventsController.getRandomNumber()
        eventThree = eventsController.getRandomNumber()
        eventFour = eventsController.getRandomNumber()
        displayEvent()
    }
    
    // Display generated events to screen
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
    
    // Check if answer is correct
    func checkAnswer() {
        gameTimer.invalidate()
        countDownTimer.isHidden = true
        shakeToComplete.isHidden = true
        
        switchEventButtonsInteration()
        if (eventOne < eventTwo) && (eventTwo < eventThree) && (eventThree < eventFour) {
            soundController.playCorrectSound()
            successButton.isHidden = false
            score += 1
        } else {
            soundController.playIncorrectSound()
            failButton.isHidden = false
        }
    }
    
    // func to restart counter and view for next round
    func nextRound() {
        counter = 60
        round += 1
        successButton.isHidden = true
        failButton.isHidden = true
        countDownTimer.isHidden = false
        shakeToComplete.isHidden = false
        assignEvent()
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        switchEventButtonsInteration()
    }
    
    // func to display data of event when a event is clicked
    @IBAction func eventButtonClick(_ sender: UIButton) {
        switch sender.tag {
        case 7: displayWeb(index: eventOne)
        case 8: displayWeb(index: eventTwo)
        case 9: displayWeb(index: eventThree)
        case 10: displayWeb(index: eventFour)
        default: return
        }
    }
    
    func displayWeb(index: Int) {
        do {
            webLink = try eventsController.getLink(index: index)
        } catch {
            fatalError()
        }
        
    }
    
    func switchEventButtonsInteration() {
        if eventOneButton.isUserInteractionEnabled {
            eventOneButton.isUserInteractionEnabled = false
            eventTwoButton.isUserInteractionEnabled = false
            eventThreeButton.isUserInteractionEnabled = false
            eventFourButton.isUserInteractionEnabled = false
        } else {
            eventOneButton.isUserInteractionEnabled = true
            eventTwoButton.isUserInteractionEnabled = true
            eventThreeButton.isUserInteractionEnabled = true
            eventFourButton.isUserInteractionEnabled = true
        }
    }
    
    func finishGame() {
        dismiss(animated: true, completion: nil)
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
