//
//  MealDetailViewModel.swift
//  DessertRecipes
//
//  Created by anusha  kurra on 7/7/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    
    func fetchMealDetail(id: String) async {
        do {
            mealDetail = try await APIService.shared.fetchMealDetails(id: id)
        } catch {
            print("Error fetching meal details: \(error)")
        }
    }
}
