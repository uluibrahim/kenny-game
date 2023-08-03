//
//  CustomLabel.swift
//  KennyGame
//
//  Created by İbrahim Halil ULU on 3.08.2023.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    let sizeUI : CGSize
    let labelsH = CGFloat(50)
    let y : CGFloat
    
    init(sizeUI: CGSize, y: CGFloat) {
        self.sizeUI = sizeUI
        self.y = y
        let w = CGFloat(self.sizeUI.width * 0.5)
      
        super.init(frame: CGRect(x: 100 , y: self.y, width: w, height: labelsH))
        
        let x = calculateXForCenter(width: w)
        self.frame = CGRect(x: x , y: self.y, width: w, height: labelsH)
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func calculateXForCenter(width: CGFloat) -> CGFloat{
        return (sizeUI.width / 2) - (width / 2)
    }
}
