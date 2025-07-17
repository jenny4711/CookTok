//
//  Items.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
//

import Foundation
import SwiftData
@Model
class Items{
    @Attribute(.unique) var id:String
    var itemName:String = ""
    var category:String? = ""
    var expireDate:Date = Date()
    var currentDate:Date = Date()
    
    
    
    
    init(){
        id = UUID().uuidString
    }
    
}
