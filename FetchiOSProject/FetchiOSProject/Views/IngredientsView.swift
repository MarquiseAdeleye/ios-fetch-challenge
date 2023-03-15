//
//  IngredientsView.swift
//  FetchiOSProject
//
//  Created by Marquise Adeleye on 3/14/23.
//

import SwiftUI
import Foundation


struct IngredientsView: View {
    @StateObject var ingredientModel = IngredientModel()
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        NavigationView{
            
            
            List{
                
                //creating a loop of the meals to display the contents of the API
                ForEach(ingredientModel.dessertData,id: \.self) { idMeal in
                    Group{
                        
                        VStack{
                            
                            Text("Instructions:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color("blue"))
                                .bold()
                                .padding()
                            
                            Text("\(idMeal.strInstructions)")
                                .foregroundColor(Color("blue"))
                                .padding()
                            HStack{
                                VStack{
                                    Text("Ingredients:")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(Color("blue"))
                                        .bold()
                                        .padding()
                                    //creating a loop to display the contents of the API under the set parameters
                                    ForEach(idMeal.activeIngredients, id: \.self){ ingredient in
                                        Text(ingredient)
                                            .foregroundColor(Color("blue"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                    }
                                }
                                VStack{
                                    Text("Measurements:")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.25)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .foregroundColor(Color("blue"))
                                        .bold()
                                        .padding()
                                    
                                    ForEach(idMeal.activeMeasurements, id: \.self){ measurement in
                                        Text(measurement)
                                            .foregroundColor(Color("blue"))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                    }
                                }
                            }
                        }
                        
                    }
                
                    
                    .padding(3)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text(Global.mealName)
                            .foregroundColor(Color("blue"))
                            .font(.system(size: 30))
                            .bold()
                    }
                }
            }
            .toolbarBackground(
                Color("green"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear{
                ingredientModel.fetchDessert()
            }
        }
        
        Button("Return"){
            dismiss()
        }
        .bold()
    }
}









struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}

