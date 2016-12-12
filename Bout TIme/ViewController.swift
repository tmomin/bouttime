//
//  ViewController.swift
//  Bout TIme
//
//  Created by Tanveer Momin on 12/4/16.
//  Copyright © 2016 Tanveer Momin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuesitonControllerDelegate {
        
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var gameOver: UILabel!
    
    enum DataError: Error {
        case NoDataReceived
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func acceptData(data: Int!) throws {
        instructionLabel.isHidden = true
        
        guard let score = data else {
            throw DataError.NoDataReceived
        }
        if score == 1 {
            gameOver.text = "Game Over! You got \(score) Question Right"
        } else {
            gameOver.text = "Game Over! You got \(score) Questions Right"
        }
        gameOver.isHidden = false
        startButton.setTitle("Start New Game", for: .normal)
        
    }

    @IBAction func startGame(_ sender: Any) {
        let pvc = storyboard?.instantiateViewController(withIdentifier: "QuestionController") as! QuestionController
        pvc.data = 0
        pvc.delegate = self
        self.present(pvc, animated: true, completion: nil)
    }

}

