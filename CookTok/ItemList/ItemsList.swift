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
    @State private var shouldNavigateBack = false
    @State private var selectedItem = Items()
    @State var itemName:String = ""
    @State var itemExpireDate:Date = Date()
    @State var newItem:Items?
    @State var aiAnswer:Bool = false

    @StateObject private var askAI = AskAI()
//    let categoris:[String] = ["Produce","Meat","Seafood","Sauce","Dry","Dairy","Junk","Etc"]
//    let categorisKR:[String] = ["채소","고기","해산물","양념","마른것","유제품","인스턴트","기타"]
    @Query private var items:[Items]
    @Query(sort: \User.id) private var userInfo: [User]
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
                        Text(userInfo.first?.language == "ENG" ? "CATEGORIES" : "카테고리")
                        
                            .font(Font.bold25)
                        Spacer()
                    }//:HSTACK(CATEGORY TITLE)
                    
  
                    .padding(.leading,15)
                    
                    
                     // MARK: CATEGORYBTN
                    CategoryBtnsView(selectedCategory: $selectedCategory)
                        .padding(.bottom,20)
                    
                    
                    
                    // MARK: TITLE and ADDBTN
                    HStack{
                        if userInfo.first?.language == "KOR" {
                            Text(selectedCategory != "" ? selectedCategory:"재료")
                        }else{
                            Text(selectedCategory != "" ? selectedCategory.uppercased():"Ingredients")
                                .font(Font.bold25)
                        }
                      
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
                        ForEach(selectedCategory != ""  ? filteredItems:allFilteredItems){
                            i in
                            
                            ItemBtnsView(
                                p: 15,
                                h:50,
                                c: i.expireDate <= Date() ? .red : .white,
                                name:i.itemName,
                              
                                isCategory:false,
                                act: {
                                selectedItem = i
                                    selectedExpireDate = i.expireDate
                                    selectedCategory =  ""
                                    isEditOpen = true
                                
                                
                            })
                           
                            
                        }//:LOOP
                        

                    }//:Scroll
                    .foregroundColor(.white)
                    .navigationBarTitleDisplayMode(.inline)
                    
                     // MARK: - NAVIGATION BAR(BACK,RESET BTN)
                    .toolbar{
                        ToolbarItem(placement:.topBarLeading){
                            NavigationLink(destination: ShoppingListView(), isActive: $shouldNavigateBack) {
                                       Image(systemName: "chevron.backward")
                                   }
                        }//:TOOLBARITEM(BACK BTN)
                        
                        ToolbarItem(placement:.topBarTrailing){
                         
                                    ResetBtnView(selectedCategory: $selectedCategory)
                                

                        }//:TOOLBARITEM
                        

                    }//:TOOLBAR
                    .navigationBarBackButtonHidden(true)
                     // MARK: - AI BTN
                    HStack {
                        Spacer()
                        Button(action: {
                       
                            Task {

                                await askAI.newRecipe(ingredients: items,lang:userInfo.first?.language ?? "ENG")
                               
                                if (askAI.geminiResponse != "오류 발생"){
                                   
                                    aiAnswer = true
                                }else{
                                    aiAnswer = false
                                }
                            }

                        }) {
                            ZStack {
                         
                             
                                VStack(spacing: 2) {
                                    
                                    if(askAI.isLoading){
                                        Text(userInfo.first?.language == "ENG" ? "Thinking" : "생각중..")
                                            .font(Font.bold16)
                                    }else{
                                        
                                        Image("recipe")
                                        

                                    }
                                    
                                                                }
                            }
                        }
                    }
                    .padding(.trailing,16)
         
                                }//:VSTACK
                .foregroundColor(.white)
            

                
            }//:ZSTACK
            .background(
                Image("veg")
                    .opacity(0.6)
                  

            )
            .background(
                        Color.black
                            
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
            
            .sheet(isPresented:$aiAnswer){
             
                ShowAiRecipe(aiResponse: askAI.geminiResponse)
            }
            
             

            .onChange(of: isEdit) { newValue, oldValue in
                if newValue {
                  
           
                }else{
                    return
                }
            }//:ONCHANGE
            

            
        }//:NAVIGATIONSTACK
//        .navigationBarBackButtonHidden()
        .onAppear{
            print("ItemListLang:\(userInfo.first?.language ?? "NoLang")")
        }
        

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
        .foregroundColor(.white)
    }
}




#Preview {
    ItemsList()
}



