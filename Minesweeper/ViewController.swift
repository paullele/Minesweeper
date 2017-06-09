//
//  ViewController.swift
//  Minesweeper
//
//  Created by apple on 08/06/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cells = [UIButton]()
    var startX: CGFloat!
    var startY: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startX = view.frame.width/2 - 150
        startY = view.frame.height/2 - 150
        populateBoard()
        plantMines()
        addTargetEvents()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTargetEvents() {
        for cell in cells {
            cell.addTarget(self, action: #selector(actionOnCell), for: .touchUpInside)
        }
    }
    
    func actionOnCell(sender: UIButton) {
        sender.isSelected = true
        if(sender.titleLabel?.text != "M") {
            //check neighbours
            sender.setTitle(markCell(around: cells.index(of: sender)!), for: .selected)
        } else {
            //game over
        }
    }
    
    func markCell(around position: Int) -> String {
        var counter = 0
        
        if (position - 10 > 0) {
            cells[position - 10].isSelected = true
            if(cells[position - 10].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position + 10 < 100) {
            cells[position + 10].isSelected = true
            if(cells[position + 10].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position - 1 >= 0 && position % 10 != 0) {
            cells[position - 1].isSelected = true
            if(cells[position - 1].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position + 1 < 100 && (position + 1) % 10 != 0) {
            cells[position + 1].isSelected = true
            if(cells[position + 1].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        //diagonals
        if(position - 11 >= 0 && position % 10 != 0) {
            cells[position - 11].isSelected = true
            if(cells[position - 11].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position - 9 > 0 && (position + 1) % 10 != 0) {
            cells[position - 9].isSelected = true
            if(cells[position - 9].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position + 11 < 100 && (position + 1) % 10 != 0) {
            cells[position + 11].isSelected = true
            if(cells[position + 11].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if (position + 9 < 100 && position % 10 != 0) {
            cells[position + 9].isSelected = true
            if(cells[position + 9].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        
        //check the neighbours
        if (position - 10 > 0) {
            cells[position - 10].setTitle(checkNeighbours(of: position - 10), for: .selected)
        }
        
        if(position + 10 < 100) {
            cells[position + 10].setTitle(checkNeighbours(of: position + 10), for: .selected)
        }
        
        if(position - 1 >= 0 && position % 10 != 0) {
            cells[position - 1].setTitle(checkNeighbours(of: position - 1), for: .selected)
        }
        
        if(position + 1 < 100 && (position + 1) % 10 != 0) {
            cells[position + 1].setTitle(checkNeighbours(of: position + 1), for: .selected)
        }

        if(position - 11 >= 0) {
            cells[position - 11].setTitle(checkNeighbours(of: position - 11), for: .selected)
        }
        
        if(position - 9 > 0 && position % 10 != 0) {
            cells[position - 9].setTitle(checkNeighbours(of: position - 9), for: .selected)
        }
        
        if(position + 11 < 100) {
            cells[position + 11].setTitle(checkNeighbours(of: position + 11), for: .selected)
        }
        
        if (position + 9 < 100) {
            cells[position + 9].setTitle(checkNeighbours(of: position + 9), for: .selected)
        }
        
        return String(counter)
    }
    
    func checkNeighbours(of position: Int) -> String {
        var counter = 0
        
        if(cells[position].titleLabel?.text == "M") {
            return "M"
        }
        
        if (position - 10 > 0) {
            if(cells[position - 10].isSelected == false) {
                cells[position - 10].isSelected = true
                if(cells[position - 10].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position - 10].isSelected = false
            } else {
                if(cells[position - 10].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if(position + 10 < 100) {
            
            if(cells[position + 10].isSelected == false) {
                cells[position + 10].isSelected = true
                if(cells[position + 10].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position + 10].isSelected = false
            } else {
                if(cells[position + 10].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if(position - 1 >= 0 && position % 10 != 0) {
            if(cells[position - 1].isSelected == false) {
                if(cells[position - 1].titleLabel?.text == "M") {
                    counter += 1
                }
            } else {
                if(cells[position - 1].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if(position + 1 < 100 && (position + 1) % 10 != 0) {
            if(cells[position + 1].isSelected == false) {
                cells[position + 1].isSelected = true
                if(cells[position + 1].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position + 1].isSelected = false
            } else {
                if(cells[position + 1].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
            
        //diagonals
        if(position - 11 >= 0) {
            if(cells[position - 11].isSelected == false) {
                cells[position - 11].isSelected = true
                if(cells[position - 11].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position - 11].isSelected = false
            } else {
                if(cells[position - 11].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if(position - 9 > 0 && position % 10 != 0) {
            if(cells[position - 9].isSelected == false) {
                cells[position - 9].isSelected = true
                if(cells[position - 9].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position - 9].isSelected = false
            } else {
                if(cells[position - 9].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if(position + 11 < 100) {
            if(cells[position + 11].isSelected == false) {
                cells[position + 11].isSelected = true
                if(cells[position + 11].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position + 11].isSelected = false
            } else {
                if(cells[position + 11].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if (position + 9 < 100) {
            if(cells[position + 9].isSelected == false) {
                cells[position + 9].isSelected = true
                if(cells[position + 9].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position + 9].isSelected = false
            } else {
                if(cells[position + 9].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        return String(counter)
        
    }
    
    func plantMines() {
        var i = 0
        
        while(i < 80) {
            let random = arc4random_uniform(100)
            if(cells[Int(random)].titleLabel?.text != "M") {
                cells[Int(random)].setTitle("M", for: .selected)
                i += 1
            }
        }
    }
    
    func populateBoard() {
        for _ in 0..<10 {
            for _ in 0..<10 {
                createCell(at: startX, y: startY, ofSize: 30)
                startX = startX + 30
            }
            startX = startX - 300
            startY = startY + 30
        }
    }
    
    func createCell(at x: CGFloat, y: CGFloat, ofSize size: CGFloat) {
        
        let cell = UIButton(frame: CGRect(x: x, y: y, width: size, height: size))
        cell.layer.borderWidth = 1
        cell.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        cell.setTitleColor(.blue, for: .normal)
        
        cells.append(cell)
        view.addSubview(cell)
    }


}

