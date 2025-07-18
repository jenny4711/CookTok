//
//  ItemsList.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
//

import SwiftUI
import SwiftData
struct ItemsList: View {
     // MARK: - property
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var selectedCategory:String = ""
    @State private var selectedExpireDate: Date = Date()
    @State private var showForm:Bool = false
    @State private var isEdit:Bool = false
    @State private var isEditOpen:Bool = false
   @State private var selectedItem = Items()
    @State var itemName:String = ""
    @State var itemExpireDate:Date = Date()
    @State var newItem:Items?
    let categoris:[String] = ["Produce","Meat","Seafood","Sauce","Dry","Dairy","Junk","Etc"]
    @Query private var items:[Items]
    
    // TODO: filtered list array
    var filteredItems: [Items] {
        items
            .filter { $0.category == selectedCategory }
            .sorted { $0.expireDate < $1.expireDate }
        
    }
    // TODO: normal list array
    var allFilteredItems:[Items]{
        items
            .sorted { $0.expireDate < $1.expireDate }
        
    }
    var body: some View {
      
        NavigationStack {
            ZStack{

                VStack{
                    // MARK: - Category Title
                    HStack {
                        Text("CATEGORIES")
                            .font(Font.bold25)
                        Spacer()
                    }//:HSTACK(CATEGORY TITLE)
                    

                    .padding(.leading,15)
                    
                    
                     // MARK: CATEGORYBTN
                        CategoryBtnsView(selectedCategory: $selectedCategory)
                        .padding(.bottom,20)
                  
                    
                    
                    // MARK: TITLE and ADDBTN
                    HStack{
                        Text(selectedCategory != "" ? selectedCategory.uppercased():"Ingredients")
                            .font(Font.bold25)
                        Button(action: {
                            self.newItem = Items()
                        }) {
                            Image(systemName: "plus")
                                .tint(.black)
                        }
                        Spacer()
                        
                    }//:HStack(title and add button)
                    .padding(.leading,15)
                   

                    // MARK: ITEM LIST
                    ScrollView{
                        ForEach(selectedCategory != "" ? filteredItems:allFilteredItems){
                            i in
                            
                            ItemBtnsView(
                                p: 15,
                                h:50,
                                c: i.expireDate <= Date() ? .red : .white,
                                name:i.itemName,
                                act: {
                                selectedItem = i
                                    isEditOpen = true
                                
                                
                            })
                           
                            
                        }//:LOOP
                        

                    }//:Scroll
                    
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement:.topBarTrailing){
                            
                            
                            ResetBtnView(selectedCategory: $selectedCategory)
                        }//:TOOLBARITEM
                        

                    }//:TOOLBAR

                }//:VSTACK
                

                
            }//:ZSTACK
            .background(
                LinearGradient(colors: [Color.customSkyBlue,Color.customBlue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
            
            .sheet(item: $newItem) {
                item in
                AddFormView(item:item)
                    .presentationDetents([.fraction(0.3)])
            }//:SHEET (AddFormView)
            

            .sheet(isPresented: $isEditOpen) {
                EditFormView( selectedItem: $selectedItem, selectedCategory: $selectedCategory, selectedExpireDate: $selectedExpireDate, isEdit: $isEdit, isEditOpen: $isEditOpen)
                

            }//:SHEET(EDIT)
            

            .onChange(of: isEdit) { newValue, oldValue in
                if newValue {
                  
                    selectedExpireDate = selectedItem.expireDate
                    
                    selectedCategory = selectedItem.category!
                }else{
                    return
                }
            }//:ONCHANGE
            

            
        }//:NAVIGATIONSTACK
        

    }
}


 // MARK: - AskRecipeBtn
struct ResetBtnView: View {
    @Binding var selectedCategory:String
    var body: some View {
        Button("RESET") {
            selectedCategory = ""
        }
        .font(Font.bold16)
        .foregroundColor(.black)
    }
}






 



#Preview {
    ItemsList()
}



