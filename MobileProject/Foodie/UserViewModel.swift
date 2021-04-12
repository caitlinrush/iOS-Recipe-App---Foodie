//
//  UserViewModel.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-11-12.
//

import Foundation
import CoreData
import SwiftUI
import UIKit

public class UserViewModel : ObservableObject {
    @Published var loggedInUser : User?
    @Published var userList = [User]()
    
    private let moc : NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.moc = context
    }
    //MARK: - INSERT USER
    func insertUser(name: String, email: String, password: String){
        do{
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: moc) as! User
            
            newUser.email = email
            newUser.name = name
            newUser.password = password
            
            try moc.save()
            
            print("User account successfully created")
            
        }catch let error as NSError{
            print("Something went wrong. Couldn't create account.")
            print("\(error) \(error.localizedDescription)")
        }
    }
    //MARK: - FIND USER BY EMAIL
    func findUserByEmail(email: String){
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        //filters WHERE - optional
        let predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.predicate = predicate
        //to sort the retrieved results ORDER BY - optional
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            if let matchedUser = try moc.fetch(fetchRequest).first{
                self.loggedInUser = matchedUser
                print("Matching user found")
            }
        }catch let error as NSError{
            print("Something went wrong. Couldn't fetch the user account details.")
            print("\(error) \(error.localizedDescription)")
        }
    }
    //MARK: - GET ALL USERS
    func getAllUsers(){
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        do{
            let result = try moc.fetch(fetchRequest)
            userList = result as [User]
        
        }catch let error as NSError{
            print(#function, "Couldn't fetch! \(error.localizedDescription)")
            //#function will show you which method the error is coming from
        }
        
    }
    //MARK: - UPDATE USER
    func updateUser(){
        do{
            try moc.save()
            
            print(#function, "The user info has been updated successfully")
        }catch let error as NSError{
            print(#function, "Unable to update user info \(error.localizedDescription)")
        }
    }
    //MARK: - DELETE USER
    func deleteUser(){
        do{
            moc.delete(loggedInUser! as NSManagedObject)
            try moc.save()
            
            print(#function, "User account successfully deleted.")
        }catch let error as NSError{
            print(#function, "Cannot delete user account \(error.localizedDescription)")
        }
    }
}
