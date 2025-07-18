//
//  EditFormView.swift
//  CookTok
//
//  Created by Ji y LEE on 7/17/25.
//

import SwiftUI
import SwiftData
struct EditFormView: View {
    @Environment(\.modelContext) private var context
    @Binding var selectedItem:Items
    @Binding var selectedCategory:String
    @Binding var selectedExpireDate:Date
    @Binding var isEdit:Bool
    @Binding var isEditOpen:Bool
    let categoris:[String] = ["Produce","Meat","Seafood","Sauce","Dry","Dairy","Junk","Etc"]
    var body: some View {
        ZStack {
      
            Color.customSkyBlue
                .ignoresSafeArea()
            VStack(spacing:8){
                
                
                Text(selectedItem.itemName)
                    .font(Font.title3)
                Text("\(selectedItem.category ?? "")")
                    .font(Font.reg16)
                
                HStack {
                    
                    Text("Categoris")

                    Picker("카테고리 선택", selection: $selectedCategory) {
                        
                        Text("All").tag("")
                        ForEach(categoris, id: \.self) { category in
                            
                            Text(category).tag(category)
                        }
                        
                        
                        
                    }
                    .pickerStyle(.menu)
                    .tint(.black)
                    Spacer()
                }//:PICKER(CATEGORY)
                
                
                
                       DatePicker("Expire Date",
                           selection: $selectedExpireDate,
                                  in: Date()...,
                           displayedComponents: .date
                       )
                
                
                
                HStack{
                    Button("Delete"){
                        context.delete(selectedItem)
                        isEdit = false
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .background(.red)
                    .cornerRadius(10)
                    
                    Button("Save") {
                        var changed = false
                        if selectedItem.expireDate != selectedExpireDate {
                            selectedItem.expireDate = selectedExpireDate
                            changed = true
                        }
                        if selectedItem.category != selectedCategory {
                            selectedItem.category = selectedCategory
                            changed = true
                        }
                        
                        isEdit = changed
                        isEditOpen = false
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .background(.green)
                    .cornerRadius(10)
                    
                    
                }//:HStack
                
                
            }//:VSTACK
            .padding()

            .presentationDetents([.fraction(0.3)])
        }//:ZSTACK
        .foregroundStyle(.black)
        
    }
}

#Preview {
    EditFormView(
        selectedItem: .constant(Items()),
        selectedCategory: .constant("VEG"),
        selectedExpireDate: .constant(Date()),
        isEdit: .constant(false),
        isEditOpen: .constant(true)
    )
}
