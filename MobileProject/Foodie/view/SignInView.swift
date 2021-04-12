

//
//  SignInView.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-11-12.
//

import SwiftUI

struct SignInView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var userSettings: UserSettings
    @State private var email:String = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
    @State private var password:String = UserDefaults.standard.string(forKey: "KEY_PASSWORD") ?? ""
    @State private var rememberMe: Bool = true
    @State private var selection: Int? = nil
    @State private var invalidLogin: Bool = false
    @State private var isEmpty: Bool = false

    //MARK: - BODY
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                Spacer()
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 400)
                            .padding(5)
                          
                        SecureField("Password", text: self.$password)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 400)
                            .padding(5)
                          
                            NavigationLink(destination: SignUpView(), tag: 2, selection: $selection) {}

                            Toggle(isOn: self.$rememberMe, label: {
                                Text("Remember Me")
                                    .bold()
                                    .accentColor(Color.black)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15)
                                        .opacity(0.4)
                                        .foregroundColor(.green))
                                    .cornerRadius(5.0)
                            }).padding(10)
                Spacer()

                        //todo: Add Proper Navigation to Home Screen
                        NavigationLink(destination: HomeView(email: self.email), tag: 3, selection: $selection){}

                        Button(action: {
                            print("Sign In Clicked")
                            if (self.isValidData()){
                                
                                if (self.validateUser()){
                                    print("Login Successful")
                                    //User Defaults
                                    if (self.rememberMe){
                                        //Saving to User Defaults
                                        UserDefaults.standard.setValue(self.email, forKey: "KEY_EMAIL")
                                        UserDefaults.standard.setValue(self.password, forKey: "KEY_PASSWORD")
                                    }else{
                                        //Remove from User Defaults
                                        UserDefaults.standard.removeObject(forKey: "KEY_EMAIL")
                                        UserDefaults.standard.removeObject(forKey: "KEY_PASSWORD")
                                    }
                                    userSettings.userEmail = self.email
                                    self.selection = 3
                                }
                                else{
                                    print("Incorrect Login")
                                    self.invalidLogin = true
                                }
                            }
                            else{print("Empty Login")
                                self.isEmpty = true
                            
                            }

                        }){
                            HStack {
                                Image(systemName: "hand.point.up.fill")
                                Text("Sign In")
                                    }
                            .accentColor(Color.black)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                .opacity(0.4)
                                .foregroundColor(.green))
                            .cornerRadius(5.0)
                        }
                        .alert(isPresented: self.$invalidLogin){
                            Alert(
                                title: Text("Error"),
                                message: Text("Incorrect Login"),
                                dismissButton: .default(Text("Try Again"))
                            )
                        }//Alert
                        .alert(isPresented: self.$isEmpty){
                            Alert(
                                title: Text("Error"),
                                message: Text("Empty Login"),
                                dismissButton: .default(Text("Try Again"))
                            )
                        }//Alert
                Button(action:{
                    print("Create Account Clicked")
                    self.selection = 2
                    
                }){
                    HStack {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                        Text("New User? \nCreate Account")
                            }
                    .accentColor(Color.black)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .opacity(0.4)
                        .foregroundColor(.green))
                    .cornerRadius(5.0)
                }
                Spacer()

            }//VStack
            .background(Image("recipe2").scaledToFit().opacity(0.4))
            .navigationBarTitle("Foodie", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
        }//NavigationView

        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            self.userViewModel.getAllUsers()

            //to see what accounts are currently in core data
            for user in self.userViewModel.userList{
                print(#function, "Name: \(user.name ?? "Unknown") Email: \(user.email!) Password: \(user.password!)")
            }
        }
    }//Body

    //MARK: - isValidData
    private func isValidData() -> Bool{
        if self.email.isEmpty{
            return false
        }
        if self.password.isEmpty{
            return false
        }
        return true
    }

    //MARK: - validateUser
    private func validateUser() -> Bool{
        self.userViewModel.findUserByEmail(email: self.email)

        if (self.userViewModel.loggedInUser != nil){
            if (self.password == self.userViewModel.loggedInUser!.password){
                return true
            }
        }else{
            self.invalidLogin = true
            return false
        }
        return false
    }

}//Struct SignInView

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environment(\.locale, .init(identifier: "fr"))
    }
}
