//
//  CustomButton.swift
//  KennyGame
//
//  Created by İbrahim Halil ULU on 3.08.2023.
//

import Foundation
import UIKit

class CustomButton : UIButton{
    let sizeUI : CGSize
    let y : CGFloat
    
    init(sizeUI: CGSize, y: CGFloat) {
        self.sizeUI = sizeUI
        self.y = y
        
        let w = self.sizeUI.width * 0.3
        
        super.init(frame: CGRect(x: (self.sizeUI.width / 2) - (w / 2) , y: y, width: w, height: 50))
        
        self.layer.cornerRadius = 20
        self.setTitle("Start", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .blue
        self.clipsToBounds = true
        self.layer.opacity = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
