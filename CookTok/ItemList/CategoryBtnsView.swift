//
//  CategoryBtnsView.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
//

import SwiftUI


// MARK: - CategoryBtnsView
struct CategoryBtnsView: View {
   @Binding var selectedCategory:String
    var name:String = ""
   
   var body: some View {
       
      
       VStack {
           HStack{
               ItemBtnsView(p: 2,h:40,name:"Produce", act: {
                   selectedCategory = "Produce"
               })
               
               ItemBtnsView(p: 2,h:40,name:"Meat", act: {
                   selectedCategory = "Meat"
               })
               ItemBtnsView(p: 2,h:40,name:"Seafood", act: {
                   selectedCategory = "Seafood"
               })
               ItemBtnsView(p: 2,h:40,name:"Sauce", act: {
                   selectedCategory = "Sauce"
               })
               
               
           }//:HStack
           .padding(.horizontal,11)
           
           HStack{
               ItemBtnsView(p: 2,h:40,name:"Dry", act: {
                   selectedCategory = "Produce"
               })
               
               ItemBtnsView(p: 2,h:40,name:"Dairy", act: {
                   selectedCategory = "Dairy"
               })
               ItemBtnsView(p: 2,h:40,name:"Junk", act: {
                  selectedCategory = "Junk"
               })
               ItemBtnsView(p: 2,h:40,name:"Etc", act: {
                  selectedCategory = "Etc"
               })
               
               
           }//:HStack
           .padding(.horizontal,11)
       }
          
           
           
       
       
       
   }
}
 



