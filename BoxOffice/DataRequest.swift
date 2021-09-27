//
//  DataRequest.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/28.
//

import UIKit

let DidRequestMovieImageDataNotification: Notification.Name = Notification.Name("DidRequestMovieListData")
let DidReceiveMovieImageDataNotification: Notification.Name = Notification.Name("DidReceiveMovieListData")

enum OrderType: Int {
    case ticketingRate = 0
    case curation = 1
    case openDate = 2
}

func requestMovieDatas(orderType: OrderType) {
    guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=\(orderType.rawValue)") else { return }

    NotificationCenter.default.post(name: DidRequestMovieImageDataNotification, object: nil)
    let dataTask = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let err = error {
            print(err.localizedDescription)
        }
        
        guard let data = data else { return }
        do {
            let apiResponse: MovieListDataResponse = try JSONDecoder().decode(MovieListDataResponse.self, from: data)
            MovieListData.shared.data = apiResponse.movies
            NotificationCenter.default.post(name: DidReceiveMovieImageDataNotification, object: nil, userInfo: ["orderType": orderType])
        } catch (let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}

func requestAddComment(rating: Double, writer: String, movieID: String, contents: String, viewController: UIViewController) {
    let commentBody: AddCommentBody = AddCommentBody(rating: rating, writer: writer, movieID: movieID, contents: contents)
    
    guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/comment") else { return }
    
    let alertController: UIAlertController = UIAlertController(title: "데이터 통신 오류", message: nil, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "확인", style: .cancel, handler: {action in viewController.dismiss(animated: true, completion: nil)}))
    
    do {
        let bodyData: Data = try JSONEncoder().encode(commentBody)
        
        var request: URLRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpBody = bodyData
        request.httpMethod = "POST"
        
        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: request) {(responseData: Data?, response: URLResponse?, err: Error?) in
            if let error = err {
                print(error.localizedDescription)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    alertController.message = "평점 등록에 실패했습니다."
                    viewController.show(alertController, sender: viewController)
                }
            }

        }
        
        dataTask.resume()
        
    } catch (let err) {
        print(err.localizedDescription)
        alertController.message = "데이터 변환에 실패했습니다."
        viewController.show(alertController, sender: viewController)
    }
}
