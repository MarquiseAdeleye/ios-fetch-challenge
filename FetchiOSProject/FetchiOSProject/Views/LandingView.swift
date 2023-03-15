//
//  ContentView.swift
//  FetchiOSProject
//
//  Created by Marquise Adeleye on 3/14/23.
//

import Foundation
import SwiftUI


struct LandingView: View {
    @StateObject var viewModel = ViewModel()
    @State private var showDessert = false
    
    
    var body: some View {
        ZStack{
            
            NavigationView{
                
                //creating a loop of the meals to show the contents of the model
                List{
                    
                    //Creating a loop that iterates through the API and displays the information
                    ForEach(viewModel.mealData,id: \.self) { idMeal in
                        ZStack{
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(Color("gold"))
                                .frame(width: 325, height: 200)
                            HStack{
                                //Calling my URLImage Struct to display the image view under the parameters of the struct
                                URLImage(urlString: idMeal.strMealThumb)
                                Text(idMeal.strMeal)
                                    .foregroundColor(Color("blue"))
                                    .bold()
                            }
                            .foregroundColor(Color("blue"))
                            .onTapGesture {
                                Global.mealID = "\(idMeal.idMeal)"
                                Global.mealName = "\(idMeal.strMeal)"
                                showDessert.toggle()
                            }
                        }
                        .sheet(isPresented: $showDessert){
                            IngredientsView()
                        }
                        .padding(30)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Text("Desserts 🍪")
                                .foregroundColor(Color("blue"))
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                }
                .toolbarBackground(
                    Color("green"),
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
            .onAppear{
                viewModel.fetch()
            }
        }
    }
    
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}





