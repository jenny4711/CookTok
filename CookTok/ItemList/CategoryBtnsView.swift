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
               ItemBtnsView(p: 2,h:40,name:convertLang("채소", "Produce"), act: {
                   selectedCategory = "Produce"
               })
               
               ItemBtnsView(p: 2,h:40,name:convertLang("고기", "Meat"), act: {
                   selectedCategory = "Meat"
               })
               ItemBtnsView(p: 2,h:40,name:convertLang("해산물", "Seafood"), act: {
                   selectedCategory = "Seafood"
               })
               ItemBtnsView(p: 2,h:40,name:convertLang("양념", "Sauce"), act: {
                   selectedCategory = "Sauce"
               })
               
               
           }//:HStack
           .padding(.horizontal,11)
           
           HStack{
               ItemBtnsView(p: 2,h:40,name:convertLang("말린제품", "Dry"), act: {
                   selectedCategory = "Dry"
               })
               
               ItemBtnsView(p: 2,h:40,name:convertLang("유제품", "Dairy"), act: {
                   selectedCategory = "Dairy"
               })
               ItemBtnsView(p: 2,h:40,name:convertLang("냉동식품", "Junk"), act: {
                  selectedCategory = "Junk"
               })
               ItemBtnsView(p: 2,h:40,name:convertLang("기타", "Etc"), act: {
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
 



