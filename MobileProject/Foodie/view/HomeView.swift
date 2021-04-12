//
//  Homeview.swift
//  Foodie
//
//  Created by Pallavi Singla on 2020-11-12.
//

import SwiftUI

struct HomeView: View {
    @State private var selection: Int? = nil
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    
   // @State private var selection: Int? = nil
    
    var email: String = ""
    
    var body: some View {
        NavigationLink(
            destination: SignInView(), tag: 1, selection: $selection){}
        NavigationLink(
            destination: NewRecipeView(), tag: 2, selection: $selection){}
        
        NavigationLink(
            destination: SpoonSearchView(spoonStore: SpoonStore()), tag: 3, selection: $selection){}
        NavigationLink(
            destination: ProfileView(), tag: 4, selection: $selection){}
        
        ZStack{
            VStack{
                Button(action:
                        {
                            print("New Recipe")
                            self.selection = 2
                        }){
                    HStack {
                        Image(systemName: "plus.diamond.fill")
                        Text("View Recipe List")
                            }
                    .accentColor(Color.black)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .opacity(0.4)
                        .foregroundColor(.yellow))
                    .cornerRadius(5.0)
                }
                Image("dish")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                Button(action:
                        {
                            print("Search View")
                            self.selection = 3
                        })
                {
                    HStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Search Recipe")
                            }
                    .accentColor(Color.black)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .opacity(0.4)
                        .foregroundColor(.yellow))
                    .cornerRadius(5.0)
                }
                               
            }
            .background(Image("recipe").scaledToFit().opacity(0.2))
        }
        
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Menu{
                    Button("Delete Account", action: self.deleteAccount)
                    Button("Manage Profile", action: self.manageProfile)
                    Button("Sign Out", action: self.signOut)
                }label: {
                    Image(systemName: "gear")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Foodie")
        
    }
    
    private func deleteAccount(){
        self.userViewModel.deleteUser()
        self.selection = 1
        UserDefaults.standard.removeObject(forKey: "KEY_EMAIL")
        UserDefaults.standard.removeObject(forKey: "KEY_PASSWORD")
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func manageProfile(){
        self.selection = 4
    }
    
    
    private func signOut(){
        self.selection = 1
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
}

struct Homeview_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
