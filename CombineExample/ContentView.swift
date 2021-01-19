//
//  ContentView.swift
//  CombineExample
//
//  Created by Prabhdeep Singh on 19/01/21.
//  Copyright © 2021 Phoenix. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //Replace with state object in xcode 12
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Text(viewModel.time)
                Section(header: Text("Users")) {
                    ForEach(viewModel.users) { user in
                        Text(user.name)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
