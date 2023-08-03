//
//  HomeViewModel.swift
//  KennyGame
//
//  Created by İbrahim Halil ULU on 3.08.2023.
//

import Foundation

struct HomeViewModel{
    private let userDefaultInstance : UserDefaults = UserDefaults.standard
    private let highScoreKey = "highScore"

    let sizeUI : CGSize
    // score and timer
    var highScrore = 0
    var currentScore = 0
    var currentTimer = 10
    
    // labels
    var timerLabelY =  CGFloat(0)
    var scoreLabelY = CGFloat(0)
    var highScoreLabelY = CGFloat(0)
    
    var imagePosition : ImagePosition = ImagePosition.topRight
    
    init(sizeUI: CGSize) {
        self.sizeUI = sizeUI
        
        getHighScoreFromUserDefaults()
        setLabelSize()
    }
    
    private mutating func setLabelSize(){
        timerLabelY = sizeUI.height * 0.065
        scoreLabelY = timerLabelY + (sizeUI.height * 0.02) + (50)
        highScoreLabelY = sizeUI.height * 0.85
    }
    
    func calculateImageViewPosition() -> CGRect{
        let x = self.sizeUI.width * 0.05
        let totalW = self.sizeUI.width - (x * 2)
        let imageW = totalW / 3
        
        let y = scoreLabelY + (self.sizeUI.height * 0.05)
        let spaceHeight = self.sizeUI.height - y - (self.sizeUI.height - highScoreLabelY)
        let imageH = spaceHeight / 3
        
        var currentX : CGFloat?
        var currentY : CGFloat?
        
        switch imagePosition {
        case .topLeft:
            currentX = x
            currentY = y
            //position = CGRect(x: x , y: y, width: imageW, height: imageH)
        case .topCenter:
            currentX = x + imageW
            currentY = y
        case .topRight:
            currentX = x + (imageW * 2)
            currentY = y
        case .centerLeft:
            currentX = x
            currentY = y + imageH
        case .center:
            currentX = x + imageW
            currentY = y + imageH
        case .centerRight:
            currentX = x + (imageW * 2)
            currentY = y + imageH
        case .bottomLeft:
            currentX = x
            currentY = y + (imageH * 2)
        case .bottomCenter:
            currentX = x + imageW
            currentY = y + (imageH * 2)
        case .bottomRight:
            currentX = x + (imageW * 2)
            currentY = y + (imageH * 2)
        }
        
        return CGRect(x: currentX!, y: currentY!, width: imageW, height: imageH)
    }
    
    private func random() -> ImagePosition {
        let all: [ImagePosition] = [.topLeft, .topCenter, .topRight, .centerLeft, .center, .centerRight, .bottomLeft, .bottomCenter, .bottomRight]
           let randomIndex = Int(arc4random()) % all.count
           return all[randomIndex]
   }
    
    mutating func setImagePosition(){
        self.imagePosition = random()
    }
    
    func setHighScoreToUserDefaults(){
        userDefaultInstance.set(self.highScrore, forKey: highScoreKey)
    }
    
    private mutating func getHighScoreFromUserDefaults(){
        let value : Int?  = userDefaultInstance.integer(forKey: highScoreKey)
        
        if value != nil {
            self.highScrore = value!
        }
    }
}

enum ImagePosition{
    case topLeft, topCenter, topRight, centerLeft, center, centerRight, bottomLeft, bottomCenter, bottomRight
}
