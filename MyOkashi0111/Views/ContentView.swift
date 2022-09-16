//
//  ContentView.swift
//  MyOkashi0111
//
//  Created by cmStudent on 2021/07/08.
//

import SwiftUI

struct ContentView: View {
    @State var isShowMainView = false
    
    var body: some View {
        if isShowMainView {
            MainView()
        } else {
            SplashView()
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        isShowMainView = true
                    })
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
