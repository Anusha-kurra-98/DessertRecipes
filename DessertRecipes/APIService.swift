//
//  APIService.swift
//  DessertRecipes
//
//  Created by anusha  kurra on 7/7/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchDesserts() async throws -> [Meal] {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
        
        let decodedResponse = try JSONDecoder().decode(MealResponse.self, from: data)
        return decodedResponse.meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    func fetchMealDetails(id: String) async throws -> MealDetail {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
        
        let decodedResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        guard let mealDetail = decodedResponse.meals.first else {
            throw APIError.decodingError
        }
        return mealDetail
    }
}
