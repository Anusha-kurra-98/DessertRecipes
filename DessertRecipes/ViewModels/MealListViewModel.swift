//
//  MealListViewModel.swift
//  DessertRecipes
//
//  Created by anusha  kurra on 7/7/24.
//

import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    func fetchMeals() async {
        do {
            meals = try await APIService.shared.fetchDesserts()
        } catch {
            print("Error fetching meals: \(error)")
        }
    }
}
