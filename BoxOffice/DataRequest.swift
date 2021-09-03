//
//  DataRequest.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/28.
//

import Foundation

let DidReceiveMovieImageDataNotification: Notification.Name = Notification.Name("DidReceiveMovieListData")

enum OrderType: Int {
    case ticketingRate = 0
    case curation = 1
    case openDate = 2
}

func requestMovieDatas(orderType: OrderType) {
    guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=\(orderType.rawValue)") else { return }

    let dataTask = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let err = error {
            print(err.localizedDescription)
        }
        
        guard let data = data else { return }
        do {
            let apiResponse: MovieListDataResponse = try JSONDecoder().decode(MovieListDataResponse.self, from: data)
            MovieListData.shared.data = apiResponse.movies
            NotificationCenter.default.post(name: DidReceiveMovieImageDataNotification, object: nil, userInfo: ["MovieListData": apiResponse.movies])
        } catch (let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}
