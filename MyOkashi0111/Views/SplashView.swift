//
//  SplashView.swift
//  MyOkashi0111
//
//  Created by cmStudent on 2022/09/16.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 40.0) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            Text("お菓子検索アプリ")
                .bold()
                .font(.system(size: 25))
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
