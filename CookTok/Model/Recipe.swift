import Foundation
import SwiftData

@Model
class Recipe{
    @Attribute(.unique) var id:String

    var name:String = ""
    var ingredients:[String] = []
    var cookingTime:Int = 0
    var difficulty:String = ""
    
    
    
    init(){
        id = UUID().uuidString
    }
}
