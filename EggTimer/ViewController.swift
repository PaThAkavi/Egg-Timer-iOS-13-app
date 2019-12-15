//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer : AVPlayer!

    var secondsRemaining = 60
    var hardness = ""
    var eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    var secondsPast = 0
    var timer = Timer()
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var textView: UILabel!
    @IBAction func hardnessSelected(_ sender: Any) {
        
        timer.invalidate()  //to stop the timer
        
        hardness = (sender as AnyObject).currentTitle!
        
        secondsRemaining = eggTimes[hardness]!
        
        secondsPast = secondsRemaining/secondsRemaining
    
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        if secondsRemaining > 0 {
            textView.text = "\(hardness) : " + String(secondsRemaining)
            secondsRemaining -= 1
            //progress = secPast/totalSec(formulaa)
            progressBar.progress = progressBar.progress + (Float(secondsPast)/Float(eggTimes[hardness]!))
        } else if(secondsRemaining == 0){
            timer.invalidate()
            textView.text = "DONE"
            playAudioFromProject()
            progressBar.progress = 0
        }
    }
    
    private func playAudioFromProject() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
            print("error to get the mp3 file")
            return
        }
        do {
            audioPlayer = try AVPlayer(url: url)
        } catch {
            print("audio file error")
        }
        audioPlayer?.play()
    }
}
