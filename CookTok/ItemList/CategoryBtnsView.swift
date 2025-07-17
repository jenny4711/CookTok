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
                   print("work")
               })
               ItemBtnsView(p: 2,h:40,name:"Seafood", act: {
                   print("FRUIT")
               })
               ItemBtnsView(p: 2,h:40,name:"Sauce", act: {
                   print("work")
               })
               
               
           }//:HStack
           .padding(.horizontal,11)
           
           HStack{
               ItemBtnsView(p: 2,h:40,name:"Dry", act: {
                   selectedCategory = "Produce"
               })
               
               ItemBtnsView(p: 2,h:40,name:"Dairy", act: {
                   print("work")
               })
               ItemBtnsView(p: 2,h:40,name:"Junk", act: {
                   print("FRUIT")
               })
               ItemBtnsView(p: 2,h:40,name:"Etc", act: {
                   print("work")
               })
               
               
           }//:HStack
           .padding(.horizontal,11)
       }
          
           
           
       
       
       
   }
}
 



