//
//  GameEngine.swift
//  Minesweeper
//
//  Created by apple on 12/06/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit

enum GameMode {
    case easy
    case normal
    case hard
}

var gameMode = GameMode.normal

class GameEngine {
    
    var cells = [UIButton]()
    var startX: CGFloat!
    var startY: CGFloat!
    
    var cellPerRow = 10
    
    func createCell(at x: CGFloat, y: CGFloat, ofSize size: CGFloat, to view: UIView ) {
        
        let cell = UIButton(frame: CGRect(x: x, y: y, width: size, height: size))
        cell.layer.borderWidth = 1
        cell.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        cell.setTitleColor(.blue, for: .normal)
        
        cells.append(cell)
        view.addSubview(cell)
    }
    
    func populateBoard(view: UIView) {
        for _ in 0..<cellPerRow {
            for _ in 0..<cellPerRow {
                createCell(at: startX, y: startY, ofSize: 30, to: view)
                startX = startX + 30
            }
            startX = startX - 300
            startY = startY + 30
        }
    }
    
    func plantMines() {
        var i = 0
        
        var mines = 20
        
        switch gameMode {
        case .easy:
            mines = 10
        case .normal:
            mines = 20
        case .hard:
            mines = 30
        }
        
        while(i < mines) {
            let random = arc4random_uniform(UInt32(cellPerRow * cellPerRow))
            if(cells[Int(random)].titleLabel?.text != "M") {
                cells[Int(random)].setTitle("M", for: .selected)
                i += 1
            }
        }
    }
    
