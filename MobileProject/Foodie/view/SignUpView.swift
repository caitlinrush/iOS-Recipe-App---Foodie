//
//  SignUpView.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-11-12.
//

import SwiftUI

struct SignUpView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var userViewModel : UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    //MARK: - BODY
    var body: some View {
        ZStack{
            VStack{
                //Form{
                //Section(header: Text("Creating Recipes Starts With You")){
                Text("Creating Recipes Starts With You")
                TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 400)
                        .padding(5)
                    
                    TextField("Email", text:$email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .frame(maxWidth: 400)
                        .padding(5)
                    
                    SecureField("Password", text:$password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 400)
                        .padding(5)
                    
                    SecureField("Confirm Password", text:$confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 400)
                        .padding(5)

                        
                //}//Info Section
                // }//Form
                //.disableAutocorrection(true)
                // Spacer()
                //Section{
                    Button(action: {
                        print("Creating Account")
                        if (self.validateData()){
                            self.addNewUser()
                        }
                        
                    }){
                        HStack {
                            Image(systemName: "person.badge.plus")
                            Text("Create Account")
                                }
                        .accentColor(Color.blue)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .opacity(0.2))
                        .cornerRadius(5.0)
                    }
                //}//Section
            }//VStack
            .background(Image("recipe").scaledToFit().opacity(0.2))
        }
        .navigationBarTitle("Sign Up",
                            displayMode: .inline).font(.headline)
        
        
    }//Body
    
    //MARK: - validateData
    func validateData() -> Bool{
        if (self.password != self.confirmPassword){
            return false
        }
        return true
    }
    
    //MARK: - addNewUser
    func addNewUser(){
        self.userViewModel.insertUser(name: self.name, email: self.email, password: self.password)
        
        //pop current View from the stack
        self.presentationMode.wrappedValue.dismiss()
    }
    
}//Struct SignUpView

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environment(\.locale, .init(identifier: "fr"))
    }
    
}

