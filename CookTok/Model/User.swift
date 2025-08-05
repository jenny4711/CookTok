//
//  User.swift
//  CookTok
//
//  Created by Ji y LEE on 7/22/25.
//

import Foundation
import SwiftData
@Model
class User{
    @Attribute(.unique) var id:String

var language:String = "ENG"
var myRecipes:[Recipe] = []
    
    
    
    
    
    
    init(){
        id = UUID().uuidString
    }
}
