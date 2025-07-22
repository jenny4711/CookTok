//
//  OnBoardingView.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
//

import SwiftUI
import SwiftData


struct OnBoardingView: View {
     // MARK: - property
 
    @State private var openView:Bool = false
   
  
   
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(colors: [Color.customSkyBlue,Color.customBlue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                

                
                Button(action: {openView = true}) {
                    HStack(){
                        Spacer()
                        VStack(alignment:.trailing) {
                            Text("COOKTOK")
                                .font(Font.black40)
                            Text("OPEN")
                                .font(Font.light20)

                        }
                    }//:HSTACK
                    .padding(.trailing,16)
                    .padding(.bottom,8)
                    .foregroundStyle(.white)
                }

              
                    .padding(.top, 100)
                    
            

                
            }//:ZSTACK
            .navigationDestination(isPresented: $openView) {
//                ItemsList()
                ShoppingListView()
            }
            
        }//:NAVIGATION STACK
        

        

    }
}

#Preview {
    OnBoardingView()
}
