//
//  AddFormView.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
//

import SwiftUI

// MARK: - ADDForm

struct AddFormView: View {
   @Environment(\.modelContext) private var context
   @Environment(\.dismiss) private var dismiss
    let categoris:[String] = ["Produce","Meat","Seafood","Sauce","Dry"]
    var item:Items
   @State var selectedCategory:String = "Select Category"
   @State private var showSelection:Bool = false
   @State var itemName:String = ""
   @State var itemExpireDate:Date = Date()
   var body: some View {
       
       ZStack{
           Color.customSkyBlue
               .ignoresSafeArea()
           
           VStack(alignment:.leading){
               Button("ADD") {
                  // TODO: save to swiftDAta
                   let item = Items()
                   item.itemName = itemName
                   item.expireDate = itemExpireDate
                   item.category = selectedCategory
                   
                   context.insert(item)
                   
                   dismiss()
               }
               
 // MARK: - select category
                   HStack {
                     
                       Text("Categoris")
                          
                    
                     
                       Picker("카테고리 선택", selection: $selectedCategory) {
                           
                           
                           ForEach(categoris, id: \.self) { category in
                              
                               Text(category).tag(category)
                           }
                           
                           
                           
                       }
                       .pickerStyle(.menu)
                      
                   } //:HStack(Picker)
                   

 // MARK: - select Expire Date
               VStack{

                   DatePicker("Expire Date",
                              selection: $itemExpireDate,
                              in: Date()...,
                              displayedComponents: .date,
                              
                              
                   
                   )
                   
                   TextField("ItemName",text:$itemName)
                       .textFieldStyle(.roundedBorder)
                  
                  
                   
               }
               

               
           }//:VSTACK
           .padding(.horizontal,16)
           
           
       }//:ZSTACK
       

   }
   
}

#Preview {
    AddFormView(item: Items())
}
