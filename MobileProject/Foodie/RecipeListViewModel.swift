//
//  RecipeListViewModel.swift
//  Foodie
//
//  Created by Pallavi Singla on 2020-12-09.
//


import Foundation
import CoreData
import UIKit
import Combine

public class RecipeListViewModel: ObservableObject{
    @Published var myRecipeList = [MyRecipe]()
    
    private let moc : NSManagedObjectContext
    init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertmyRecipe(title : String, ifFavourite : Bool, describe : String){
        do {
            let newMyRecipe = NSEntityDescription.insertNewObject(forEntityName: "MyRecipe", into: moc) as! MyRecipe
            newMyRecipe.id = UUID()
            newMyRecipe.title = title
            newMyRecipe.ifFavourite = ifFavourite
            newMyRecipe.describe = describe
            
            try moc.save()
            self.myRecipeList.append(newMyRecipe)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.localizedDescription)")
        }
    }
    func updateMyRecipe(){
        do{
            try moc.save()
            
            print("Recipe marked favourite")
        }catch{
            print("Unable to mark recipe as favourite")
        }
    }
    
    func deleteMyRecipeByID(myRecipeID: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyRecipe")
        let predicate = NSPredicate(format: "id == %@", myRecipeID as CVarArg)
        fetchRequest.predicate = predicate
        
        do{
            let myRecipeToDelete = try moc.fetch(fetchRequest).first as! NSManagedObject
            
            do{
                moc.delete(myRecipeToDelete)
                try moc.save()
                print("Recipe deleted Successfully")
                
                if let index = self.myRecipeList.firstIndex(of: myRecipeToDelete as! MyRecipe) {
                    self.myRecipeList.remove(at: index)
                }
                
            }catch{
                print("Recipe deletion unsuccessful")
            }
        }catch{
            print("Unable to delete Recipe")
        }
    }
    
    func getAllMyRecipes(){
        
        let fetchRequest = NSFetchRequest<MyRecipe>(entityName: "MyRecipe")
        
        do {
            let result = try moc.fetch(fetchRequest)
            self.myRecipeList = result as [MyRecipe]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.localizedDescription)")
        }
        
    }
    
    
    
}
