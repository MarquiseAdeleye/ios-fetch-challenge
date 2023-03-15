//
//  ViewModel.swift
//  FetchiOSProject
//
//  Created by Marquise Adeleye on 3/14/23.
//

import Foundation
import SwiftUI


//The info in the API seems to be a part of a meals array the the schema in the MealIngredients struct is recongnizing this
struct Meals: Hashable, Codable {
    let meals: [Course]
}

struct Course: Hashable, Codable {
    //adding the object propertie of each meal
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

//These Global variables will hold strings that will be updated and called on trhoughout the app
struct Global {
    static var mealID = ""
    static var mealName = ""
}


class ViewModel: ObservableObject {
    //let the content view know we have meals and that it should update itself
    //Every time this array is updated the view is going to know that it needs to update itself
    //This empty array will store the Course Objects
    @Published public var mealData: [Course] = []
    
    func fetch(){
        
        //Storing/conveting the API as a URL to acessed and called on in the app
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        // Performing the API call to pull data from the api and store this in an array
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(Meals.self, from: data)
                    DispatchQueue.main.async {
                        self.mealData = results.meals
                    }
                }
                catch {
                    print(error)
                }
            }
        }
        .resume()
    }
}


//This is a struct that will house the fucntion to take in URL image data to display the content under specific parameters in the application
struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View{
        //I am unwrapping the property to check if it has an image
        if let data = data, let uiimage = UIImage(data: data){
            
            //Where I am setting the parameters of how the image will display in the view
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("blue"), lineWidth: 5)
                )
                .frame(width: 130, height: 70)
        }
        else{
            // A place holder image that becomes the indicator that an image is loading
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.blue)
                .onAppear{
                    fetchData()
                }
        }
    }
    
    //The function calling the Image url from the API
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, _, _ in
            self.data = data
        }
        task.resume()
    }
}
