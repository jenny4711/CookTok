//
//  CookTokApp.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
// AIzaSyA5IWhtQd8C3AgR7Tr87NJtL6bheRdb_iE

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseVertexAI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct CookTokApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for:[Items.self,ShopingItem.self,User.self])
        }
    }
}
// instruction

//About
//The CookTokApp helps users manage their groceries. When you're food shopping, you can create a list. Once you've purchased items, clicking on them in the shopping list automatically saves them to your refrigerator inventory. This refrigerator list displays all the ingredients currently in your fridge. To help you keep track, items whose expiration date has passed will automatically turn red.



//Introduce Pages
//OnboardingPage
//Tapping the "Open" button navigates to the next section.


//ShoppingListPage
//In the first part, filling out a form and pressing "Save" displays the item in a list in the second part.

//Tapping the refrigerator button on the top right navigates to the "ItemListPage."

//Clicking on a purchased item deletes it from the shopping list and moves it to the "ItemListPage."


//ItemListPage
//This page displays a list of items currently in the refrigerator.

//Selecting a desired category from the "Category" section shows a list of items related to that category.

//Clicking on an item in the list brings up a form to modify its expiration date and category, along with a "Delete" button.


