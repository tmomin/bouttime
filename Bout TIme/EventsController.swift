//
//  EventsController.swift
//  Bout TIme
//
//  Created by Tanveer Momin on 12/7/16.
//  Copyright © 2016 Tanveer Momin. All rights reserved.
//

import Foundation
import GameKit

public class EventsController {
    
    let event = HistoricalEvents()
    var eventBankIndex = [Int]()
    var indexOfSelectedEvent: Int = 0
    var indexValue: Int = 0
    var randomNumber: Int = 0
    var randomNum: UInt32 = 0
    
    enum EventError: Error {
        case EventNotFound
    }
    
    func getRandomNumber() -> Int {
        if eventBankIndex.count == 0 {
            randomNum = arc4random_uniform(UInt32(event.events.count))
            randomNumber = Int(randomNum)
            //randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: event.events.count)
        } else {
            for index in eventBankIndex {
                if (randomNumber == index) {
                    randomNum = arc4random_uniform(UInt32(event.events.count))
                    randomNumber = Int(randomNum)
                    //randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: event.events.count)
                }
            }
        }
        indexValue = randomNumber
        eventBankIndex.append(randomNumber)
        return(randomNumber)
    }
    
    func getEvent(index: Int) throws -> String {
        guard let event = event.events[index]["Event"] else {
            throw EventError.EventNotFound
        }
        return(event)
    }
    
    func getYear(index: Int) throws -> Int {
        guard let year = event.events[index]["Year"] else {
            throw EventError.EventNotFound
        }
        return(Int(year)!)
    }
    
    func getLink(index: Int) throws -> String {
        guard let link = event.events[index]["Link"] else {
            throw EventError.EventNotFound
        }
        return(link)
    }
}
