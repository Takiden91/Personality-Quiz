//
//  ResaltViewController.swift
//  Personality Quiz
//
//  Created by mac on 27.04.2022.
//

import UIKit

class ResaltViewController: UIViewController {
    
 
    // IB  outlet
    @IBOutlet var resaltAnswerLable: UILabel!
    @IBOutlet var resaltDefinitionLable: UILabel!
    
    // Public properties
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResult()
    }
    
    
    private func updateResult() {
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        let animals = responses.map { $0.type }
        
        for animal in animals {
            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
        }
        
        let soertedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value}
        
        guard let mostFrequencyOfAnimals = soertedFrequencyOfAnimals.first?.key else { return }
        updateUI(with: mostFrequencyOfAnimals)
        
    }
    
    private func updateUI(with animal: AnimalType) {
        resaltAnswerLable.text = "Вы - \(animal.rawValue)"
        resaltDefinitionLable.text = "\(animal.difinition)"
    }
}

