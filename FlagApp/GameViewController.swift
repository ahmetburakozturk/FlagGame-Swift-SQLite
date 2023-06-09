//
//  GameViewController.swift
//  FlagApp
//
//  Created by ahmetburakozturk on 2.06.2023.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var wrongScoreLabel: UILabel!
    @IBOutlet weak var correctScoreLabel: UILabel!
    
    var questionCount = 0
    var flags : [Flag]?
    var currentFlag : Flag?
    var correctCounter = 0
    var wrongCounter = 0
    var alert : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNextQuestion()
        
        alert = UIAlertController(title: "Game End", message: "Game is end", preferredStyle: UIAlertController.Style.alert)
        let retryButton = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.viewDidLoad()
        }
        let cancelButton = UIAlertAction(title: "Home", style: UIAlertAction.Style.cancel){ (UIAlertAction) in
            self.performSegue(withIdentifier: "goBack", sender: nil)
        }
        alert!.addAction(retryButton)
        alert!.addAction(cancelButton)
    }
    
    func getNextQuestion(){
        questionCount += 1
        flags = Flagdao().getByRandomLimit()
        if flags!.count > 3 {
            answerButton1.setTitle(flags![0].FlagCountry, for: UIControl.State.normal)
            answerButton1.backgroundColor = UIColor(ciColor: .cyan)
            answerButton2.setTitle(flags![1].FlagCountry, for: UIControl.State.normal)
            answerButton2.backgroundColor = UIColor(ciColor: .cyan)
            answerButton3.setTitle(flags![2].FlagCountry, for: UIControl.State.normal)
            answerButton3.backgroundColor = UIColor(ciColor: .cyan)
            answerButton4.setTitle(flags![3].FlagCountry, for: UIControl.State.normal)
            answerButton4.backgroundColor = UIColor(ciColor: .cyan)

            currentFlag = flags![Int.random(in: 0...3)]
            flagImageView.image = UIImage(named: currentFlag!.FlagImage!)
            questionLabel.text = "Question - \(questionCount)"
        }
        
    }
    
    @IBAction func answerButton1Clicked(_ sender: Any) {
        checkAnswer(country: answerButton1.titleLabel!.text!, button: answerButton1)
    }
    @IBAction func answerButton2Clicked(_ sender: Any) {
        checkAnswer(country: answerButton2.titleLabel!.text!, button: answerButton2)
    }
    @IBAction func answerButton4Clicked(_ sender: Any) {
        checkAnswer(country: answerButton4.titleLabel!.text!, button: answerButton4)
    }
    @IBAction func answerButton3Clicked(_ sender: Any) {
        checkAnswer(country: answerButton3.titleLabel!.text!, button: answerButton3)
    }
    
    func checkAnswer(country:String, button:UIButton){
        if questionCount == 5 {
            endGame()
        } else {
            if country == currentFlag!.FlagCountry {
                button.backgroundColor = UIColor(ciColor: .green)
                correctCounter += 1
                correctScoreLabel.text = String(correctCounter)
            } else {
                button.backgroundColor = UIColor(ciColor: .red)
                wrongCounter += 1
                wrongScoreLabel.text = String(wrongCounter)
            }
            getNextQuestion()
        }
        
    }
    
    func endGame(){
        questionCount = 0
        correctCounter = 0
        correctScoreLabel.text = "0"
        wrongCounter = 0
        wrongScoreLabel.text = "0"
        let result = 100 - (wrongCounter * 20)
        alert!.message = "Score: %\(result)"
        self.present(alert!, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}
