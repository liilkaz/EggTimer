//
//  ViewController.swift
//  EggTimer
//
//  Created by Лилия Феодотова on 26.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!

    @IBAction func startTimer(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        progressView.progress = 0.0
        secondsPassed = 0
        label.text = hardness
        totalTime = eggTimes[hardness]!
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = (Float(secondsPassed) / Float(totalTime))
        }else {
            timer.invalidate()
            label.text = "Done!"
            playSound()
        }
        
    }
    
    func playSound() {
       let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()

    }
    
}

