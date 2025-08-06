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
    @State private var makeStick:Bool = false
  
   
    var body: some View {
        NavigationStack {
             // MARK: - title (above)
            ZStack {
                VStack(alignment:.leading) {
                    VStack{
                        Spacer()
                        HStack{
                            Text("COOKTOK")
                                .font(Font.black30)
                                .foregroundColor(Color.white)
                                .padding(.leading,16)
                                .padding(.bottom,16)
                            Spacer()
                        }
                        
                        
                    }
                    .frame(maxWidth:.infinity,maxHeight:300)
                    .background(.black)
                    .cornerRadius( makeStick ? 10 : 0, corners: [.bottomLeft, .bottomRight])
                     // MARK: - STICK
                   Spacer()
                        .frame(width:makeStick ? 0 :UIScreen.main.bounds.width,height:10)
                    .background(.black)
                    
                     // MARK: - OpenBTN(BOTTOM
                    
                    ZStack{
                        
                        
                        Color.black
                            .cornerRadius(makeStick ? 10 : 0, corners: [.topLeft, .topRight])
                        VStack(){
                            
                            HStack {
                                Button(action: {openView = true}) {
                                    HStack(){
                                        
                                        
                                        
                                        Text("OPEN")
                                            .font(Font.black30)
                                        
                                        
                                    }//:HSTACK
                                    .padding(.trailing,16)
                                    .padding(.bottom,8)
                                    .foregroundStyle(.white)
                                }
                                .padding(.leading,16)
                                .padding(.top,16)
                                Spacer()
                            }
                            
                            
                            
                            
                            Spacer()
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                    }//:ZSTACK
                    
                    .navigationDestination(isPresented: $openView) {
                        //                ItemsList()
                        ShoppingListView()
                    }
                }//:VSTACK
                
                
                .ignoresSafeArea()
            
            }//:ZSTACK
            .onAppear{
                withAnimation(.easeInOut(duration: 0.5)) {
                       makeStick = true
                   }
            }

//            .background(.red)
        }//:NAVIGATION STACK
        

        

    }
}

#Preview {
    OnBoardingView()
}
