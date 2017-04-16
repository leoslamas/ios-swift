//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Leonardo Lamas on 25/03/15.
//  Copyright (c) 2015 Leonardo Lamas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //1=nought, 2=cross
    var activePlayer = 1
    var gameActive = true
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winningCombination = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    //primeiro botao
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var labelWinner: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBAction func playAgain(sender: AnyObject) {
        activePlayer = 1
        gameActive = true
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        
        var buttonL : UIButton!
        for i in 1...8 {
            buttonL = view.viewWithTag(i) as? UIButton
            buttonL.setImage(nil, forState: .Normal)
            button.setImage(nil, forState: .Normal)
            
        }
        
        labelWinner.hidden = true
        playAgainButton.hidden = true
        labelWinner.center = CGPointMake(labelWinner.center.x - 500, labelWinner.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 500, playAgainButton.center.y)
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        if gameState[sender.tag] == 0  && gameActive == true{
        
            var image = UIImage()
            gameState[sender.tag] = activePlayer
        
            if activePlayer == 1 {
                image = UIImage(named: "nought.png")!
                activePlayer = 2
            }else{
                image = UIImage(named: "cross.png")!
                activePlayer = 1
            }
        
            sender.setImage(image, forState: .Normal)
            
            for combination in winningCombination {
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                    
                    if gameState[combination[0]] == 1 {
                        labelWinner.text = "Noughts has won!"
                    }else{
                        labelWinner.text = "Crosses has won!"
                    }
                    
                    labelWinner.hidden = false
                    playAgainButton.hidden = false
                    
                    UIView.animateWithDuration(1, animations: {() -> Void in
                        
                        self.labelWinner.center = CGPointMake(self.labelWinner.center.x + 500, self.labelWinner.center.y)
                        self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 500, self.playAgainButton.center.y)
                    })
                    
                    gameActive = false
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        labelWinner.hidden = true
        playAgainButton.hidden = true
        labelWinner.center = CGPointMake(labelWinner.center.x - 500, labelWinner.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 500, playAgainButton.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

