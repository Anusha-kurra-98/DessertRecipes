//
//  MealListView.swift
//  DessertRecipes
//
//  Created by anusha  kurra on 7/7/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.id)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        
                        Text(meal.strMeal)
                    }
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
}
