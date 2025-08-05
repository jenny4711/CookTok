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
    var c:Color = .white
   var name : String = ""
    var isCategory :Bool = false
  var act: () -> Void
   
   var body: some View {
       Button(action: {act()}) {
          
           HStack{
               if isCategory{
                   Image(name)
               }else{
                   Text(name)
                       .font(Font.reg16)
                       .foregroundColor(.white)
               }
         
           
               
           }
           .frame(maxWidth: .infinity, minHeight: h, maxHeight: h)
           
           
           .padding(.horizontal,p)
       }//:BTN&LABEL
   }
}



