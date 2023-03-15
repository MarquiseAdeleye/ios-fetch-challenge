//
//  IngredientModel.swift
//  FetchiOSProject
//
//  Created by Marquise Adeleye on 3/15/23.
//

import Foundation
import SwiftUI

//The info in the API seems to be a part of a meals array the the schema in the MealIngredients struct is recongnizing this
struct MealIngrident: Hashable, Codable {
    let meals: [Ingredients]
}

//Added the schema to the ingredients struct
struct Ingredients: Hashable, Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    var activeIngredients: [String] {
        // Make an array that contains all the ingredient properties in the data model
        let allIngredients = [strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20]
        // Make an array to store only active ingredients
        // Loop through the array and do a check if each item is not empty or not nil add to the activeIngredients array
        var temp: [String] = []
        //I am creating a loop that will allow me to check if the property in the String? array is null or empty
        for ingredient in allIngredients{
            //I need to unwrap each property through the if let statement so that I can know if it is null or holds a string
            if let ingredient = ingredient, ingredient != "" {
                temp.append(ingredient)
            }
        }
        return temp
    }
    
    var activeMeasurements: [String] {
        let allMeasurements = [strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20]
        
        var temp: [String] = []
        //I am creating a loop that will allow me to check if the property in the String? array is null or empty
        for measurement in allMeasurements{
            //I need to unwrap each property through the if let statement so that I can know if it is null or holds a string
            if let measurement = measurement, measurement != "" {
                temp.append(measurement)
            }
        }
        return temp
    }
}


class IngredientModel: ObservableObject{
    @Published public var dessertData: [Ingredients] = []
    
    func fetchDessert(){
        // ERROR HERE
        //let mealID = presentedView.mealID
        //  print("mealID" + mealID)
        let mealID = Global.mealID
        //Assigning the API to the URL variable
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            return
        }
        // Performing the API call to get the data
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(MealIngrident.self, from: data)
                    DispatchQueue.main.async {
                        self.dessertData = results.meals
                        
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
    
}
