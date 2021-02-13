//
//  ViewController.swift
//  EggTimer
//
//  Created by Pedro Miguel Pereira on 08/07/2019.
//  
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        progressBar.alpha = 0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.alpha = 1
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                self.progressBar.progress = Float(self.secondsPassed) / Float(self.totalTime)
             } else {
                Timer.invalidate()
                self.progressBar.progress = 1.0
                self.titleLabel.text = "DONE!"
                self.playTimerSound()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.titleLabel.text = "How do you like your eggs?"
                    self.progressBar.alpha = 0
                }
             }
         }
    }
    
    func playTimerSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer.play()
    }
    
}

