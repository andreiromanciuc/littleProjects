//
//  ViewController.swift
//  EggTimer
//
//  Created by Andrei Romanciuc on 18.09.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    var totalTime = 0
    var secondPassed = 0
    var player: AVAudioPlayer!
    
    var timer = Timer()
    
    var hardness : String?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness!]!
        
        progressBar.progress = 0.0
        secondPassed = 0
        messageLbl.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondPassed < totalTime {
            secondPassed += 1

            progressBar.progress = Float(secondPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            messageLbl.text = "Done!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                        player = try! AVAudioPlayer(contentsOf: url!)
                        player.play()
        }
    }

}

