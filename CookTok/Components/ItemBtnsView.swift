//
//  ItemBtns.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
//

import SwiftUI

// MARK: - ItemBtns

struct ItemBtnsView: View {
   var p :CGFloat = 120
   var h :CGFloat = 40
   var name : String = ""
  var act: () -> Void
   
   var body: some View {
       Button(action: {act()}) {
           ZStack{
               RoundedRectangle(cornerRadius: 15)
              
           
                   .tint(.white)
               Text(name)
                   .font(Font.reg16)
                   .foregroundColor(.black)
               
           }
           .frame(maxWidth: .infinity, minHeight: h, maxHeight: h)
           .padding(.horizontal,p)
       }//:BTN&LABEL
   }
}



