//
//  YoWagerqueSGmaeViewController.swift
//  YoWagerqueSlotinnovateNo
//
//  Created by adin on 2024/9/9.
//

import UIKit
import AVFoundation
class YoWagerqueSGmaeViewController: UIViewController {

    @IBOutlet weak var reel1: UIPickerView!
    @IBOutlet weak var reel2: UIPickerView!
    @IBOutlet weak var reel3: UIPickerView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var increaseBetButton: UIButton!
    @IBOutlet weak var decreaseBetButton: UIButton!
    
    let gemImages = ["1", "2", "3", "4", "5", "6"]
    var score = 0
    var bet = 1 // Initialize bet with default value of 1
    let minBet = 1
    let maxBet = 10
    
    var spinSoundEffect: AVAudioPlayer?
    var winSoundEffect: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupSoundEffects()
        setupButtonAnimations()
        
        reel1.dataSource = self
        reel1.delegate = self
        reel2.dataSource = self
        reel2.delegate = self
        reel3.dataSource = self
        reel3.delegate = self
    }
    
    func setupInitialView() {
        resultLabel.text = ""
        scoreLabel.text = "Score: \(score)"
        betLabel.text = "Bet: \(bet)"
    }
    
    func setupSoundEffects() {
        if let spinSoundURL = Bundle.main.url(forResource: "spin", withExtension: "wav") {
            do {
                spinSoundEffect = try AVAudioPlayer(contentsOf: spinSoundURL)
                spinSoundEffect?.prepareToPlay()
            } catch {
                print("Error loading spin sound")
            }
        }
        
        if let winSoundURL = Bundle.main.url(forResource: "win", withExtension: "wav") {
            do {
                winSoundEffect = try AVAudioPlayer(contentsOf: winSoundURL)
                winSoundEffect?.prepareToPlay()
            } catch {
                print("Error loading win sound")
            }
        }
    }
    
    func setupButtonAnimations() {
        spinButton.addTarget(self, action: #selector(spinButtonPressed(_:)), for: .touchDown)
        spinButton.addTarget(self, action: #selector(spinButtonReleased(_:)), for: .touchUpInside)
        spinButton.addTarget(self, action: #selector(spinButtonReleased(_:)), for: .touchUpOutside)
        
        increaseBetButton.addTarget(self, action: #selector(increaseBet), for: .touchUpInside)
        decreaseBetButton.addTarget(self, action: #selector(decreaseBet), for: .touchUpInside)
    }
    
    @objc func spinButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
    }
    
    @objc func spinButtonReleased(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform.identity
        })
    }
    
    @objc func increaseBet() {
        if bet < maxBet {
            bet += 1
            betLabel.text = "Bet: \(bet)" // Update bet label
        }
    }
    
    @objc func decreaseBet() {
        if bet > minBet {
            bet -= 1
            betLabel.text = "Bet: \(bet)" // Update bet label
        }
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        playSpinSound()
        spinReels()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func spinReels() {
        let reel1Results = gemImages.shuffled()
        let reel2Results = gemImages.shuffled()
        let reel3Results = gemImages.shuffled()
        
        let reel1Row = Int.random(in: 0..<gemImages.count)
        let reel2Row = Int.random(in: 0..<gemImages.count)
        let reel3Row = Int.random(in: 0..<gemImages.count)
        
        reel1.selectRow(reel1Row, inComponent: 0, animated: true)
        reel2.selectRow(reel2Row, inComponent: 0, animated: true)
        reel3.selectRow(reel3Row, inComponent: 0, animated: true)
        
        let reel1Result = gemImages[reel1Row]
        let reel2Result = gemImages[reel2Row]
        let reel3Result = gemImages[reel3Row]
        
        checkForWin(reel1Result: reel1Result, reel2Result: reel2Result, reel3Result: reel3Result)
    }
    
    func checkForWin(reel1Result: String, reel2Result: String, reel3Result: String) {
        if reel1Result == reel2Result && reel2Result == reel3Result {
            score += 100 * bet // Multiply score by current bet
            resultLabel.text = "Jackpot! Score: +\(100 * bet)"
            playWinSound()
        } else if reel1Result == reel2Result || reel2Result == reel3Result || reel1Result == reel3Result {
            score += 50 * bet // Multiply score by current bet
            resultLabel.text = "Nice! Score: +\(50 * bet)"
        } else {
            resultLabel.text = "Try Again!"
        }
        scoreLabel.text = "Score: \(score)"
    }
    
    func playSpinSound() {
        spinSoundEffect?.play()
    }
    
    func playWinSound() {
        winSoundEffect?.play()
    }
}

extension YoWagerqueSGmaeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gemImages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 70))
        imageView.contentMode = .scaleAspectFit
        
        let imageName = gemImages[row]
        if let image = UIImage(named: imageName) {
            imageView.image = image
        } else {
            imageView.image = nil
        }
        
        imageView.frame = CGRect(x: 0, y: 0, width: pickerView.frame.width, height: 70)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80.0
    }
}
