//
//  AnimalType.swift
//  Personality Quiz
//
//  Created by mac on 27.04.2022.
//

enum AnimalType: String {
    case dog = "🐶"
    case cat = "🐱"
    case rabit = "🐰"
    case tortill = "🐢"
    
    var difinition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь."
        case .cat:
            return "Вы себе на уме, любите гулять сами по себе. Вы любите одиночество."
        case .rabit:
            return "Вам нравится все мягкое. Вы здоровы и полны энергии. Вам по душе скорость и задорность."
        case .tortill:
            return "Ваша сила -  в мудрости. Медленный и вдумчивый выигрывает на дальних дистанциях."
        }
    }
}
