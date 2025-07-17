//
//  CookTokApp.swift
//  CookTok
//
//  Created by Ji y LEE on 7/16/25.
//

import SwiftUI
import SwiftData

@main
struct CookTokApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for:[Items.self,ShopingItem.self])
        }
    }
}
