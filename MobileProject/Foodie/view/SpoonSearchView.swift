//
//  SpoonSearchView.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-11-19.
//

import SwiftUI

struct SpoonSearchView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var spoonStore: SpoonStore
    @State private var query: String = ""

    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    //MARK: - BODY
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .center){
                TextField("Enter query", text:$query)
                    .autocapitalization(.none)
                    .padding()
                    .multilineTextAlignment(.center)
                Button(action:{
                    //search using query
                    self.spoonStore.getAll(query: self.query)
                }){
                    Text("Enter")
                }
                }
                LazyVGrid(columns: columns){
                    ForEach(spoonStore.spoons ?? [Spoon](), id: \.id){ spoon in
                        NavigationLink(destination: Text("Recipe Details\nTitle: \(spoon.title)\nReady in \(spoon.readyInMinutes) minutes!\nServings: \(spoon.servings)\n\nSummary: \(spoon.summary)")
                                        .padding()
                                    
                        ){
                        VStack{
                            URLImage(url: spoon.image)
                                .frame(width: 100, height: 120)
                            Text(spoon.title)
                                .frame(maxHeight: .infinity, alignment: .top)
                        }
                    }
                }
            }
                
            }//ScrollView
            .navigationBarTitle("Recipes", displayMode: .inline)
            .navigationBarItems(leading: Image(systemName: "magnifyingglass"))
            
        }//NavigationView
//        .onAppear{
//            spoonStore.getAll(query: self.query)
//        }
        
    }//Body
    
}//Struct

struct SpoonSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SpoonSearchView(spoonStore: SpoonStore())
    }
}
