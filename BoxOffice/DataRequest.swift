//
//  DataRequest.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/28.
//

import UIKit

let DidRequestMovieImageDataNotification: Notification.Name = Notification.Name("DidRequestMovieListData")
let DidReceiveMovieImageDataNotification: Notification.Name = Notification.Name("DidReceiveMovieListData")

let DidRequestMovieDetailDataNotification: Notification.Name = Notification.Name("DidRequestMovieDetailData")
let DidReceiveMovieDetailDataNotification: Notification.Name = Notification.Name("DidReceiveMovieDetailData")

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
    
    let errorAlert: UIAlertController = UIAlertController(title: "데이터 통신 오류", message: nil, preferredStyle: .alert)
    errorAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: {action in viewController.dismiss(animated: true, completion: nil)}))
    
    let confirmAlert: UIAlertController = UIAlertController(title: "평점 등록 완료", message: "평점이 등록되었습니다.", preferredStyle: .alert)
    confirmAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: {action in viewController.dismiss(animated: true, completion: {viewController.navigationController?.popViewController(animated: true)})}))
    
    do {
        let bodyData: Data = try JSONEncoder().encode(commentBody)
        
        var request: URLRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpBody = bodyData
        request.httpMethod = "POST"
        
        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: request) {(responseData: Data?, response: URLResponse?, err: Error?) in
            if let error = err {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    errorAlert.message = "평점 등록에 실패했습니다."
                    viewController.present(errorAlert, animated: true, completion: nil)
                }
            }
            DispatchQueue.main.async {
                viewController.present(confirmAlert, animated: true, completion: nil)
            }

            
        }
        
        dataTask.resume()
        
    } catch (let err) {
        print(err.localizedDescription)
        errorAlert.message = "데이터 변환에 실패했습니다."
        viewController.present(errorAlert, animated: true, completion: nil)
    }
}
