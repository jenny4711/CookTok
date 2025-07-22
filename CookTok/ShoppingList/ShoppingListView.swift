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
//    @Query private var shoppingItems:[ShopingItem]
    @Query(sort: \User.id) private var userInfo: [User]
    @Query(sort:\ShopingItem.expireDate,order:.reverse)
    private var shoppingItems:[ShopingItem]
    @State var newShoppingItem:ShopingItem?
    @State var checked:Bool = false
    @State var shoppingItemName:String = ""
    @State var isAnimated = false
    @State var newItem:Items?
    @State var itemName:String = ""
    @State var itemExpireDate:Date = Date()
    @State var selectedCategory:String = ""
    @State var goNext:Bool = false
    let categoris:[String] = ["Produce","Meat","Seafood","Sauce","Dry","Dairy","Junk","Etc"]
 
    
    
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
                                        .foregroundColor(.black)
                                    
                                    
                                    Picker("카테고리 선택", selection: $selectedCategory) {
                                        Text("All").tag("")
                                        
                                        ForEach(categoris, id: \.self) { category in
                                            
                                            Text(category).tag(category)
                                        }
                                        
                                        
                                        
                                    }
                                    .pickerStyle(.menu)
                                    .tint(.black)
                                    
                                }//:HSTACK PICKER(CATEGORY)
                              

                               Spacer()
                                 // MARK: - nextPg BTN
                                Button(action: {
                                    goNext = true
                                }) {
                                    
                                    Text("REFRIGERATOR")
                                        .font(Font.bold16)
                                        .foregroundColor(.black)

                                }
                            } //:HStack(Picker)
                            
                             // MARK: - Form(DATE,CATEGORY,SAVE)
                            
                            VStack{
                                
                                
                                DatePicker("Expire Date",
                                           selection: $itemExpireDate,
                                           in: Date()...,
                                           displayedComponents: .date,
                                           
                                           
                                           
                                )
                                
                                TextField("ItemName",text:$itemName)
                                    .textFieldStyle(PlainTextFieldStyle())
                                       .padding()
                                       .background(Color.white) // 배경색 설정
                                       .cornerRadius(8)
                                
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
                                    
                                    
                                }//:BUTTON
                                .buttonStyle(.bordered)
                                .background(Color.customBlue)

                                .foregroundColor(.white)
                                .cornerRadius(10)

                            }//:VSTACK(FORM)

                            .foregroundColor(.black)
                            
                            
                        }//:VSTACK
                        .padding(.horizontal,16)
                        .padding(.top,50)
                    }

                     // MARK: - Shopping List and lang btn
                    HStack {
                        Text(userInfo.first?.language == "ENG" ? "Shopping List" : "장보기 리스트")
                            .font(Font.bold25)
                            .foregroundColor(.white)
                        
                        HStack {
                        
                            HStack(spacing:1) {
                              
                                Text(userInfo.first?.language ?? "language")
                                    .font(Font.reg16)
                                    .foregroundColor(.white)
                                Toggle("", isOn: $isAnimated)
                                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                                    .scaleEffect(0.7)
                             
                              
                            }
                           
                            .frame(width:75)
                            .padding(.leading,16)
                        }
                        Spacer()
                    }//:HSTACK(Shopping List and lang btn)
                    

                    
                         
                    .onChange(of:isAnimated){
                        if let existingUser = userInfo.first {
                            // 기존 사용자 업데이트
                            existingUser.language = isAnimated ? "ENG" : "KOR"
                        } else {
                            // 새 사용자 생성
                            let newUser = User()
                            newUser.language = isAnimated ? "ENG" : "KOR"
                            context.insert(newUser)
                        }
                        print("shooppingListLang:\(userInfo.first?.language ?? "NoLang")")
                    }//:onchange(lang)
                    

                    .padding(.leading,20)
                    .padding(.top,20)
                    ScrollView{
                        
                        ForEach(shoppingItems){
                            item in
                            ItemBtnsView(p: 15,h:40,name:item.itemName, act: {
                                // TODO: checked true
                                // TODO: save items
                                let ingre = Items()
                                ingre.itemName = item.itemName
                                ingre.expireDate = item.expireDate
                                ingre.category = item.category
                                context.insert(ingre)
                                context.delete(item)
                                
                             
                            })
                            
                        }//:LOOP
                        
                        
                    }//:SCROLLVIEW
                    .padding(.top,20)

                    
                }//:VSTACK
                
                .ignoresSafeArea()
            }//:ZSTACK
            .navigationBarBackButtonHidden()
            
            .navigationDestination(isPresented: $goNext) {
               // ShowAiRecipe()
                ItemsList()
            }
  
        }//:NAVIGATIONSTACK
        

    }
}

#Preview {
    ShoppingListView()
}
