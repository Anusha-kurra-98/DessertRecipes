//
//  Models.swift
//  DessertRecipes
//
//  Created by anusha  kurra on 7/7/24.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String { idMeal }
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

struct MealDetail: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    private let ingredients: [String?]
    private let measurements: [String?]
    
    var id: String { idMeal }
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
             strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
             strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
             strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
             strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
             strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
             strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        ingredients = try (1...20).map { i in
            try container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strIngredient\(i)")!)
        }
        
        measurements = try (1...20).map { i in
            try container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strMeasure\(i)")!)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strInstructions, forKey: .strInstructions)
        try container.encode(strMealThumb, forKey: .strMealThumb)
        
        for (index, ingredient) in ingredients.enumerated() {
            if let ingredient = ingredient {
                try container.encode(ingredient, forKey: CodingKeys(rawValue: "strIngredient\(index + 1)")!)
            }
        }
        
        for (index, measurement) in measurements.enumerated() {
            if let measurement = measurement {
                try container.encode(measurement, forKey: CodingKeys(rawValue: "strMeasure\(index + 1)")!)
            }
        }
    }
    
    var ingredientsWithMeasurements: [String] {
        zip(ingredients, measurements)
            .compactMap { ingredient, measurement in
                if let ingredient = ingredient, !ingredient.isEmpty,
                   let measurement = measurement, !measurement.isEmpty {
                    return "\(ingredient) - \(measurement)"
                }
                return nil
            }
    }
}
