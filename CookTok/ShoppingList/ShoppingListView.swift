//
//  ShoppingListView.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
//

import SwiftUI
import SwiftData

struct ShoppingListView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var shoppingItems:[ShopingItem]
    
    @State var newShoppingItem:ShopingItem?
    @State var checked:Bool = false
    @State var shoppingItemName:String = ""
    
    @State var newItem:Items?
    @State var itemName:String = ""
    @State var itemExpireDate:Date = Date()
    @State var selectedCategory:String = ""
    @State var goNext:Bool = false
    let categoris:[String] = ["Produce","Meat","Seafood","Sauce","Dry"]
 
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [Color.customSkyBlue,Color.customBlue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    ZStack {
                        
                        Color.customSkyBlue
                            .cornerRadius(15)
                            .frame(height:250)
                            .shadow(radius:10)
                        
                        
                        
                        
                        VStack(alignment:.leading){

                            
                            HStack {
                                HStack {
                                    
                                    Text("Categoris")
                                    
                                    
                                    
                                    Picker("카테고리 선택", selection: $selectedCategory) {
                                        
                                        
                                        ForEach(categoris, id: \.self) { category in
                                            
                                            Text(category).tag(category)
                                        }
                                        
                                        
                                        
                                    }
                                    .pickerStyle(.menu)
                                    
                                    
                                }
                               Spacer()
                                Button(action: {
                                    goNext = true
                                }) {
                                   Image(systemName:"chevron.right")
                                        .tint(.black)
                                }
                            } //:HStack(Picker)
                            
                            
                            
                            VStack{
                                
                                
                                DatePicker("Expire Date",
                                           selection: $itemExpireDate,
                                           in: Date()...,
                                           displayedComponents: .date,
                                           
                                           
                                           
                                )
                                
                                TextField("ItemName",text:$itemName)
                                    .textFieldStyle(.roundedBorder)
                                
                                Button("SAVE") {
                                    print("SAVE")
                                    withAnimation {
                                        let item = ShopingItem()
                                        item.itemName = itemName
                                        item.category = selectedCategory
                                        item.expireDate = itemExpireDate
                                        context.insert(item)
                                    }
                                    
                                    itemName = ""
                                    selectedCategory = ""
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                            
                            
                        }//:VSTACK
                        .padding(.horizontal,16)
                        .padding(.top,50)
                    }

                    
                    HStack {
                        Text("Food Shopping List")
                            .font(Font.bold25)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.leading,20)
                    ScrollView{
                        
                        ForEach(shoppingItems){
                            item in
                            ItemBtnsView(p: 15,h:40,name:item.itemName, act: {
                                // TODO: checked true
                                // TODO: save items
                                let ingre = Items()
                                ingre.itemName = item.itemName
                                ingre.expireDate = item.expireDate
                                context.insert(ingre)
                                context.delete(item)
                                
                             
                            })
                            
                        }
                        
                        
                        
                        
                    }//:SCROLLVIEW
                    .padding(.top,40)
                    
                    
                    
                    
                    
                }//:VSTACK
                
                .ignoresSafeArea()
            }//:ZSTACK
            .navigationBarBackButtonHidden()
            
            .navigationDestination(isPresented: $goNext) {
                ItemsList()
            }
            
            
            
        }
    }
}

#Preview {
    ShoppingListView()
}
