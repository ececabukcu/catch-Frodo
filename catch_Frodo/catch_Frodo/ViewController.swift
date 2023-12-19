//
//  ViewController.swift
//  catch_Frodo
//
//  Created by Ece Çabukçu on 12/19/23.
//

import UIKit

class ViewController: UIViewController {
    
//    variables
    var timer = Timer()
    var counter = 0
    var score = 0
    var hideTimer = Timer()
    var frodoArray = [UIImageView]()
    var highScore1 = 0
    
    
//    views
    @IBOutlet weak var frodo1: UIImageView!
    @IBOutlet weak var frodo2: UIImageView!
    @IBOutlet weak var frodo3: UIImageView!
    @IBOutlet weak var frodo4: UIImageView!
    @IBOutlet weak var frodo5: UIImageView!
    @IBOutlet weak var frodo6: UIImageView!
    @IBOutlet weak var frodo7: UIImageView!
    @IBOutlet weak var frodo8: UIImageView!
    @IBOutlet weak var frodo9: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScore: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore1 = 0
            highScore.text = "High score = \(highScore1)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore1 = newScore
            highScore.text = "High score: \(highScore1)"
        }
        counter = 15
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideFrodo), userInfo: nil, repeats: true)
        
//        images
        frodo1.isUserInteractionEnabled = true
        frodo2.isUserInteractionEnabled = true
        frodo3.isUserInteractionEnabled = true
        frodo4.isUserInteractionEnabled = true
        frodo5.isUserInteractionEnabled = true
        frodo6.isUserInteractionEnabled = true
        frodo7.isUserInteractionEnabled = true
        frodo8.isUserInteractionEnabled = true
        frodo9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        frodo1.addGestureRecognizer(recognizer1)
        frodo2.addGestureRecognizer(recognizer2)
        frodo3.addGestureRecognizer(recognizer3)
        frodo4.addGestureRecognizer(recognizer4)
        frodo5.addGestureRecognizer(recognizer5)
        frodo6.addGestureRecognizer(recognizer6)
        frodo7.addGestureRecognizer(recognizer7)
        frodo8.addGestureRecognizer(recognizer8)
        frodo9.addGestureRecognizer(recognizer9)
        
        frodoArray = [frodo1, frodo2, frodo3, frodo4, frodo5, frodo6, frodo7, frodo8, frodo9]
        hideFrodo()
    }
    
    @objc func hideFrodo(){
        for frodo in frodoArray{
            frodo.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(frodoArray.count - 1)))
        frodoArray[random].isHidden = false
 
    }
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        
        print("you caught")
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            print("time is over")
            timer.invalidate() //timer durur
            hideTimer.invalidate()
            
            for frodo in frodoArray{
                frodo.isHidden = true
            }
            
            if self.score > self.highScore1{
                self.highScore1 = self.score
                highScore.text = "High score: \(self.highScore1)"
                UserDefaults.standard.set(self.highScore1,forKey: "highscore")
                
            }
            
            let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: .default) { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 15
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideFrodo), userInfo: nil, repeats: true)
                
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion:  nil)
            
            
        }
        
        
    }

}

