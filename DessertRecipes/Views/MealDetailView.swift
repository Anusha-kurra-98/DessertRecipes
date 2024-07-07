//
//  MealDetailView.swift
//  DessertRecipes
//
//  Created by anusha  kurra on 7/7/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let mealDetail = viewModel.mealDetail {
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    
                    Text(mealDetail.strMeal)
                        .font(.title)
                    
                    Text("Instructions")
                        .font(.headline)
                    Text(mealDetail.strInstructions)
                    
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(mealDetail.ingredientsWithMeasurements, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
        .navigationTitle("Meal Details")
        .task {
            await viewModel.fetchMealDetail(id: mealId)
        }
    }
}
