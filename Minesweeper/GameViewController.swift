//
//  ViewController.swift
//  Minesweeper
//
//  Created by apple on 08/06/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var mode = "normal"
    let gameEngine = GameEngine()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        gameEngine.startX = view.frame.width/2 - 150
        gameEngine.startY = view.frame.height/2 - 150
        gameEngine.populateBoard(view: self.view)
        gameEngine.plantMines()
        gameEngine.addTargetEvents()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if((navigationController?.viewControllers.count)! > 1) {
            self.handleUnwindToMenu()
        }
        
        return false
    }
    
    func handleUnwindToMenu() {
        let alertController = UIAlertController(title: "Are you sure you want to quit?", message: nil, preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.performSegue(withIdentifier: "unwindToMenu", sender: self)
        })
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
    }

}

