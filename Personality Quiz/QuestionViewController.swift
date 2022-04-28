//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by mac on 27.04.2022.
//

import UIKit

class QuestionViewController: UIViewController {
            
    
    // MARK: - IB outlet
    @IBOutlet var questionLable: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLables: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLables: [UILabel]!
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var questionProgressView: UIProgressView!
    
    // MARK: - IB Private Properties
    
    private let questions = Question.getQuestions()
    private var quesrtionIndex = 0
    private var answerShoosen: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    

    
    
    
    // MARK: IB Actions
    
    @IBAction func singleAnswersButtonPressed(_ sender: UIButton) {
        
        let currentAnswers = questions[quesrtionIndex].answers
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[currentIndex]
        answerShoosen.append(currentAnswer)
        
        nextQuestion()
    }
    

    @IBAction func multipleAswersButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[quesrtionIndex].answers
        
        for (multileSwitch, answer) in zip (multipleSwitches, currentAnswers) {
            if multileSwitch.isOn {
                answerShoosen.append(answer)
            }
        }
        
        nextQuestion()

    }
    
   
    
    @IBAction func rangeAswersButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[quesrtionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answerShoosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    
    
    // MARC: - Private Methods
    
    // Update user interface
    private func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            
            // hide everithing
            stackView?.isHidden = true
        }
        
        //get current question
        let currentquestion = questions[quesrtionIndex]
        
        // set current question for question lable
        questionLable.text = currentquestion.text
        
       // Calculate progress
        let totalProgress = Float(quesrtionIndex) / Float(questions.count)
        
        
        // set progress for question progress view
        questionProgressView.setProgress(totalProgress, animated: true)
        
        
        // set navigation title
        title = "Вопрос № \(quesrtionIndex + 1) из \(questions.count)"
        let currentAnswers = currentquestion.answers
        
        
        // show stack view corresponding to question type
        
        switch currentquestion.type {
        case .single:
            updateSingleStackView(using: currentAnswers)
        case .multiple:
            updateMultipleStackView(using: currentAnswers)
        case .ranged:
            updateRangedStackView(using: currentAnswers)
        }
        
    }
    
    
    
    /// Setup single stack view
    ///
    /// - Parameter answers: - arrey with answers
    ///
    ///Desription of metod
    
    private func updateSingleStackView(using answers: [Answer]) {
        // Show single stack view
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers)  {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    
    
    /// Setup multiple stack view
    /// - Parameter answer: - arrey with answers
    ///
    ///Desription of metod
    private func updateMultipleStackView(using answers: [Answer]) {
        // Show multiple stack view
        multipleStackView.isHidden = false
        
        for (lable, answer) in zip(multipleLables, answers) {
            lable.text = answer.text
        }
     }
    
    private func updateRangedStackView(using answers: [Answer]) {
        // Show ranged stack view
        rangedStackView.isHidden = false
        
        rangedLables.first?.text = answers.first?.text
        rangedLables.last?.text = answers.last?.text
    }
    
    
    
    //     MARK: - Navigation
    //     Show next question or go to next screen
    private func nextQuestion() {
        quesrtionIndex += 1
        
        if quesrtionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resaltSegue", sender: nil)
        }
    }
    
 
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "resaltSegue" else { return }
            let resultVC = segue.destination as! ResaltViewController
            resultVC.responses = answerShoosen
        }

    
}
