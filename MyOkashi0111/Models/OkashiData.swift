//
//  OkashiData.swift
//  MyOkashi0111
//
//  Created by cmStudent on 2021/07/08.
//

import UIKit
import Combine

struct OkashiItem: Identifiable {
    let id = UUID()
    let name: String
    let link: URL
    let image: UIImage
}

class OkashiData {
    
    struct ResultJson: Codable {
        struct Item: Codable {
            let name: String?
            let url: URL?
            let image: URL?
        }
        let item: [Item]?
    }
    
    func searchOkashi(keyword: String) throws -> AnyPublisher<[OkashiItem], ApiError> {
        print(keyword)
        
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw URLCreateError.searchWordFailedEncode
        }
        
        guard let req_url = URL(string: "https://www.sysbird.jp/webapi/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            throw URLCreateError.badURL
        }
        
        let req = URLRequest(url: req_url)
        
        return URLSession.shared.dataTaskPublisher(for: req)
            .receive(on: RunLoop.main)
           .tryMap { data, response -> Data in
               guard let response = response as? HTTPURLResponse else {
                   throw ApiError.abnormalResponse
               }
               
               if !(200...399 ~= response.statusCode) {
                   throw ApiError.abnormalStatusCode(statusCode: response.statusCode)
               }
               return data
           }
           .tryMap { data -> ResultJson in
               do {
                   return try JSONDecoder().decode(ResultJson.self, from: data)
               } catch {
                   throw ApiError.failedDecodeJSON
               }
           }
           .map { json -> [OkashiItem] in
               var okashiList: [OkashiItem] = []
               
               if let items = json.item {
                   for item in items {
                       if let name = item.name,
                          let link = item.url,
                          let imageURL = item.image,
                          let imageData = try? Data(contentsOf: imageURL),
                          let image = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal) {
                           let okashi = OkashiItem(name: name, link: link, image: image)
                           okashiList.append(okashi)
                       }
                   }
                   print(okashiList)
               }
               return okashiList
           }
           .catch { error in
               Empty(outputType: [OkashiItem].self, failureType: ApiError.self)
           }
           .eraseToAnyPublisher()
    }
}


