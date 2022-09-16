//
//  MainView.swift
//  MyOkashi0111
//
//  Created by cmStudent on 2022/09/16.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = ViewModel()
    @State var inputText = ""
    @State var showSafari = false
    var body: some View {
        VStack{
            TextField("キーワードを入力してください", text: $inputText, onCommit: {
                viewModel.searchOkashi(keyword: inputText)
            })
            
            List(viewModel.okashiList) { okashi in
                Button(action:{
                    showSafari.toggle()
                }) {
                    HStack {
                        Image(uiImage: okashi.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Text(okashi.name)
                    }
                }
                .sheet(isPresented: $showSafari) {
                    SafariView(url: okashi.link)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
