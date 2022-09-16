//
//  ViewModel.swift
//  MyOkashi0111
//
//  Created by cmStudent on 2022/09/16.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var okashiData = OkashiData()
    
    @Published var okashiList: [OkashiItem] = []
    
    var cancellable = Set<AnyCancellable>()
    
    func searchOkashi(keyword: String) {
        okashiList.removeAll()
        do {
            try okashiData.searchOkashi(keyword: keyword)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        switch error {
                        case .abnormalResponse:
                            print("データが異常です")
                        case .abnormalStatusCode(statusCode: let statusCode):
                            print("ステータスコードが異常です")
                            print("statusCode:", statusCode)
                        case .failedDecodeJSON:
                            print("JSONのデコードに失敗しました")
                        }
                    }
                }, receiveValue: {
                    self.okashiList = $0
                })
                .store(in: &cancellable)
        } catch URLCreateError.searchWordFailedEncode {
            print("検索ワードに不適切な文字が含まれている可能性があります")
        } catch URLCreateError.badURL {
            print("正しくURLを生成することができませんでした")
        } catch {
            // 通常ここに入ることはない
        }
    }
    
}
