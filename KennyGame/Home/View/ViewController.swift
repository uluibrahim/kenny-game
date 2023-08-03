//
//  ViewController.swift
//  KennyGame
//
//  Created by İbrahim Halil ULU on 3.08.2023.
//

import UIKit

class ViewController: UIViewController {
    private var viewModel : HomeViewModel?
    
    
    // UI Items
    var timerLabel : CustomLabel?
    var scoreLabel : CustomLabel?
    var highScoreLabel : CustomLabel?
    var startButton : CustomButton?
    let imageView = UIImageView(image: UIImage(named: "kenny"))
    
    var timer = Timer()
    
    var sizeUI : CGSize?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeUI = view.frame.size
        viewModel = HomeViewModel(sizeUI: self.sizeUI!)
        
        // print(sizeUI?.width) // 393
        // print(sizeUI?.height) // 852
        createTimerLabel()
        createScoreLabel()
        createHighScoreLabel()
        createButton()
        createImageView()
    }
    
    private func createTimerLabel(){
        timerLabel = CustomLabel(sizeUI: self.sizeUI!, y: viewModel!.timerLabelY)
        timerLabel!.text = "\(viewModel!.currentTimer)"
        view.addSubview(timerLabel!)
    }
    private func createScoreLabel(){
        scoreLabel = CustomLabel(sizeUI: self.sizeUI!, y: viewModel!.scoreLabelY)
        scoreLabel!.text = "Score: \(viewModel!.currentScore)"
        view.addSubview(scoreLabel!)
    }
    
    private func createHighScoreLabel(){
        highScoreLabel = CustomLabel(sizeUI: self.sizeUI!, y: viewModel!.highScoreLabelY)
        highScoreLabel!.text = "High Score: \(viewModel!.highScrore)"
        view.addSubview(highScoreLabel!)
    }
    
    private func createButton(){
        startButton = CustomButton(sizeUI: self.sizeUI!, y: (viewModel!.highScoreLabelY) - (sizeUI!.height * 0.1))
        
        view.addSubview(startButton!)
        
        startButton!.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
    }
    
    @objc func startButtonAction(){
        viewModel!.currentScore = 0
        viewModel!.currentTimer = 10
        timerLabel!.text  = "\(viewModel!.currentTimer)"
        scoreLabel!.text = "Score \(viewModel!.currentScore)"
        if !timer.isValid {
            if startButton!.isEnabled{
                startButton!.isHidden = true
                imageView.isHidden = false
            }
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerSelector), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerSelector(){
        if viewModel!.currentTimer > 0{
            changeImagePosition()
            viewModel!.currentTimer -= 1
            timerLabel!.text = "\(viewModel!.currentTimer)"
        } else {
            imageView.isHidden = true
            timerLabel!.text = "Time Finished"
            startButton!.isHidden = false
            if (viewModel!.currentScore) >= (viewModel!.highScrore){
                viewModel!.highScrore = viewModel!.currentScore
                highScoreLabel!.text = "High Score: \(viewModel!.highScrore)"
                viewModel!.setHighScoreToUserDefaults()
            }
            timer.invalidate()
        }
    }
    
    private func createImageView(){
        imageView.isUserInteractionEnabled = true
        imageView.isHidden = true
        imageView.frame = viewModel!.calculateImageViewPosition()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(incrementScore))
        imageView.addGestureRecognizer(recognizer)
        view.addSubview(imageView)
    }
    
    @objc func incrementScore(){
        viewModel!.currentScore += 1
        scoreLabel!.text = "Score \(viewModel!.currentScore)"
    }
    
    private func changeImagePosition(){
        viewModel!.setImagePosition()
        imageView.frame = viewModel!.calculateImageViewPosition()
    }
}


