//
//  ShopingItem.swift
//  CookTok
//
//  Created by Ji y LEE on 7/17/25.
//

import Foundation
import SwiftData
@Model
class ShopingItem{
    @Attribute(.unique) var id:String
    
    var itemName:String = ""
    var category:String? = ""
    var expireDate:Date = Date()
    var currentDate:Date = Date()
    var checked:Bool = false
   
    
    
    
    init(){
        id = UUID().uuidString
    }
}