    func addTargetEvents() {
        for cell in cells {
            cell.addTarget(self, action: #selector(actionOnCell), for: .touchUpInside)
        }
    }
    
    @objc func actionOnCell(sender: UIButton) {
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
        
        if (position - cellPerRow > 0) {
            cells[position - cellPerRow].isSelected = true
            if(cells[position - cellPerRow].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position + cellPerRow < cellPerRow * cellPerRow) {
            cells[position + cellPerRow].isSelected = true
            if(cells[position + cellPerRow].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position - 1 >= 0 && position % cellPerRow != 0) {
            cells[position - 1].isSelected = true
            if(cells[position - 1].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position + 1 < cellPerRow * cellPerRow && (position + 1) % cellPerRow != 0) {
            cells[position + 1].isSelected = true
            if(cells[position + 1].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        //diagonals
        if(position - (cellPerRow + 1) >= 0 && position % cellPerRow != 0) {
            cells[position - (cellPerRow + 1)].isSelected = true
            if(cells[position - (cellPerRow + 1)].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position - (cellPerRow - 1) > 0 && (position + 1) % cellPerRow != 0) {
            cells[position - (cellPerRow - 1)].isSelected = true
            if(cells[position - (cellPerRow - 1)].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if(position + (cellPerRow + 1) < cellPerRow * cellPerRow && (position + 1) % cellPerRow != 0) {
            cells[position + (cellPerRow + 1)].isSelected = true
            if(cells[position + (cellPerRow + 1)].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        if (position + (cellPerRow - 1) < cellPerRow * cellPerRow && position % cellPerRow != 0) {
            cells[position + (cellPerRow - 1)].isSelected = true
            if(cells[position + (cellPerRow - 1)].titleLabel?.text == "M") {
                counter += 1
            }
        }
        
        
        //check the neighbours
        if (position - cellPerRow > 0) {
            cells[position - cellPerRow].setTitle(checkNeighbours(of: position - cellPerRow), for: .selected)
        }
        
        if(position + cellPerRow < cellPerRow * cellPerRow) {
            cells[position + cellPerRow].setTitle(checkNeighbours(of: position + cellPerRow), for: .selected)
        }
        
        if(position - 1 >= 0 && position % cellPerRow != 0) {
            cells[position - 1].setTitle(checkNeighbours(of: position - 1), for: .selected)
        }
        
        if(position + 1 < cellPerRow * cellPerRow && (position + 1) % cellPerRow != 0) {
            cells[position + 1].setTitle(checkNeighbours(of: position + 1), for: .selected)
        }
        
        if(position - (cellPerRow + 1) >= 0 && position % cellPerRow != 0) {
            cells[position - (cellPerRow + 1)].setTitle(checkNeighbours(of: position - (cellPerRow + 1)), for: .selected)
        }
        
        if(position - (cellPerRow - 1) > 0 && (position + 1) % cellPerRow != 0) {
            cells[position - (cellPerRow - 1)].setTitle(checkNeighbours(of: position - (cellPerRow - 1)), for: .selected)
        }
        
        if(position + cellPerRow + 1 < cellPerRow * cellPerRow && (position + 1) % cellPerRow != 0) {
            cells[position + cellPerRow + 1].setTitle(checkNeighbours(of: position + cellPerRow + 1), for: .selected)
        }
        
        if (position + (cellPerRow - 1) < cellPerRow * cellPerRow && position % cellPerRow != 0) {
            cells[position + (cellPerRow - 1)].setTitle(checkNeighbours(of: position + (cellPerRow - 1)), for: .selected)
        }
        
        return String(counter)
    }
    
    func checkNeighbours(of position: Int) -> String {
        var counter = 0
        
        if(cells[position].titleLabel?.text == "M") {
            return "M"
        }
        
        if (position - cellPerRow > 0) {
            if(cells[position - cellPerRow].isSelected == false) {
                cells[position - cellPerRow].isSelected = true
                if(cells[position - cellPerRow].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position - cellPerRow].isSelected = false
            } else {
                if(cells[position - cellPerRow].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if(position + cellPerRow < cellPerRow * cellPerRow) {
            
            if(cells[position + cellPerRow].isSelected == false) {
                cells[position + cellPerRow].isSelected = true
                if(cells[position + cellPerRow].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position + cellPerRow].isSelected = false
            } else {
                if(cells[position + cellPerRow].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if(position - 1 >= 0 && position % cellPerRow != 0) {
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
        
        if(position + 1 < cellPerRow * cellPerRow && (position + 1) % cellPerRow != 0) {
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
        if(position - (cellPerRow + 1) >= 0) {
            if(cells[position - (cellPerRow + 1)].isSelected == false) {
                cells[position - (cellPerRow + 1)].isSelected = true
                if(cells[position - (cellPerRow + 1)].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position - (cellPerRow + 1)].isSelected = false
            } else {
                if(cells[position - (cellPerRow + 1)].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if(position - (cellPerRow - 1) > 0 && position % cellPerRow != 0) {
            if(cells[position - (cellPerRow - 1)].isSelected == false) {
                cells[position - (cellPerRow - 1)].isSelected = true
                if(cells[position - (cellPerRow - 1)].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position - (cellPerRow - 1)].isSelected = false
            } else {
                if(cells[position - (cellPerRow - 1)].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if(position + (cellPerRow + 1) < cellPerRow * cellPerRow) {
            if(cells[position + (cellPerRow + 1)].isSelected == false) {
                cells[position + (cellPerRow + 1)].isSelected = true
                if(cells[position + (cellPerRow + 1)].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position + (cellPerRow + 1)].isSelected = false
            } else {
                if(cells[position + (cellPerRow + 1)].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        if (position + (cellPerRow - 1) < cellPerRow * cellPerRow) {
            if(cells[position + (cellPerRow - 1)].isSelected == false) {
                cells[position + (cellPerRow - 1)].isSelected = true
                if(cells[position + (cellPerRow - 1)].titleLabel?.text == "M") {
                    counter += 1
                }
                cells[position + (cellPerRow - 1)].isSelected = false
            } else {
                if(cells[position + (cellPerRow - 1)].titleLabel?.text == "M") {
                    counter += 1
                }
            }
        }
        
        return String(counter)
    }
}
