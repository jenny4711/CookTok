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
    @State var selectedCategory:String = "Veg"
    @State private var showForm:Bool = false
    @State private var isEdit:Bool = false
  @State private var selectedItem = Items()
    @State var itemName:String = ""
    @State var itemExpireDate:Date = Date()
    @State var newItem:Items?
    @Query private var items:[Items]
    var body: some View {
      
        NavigationStack {
            ZStack{
                
                
                
                VStack{
                    // TODO: - Category Title
                    HStack {
                        Text("CATEGORIES")
                            .font(Font.bold25)
                        Spacer()
                    }//:HSTACK(CATEGORY TITLE)
                    

                    .padding(.leading,15)
                    
                    
                     // TODO: CATEGORYBTN
                        CategoryBtnsView(selectedCategory: $selectedCategory)
                        .padding(.bottom,20)
                  
                    
                    
                    // TODO: TITLE and ADDBTN
                    HStack{
                        Text(selectedCategory.uppercased())
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
                    

                    // TODO: ITEM LIST
                    ScrollView{
                        ForEach(items){
                            i in
                            
                            ItemBtnsView(p: 15,h:50,name:i.itemName, act: {
                                selectedItem = i
                                       isEdit = true
                                
                                print(i.expireDate)
                            })
                            
                        }//:LOOP
                        

                    }//:Scroll
                    
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement:.topBarTrailing){
                            
                            
                            AskRecipe()
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
            }
            .sheet(isPresented: $isEdit) {
                VStack{
                    Text(selectedItem.itemName)
                   
                    
                    
                    HStack{
                        Button("Delete"){
                            context.delete(selectedItem)
                            isEdit = false
                        }
                        
                        
                    }//:HStack
                    

                }//:VSTACK
                

                Text("test \(selectedItem.itemName)")
                Text(DateHelper.convertDate(inputDate: selectedItem.expireDate))
                
                    .presentationDetents([.fraction(0.3)])
            }
            
        }
       

    }
}





 // MARK: - AskRecipeBtn
struct AskRecipe: View {
    
    var body: some View {
        Button("ASK RECIPE") {
            EmptyView()
        }
        .font(Font.bold16)
        .foregroundColor(.black)
    }
}




 // MARK: - List

struct IngredientsList: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


 



#Preview {
    ItemsList()
}



