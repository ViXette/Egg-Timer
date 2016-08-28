//
//  ViewController.swift
//  Egg Timer
//
//  Created by VX on 28/08/16.
//  Copyright © 2016 VXette. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    let initialStopTimerValue = 210
    var stopTimerValue = 0
    var secondsPassed = 0
    var stepInterval = 10
    
    @IBOutlet weak var timer_Label: UILabel!
    @IBOutlet weak var minus_Label: UIBarButtonItem!
    @IBOutlet weak var plus_Label: UIBarButtonItem!
    
    @IBAction func resumeTimer(_ sender: AnyObject) {
        if stopTimerValue - secondsPassed > 0 {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func pauseTimer(_ sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func minusIntervalToTimer(_ sender: AnyObject) {
        if stopTimerValue - secondsPassed - stepInterval >= stepInterval {
            stopTimerValue -= stepInterval
        } else {
            stopTimerValue = 0
            secondsPassed = 0
            timer.invalidate()
        }
        
        refreshTimerLabel()
    }
    
    @IBAction func plusIntervalToTimer(_ sender: AnyObject) {
        stopTimerValue += stepInterval
        refreshTimerLabel()
    }
    
    @IBAction func resetTimer(_ sender: AnyObject) {
        timer.invalidate()
        stopTimerValue = initialStopTimerValue
        secondsPassed = 0
        refreshTimerLabel()
    }
    
    func processTimer() {
        secondsPassed += 1
        if stopTimerValue - secondsPassed <= 0 {
            timer.invalidate()
        }
        refreshTimerLabel()
    }
    
    func refreshTimerLabel() {
        let totalSec = stopTimerValue - secondsPassed
        let minutes = totalSec / 60
        let minutes_Str = minutes >= 10 ? "\(minutes)" : "0\(minutes)"
        let seconds = totalSec % 60
        let seconds_Str = seconds >= 10 ? "\(seconds)" : "0\(seconds)"
        timer_Label.text = "\(minutes_Str):\(seconds_Str)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopTimerValue = initialStopTimerValue
        refreshTimerLabel()
        minus_Label.title = "-\(stepInterval)"
        plus_Label.title = "+\(stepInterval)"
    }

}

