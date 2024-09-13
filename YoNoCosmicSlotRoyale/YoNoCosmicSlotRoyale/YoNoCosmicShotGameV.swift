//
//  ShotGameVC.swift
//  Nova Rush Slot Fever
//
//  Created by SSS CosmicSlot Royale on 10/09/24.
//

import UIKit
import SpriteKit

class YoNoCosmicShotGameV: UIViewController {
    
    @IBOutlet weak var bvMain: UIVisualEffectView!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblHealth: UILabel!
    @IBOutlet weak var progHealth: UIProgressView!
    
    var initialTransform = CATransform3DIdentity
    var finalTransform = CATransform3DIdentity
    
    let skView = SKView()
    let scene = YoNoCosmicGameScene()
    
    var score = 0{
        didSet{
            lblScore.text = "SCORE:- \(score)"
        }
    }
    
    var health = 100{
        didSet{
            
            if health <= 0{
                
                scene.endGame()
                
                let alrt = UIAlertController(title: "GAME OVER!", message: "WELL PLAYED.\nSCORE: \(score).", preferredStyle: .alert)
                
                alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alrt, animated: false)
                
            }
            
            lblHealth.text = "♥︎\(health)"
            progHealth.progress = Float(Double(health)/100.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        score = 0
        health = 100
        
        
        history.append("STARTED SHOT GAME AT: \(dateString(from: Date()))")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            
            
            self.skView.backgroundColor = .clear
            self.scene.backgroundColor = .clear

            
            let size = self.bvMain.contentView.frame.size
            self.skView.frame.size = size

            self.skView.center = self.bvMain.contentView.center

            self.bvMain.contentView.addSubview(self.skView)

            self.scene.size = size
            self.scene.scaleMode = .aspectFit
            self.skView.presentScene(self.scene)

            self.skView.ignoresSiblingOrder = true

            self.scene.addScore = {i in
                self.score += i
            }
               
            self.scene.playSound = { name in
                self.playSound(name: name)
            }
            
            self.scene.health = {
                self.health -= 5
            }
            
            self.bvMain.layer.zPosition = 200
            
            self.initialTransform.m34 = -1.0 / 500.0
            self.initialTransform = CATransform3DRotate(self.initialTransform, .pi / 3.5, 1, 0, 0)
            
            self.finalTransform.m34 = -1.0 / 500.0
            self.finalTransform = CATransform3DTranslate(self.finalTransform, 0, size.height * 0.5, 0)
            
            self.finalTransform = CATransform3DRotate(self.finalTransform, 0, 1, 0, 0)

            self.bvMain.layer.transform = self.finalTransform
            
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
                
                self.bvMain.layer.transform = self.initialTransform
                
            })
            
        }
        
    }
    
    func dateString(from date: Date, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    
}
