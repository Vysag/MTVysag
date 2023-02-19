//
//  BottomTabView.swift
//  wacMTVysag
//
//  Created by vysag k on 19/02/23.
//

import SwiftUI

struct bottomTabView: View {
    var body: some View {
        TabView {
            homeView()
                .tabItem {
                    Label("Home", systemImage: "homekit")
                }
            
            categoriesView()
                .tabItem {
                    Label("Categories", systemImage: "square.grid.3x3.fill")
                }
            offersView()
                .tabItem {
                    Label("Offers", systemImage: "tag")
                }
            cartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
            accountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }.accentColor(.green).border(.black).edgesIgnoringSafeArea(.all)
    }
}

