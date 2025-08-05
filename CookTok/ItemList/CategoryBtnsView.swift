//
//  CategoryBtnsView.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
//

import SwiftUI
import SwiftData

// MARK: - CategoryBtnsView
struct CategoryBtnsView: View {
    @Query(sort: \User.id) private var userInfo: [User]
   @Binding var selectedCategory:String
    var name:String = ""
   
   var body: some View {
       
      
       VStack {
           HStack{
               ItemBtnsView(p: 2,h:40,name:"vegIcon",isCategory:true, act: {
                   selectedCategory = "Produce"
               })
               
               ItemBtnsView(p: 2,h:40,name:"meatIcon",isCategory:true, act: {
                   selectedCategory = "Meat"
               })
               ItemBtnsView(p: 2,h:40,name:"seafoodIcon",isCategory:true, act: {
                   selectedCategory = "Seafood"
               })
               ItemBtnsView(p: 2,h:40,name:"sauceIcon",isCategory:true, act: {
                   selectedCategory = "Sauce"
               })
               
               
           }//:HStack
           .padding(.horizontal,11)
           .padding(.bottom,50)
           HStack{
               ItemBtnsView(p: 2,h:40,name:"dryIcon",isCategory:true, act: {
                   selectedCategory = "Dry"
               })
               
               ItemBtnsView(p: 2,h:40,name:"dairyIcon",isCategory:true, act: {
                   selectedCategory = "Dairy"
               })
               ItemBtnsView(p: 2,h:40,name:"frozonIcon",isCategory:true, act: {
                  selectedCategory = "Junk"
               })
               ItemBtnsView(p: 2,h:40,name:"etc",isCategory:true, act: {
                  selectedCategory = "Etc"
               })
               
               
           }//:HStack
           .padding(.horizontal,11)
       }
          
           
           
       
       
       
   }
  
    
  func convertLang(_ kr:String,_ en:String) -> String{
      return userInfo.first?.language == "ENG" ? en : kr
        
    }
    
}
 



