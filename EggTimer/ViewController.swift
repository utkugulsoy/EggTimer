//
//  ViewController.swift
//  EggTimer
//
//  Created by Utku Kaan Gülsoy on 31.08.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    var counter = 0
    var tim: Timer?
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        stopTimer()
        
        let hardness = sender.currentTitle
        if hardness == "Soft"
        {
            counter = 300
        }
        else if hardness == "Medium"
        {
            counter = 420
        }
        else
        {
            counter = 720
        }
        startTimer(limit: counter)
        titleLabel.text = hardness
        progressBar.progress = 0
        secondsPassed = 0
    }
    
    func startTimer(limit:Int)
    {
        guard tim == nil else {return}
        tim = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func stopTimer()
    {
        tim?.invalidate()
        tim = nil
    }
    @objc func updateCounter()
    {
        secondsPassed += 1
        let progress = Float(secondsPassed)/Float(counter)
        progressBar.progress = progress
        if progress == 1
        {
            stopTimer()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }
    
}

