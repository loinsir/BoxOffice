//
//  Network.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/27.
//

import Foundation

/* MARK: - Movie List
 {
    "title": "신과함께-죄와벌",
    "reservation_grade": 1,
    "thumb": "http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.jpg?type=m99_141_2",
    "id": "5a54c286e8a71d136fb5378e",
    "reservation_rate": 35.5,
    "user_rating": 7.98,
    "grade": 12,
    "date": "2017-12-20"
},
 */

struct MovieListData: Codable {
    var title: String
    var reservationGrade: Int
    var thumbnailURL: URL
    var id: String
    var reservationRate: Float
    var userRating: Float
    var grade: Int
    var date: Date
    
    enum MovieListData: String, CodingKey {
        case title
        case reservationGrade = "reservation_grade"
        case thumbnailURL = "thumb"
        case id
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
        case grade
        case date
    }
}

/* MARK: - Movie Data
 {
    audience: 11676822,
    grade: 12,
    actor: "하정우(강림), 차태현(자홍), 주지훈(해원맥), 김향기(덕춘)",
    duration: 139,
    reservation_grade: 1,
    title: "신과함께-죄와벌",
    reservation_rate: 35.5,
    user_rating: 7.98,
    date: "2017-12-20",
    director: "김용화",
    id: "5a54c286e8a71d136fb5378e",
    image:
    "http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.
    jpg",
    synopsis: "저승 법에 의하면, (중략) 고난과 맞닥뜨리는데... 누구나 가지만 아무도 본 적 없는 곳, 새 로운 세계의 문이 열린다!",
    genre: "판타지, 드라마"
 }
 */

struct MovieData {
    var audience: Int
    var grade: Int
    var actor: String
    var duration: Int
    var reservationGrade: Int
    var title: String
    var reservationRate: Float
    var userRating: Float
    var date: Date
    var director: String
    var id: String
    var imageURL: URL
    var synopsis: String
    var genre: String
    
    enum MovieData: String, CodingKey {
        case audience
        case grade
        case actor
        case duration
        case reservationGrade = "reservation_grade"
        case title
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
        case date
        case director
        case id
        case imageURL = "image"
        case synopsis
        case genre
    }
}

/* MARK: - Comment
 {
 id: "5d5e09241b865e00110ab5eb",
 rating: 10,
 timestamp: 1515748870.80631,
 writer: "두근반 세근반",
 movie_id: "5a54c286e8a71d136fb5378e",
 contents:"정말 다섯 번은 넘게 운듯 ᅲᅲᅲ 감동 쩔어요.꼭 보셈 두 번 보셈"
 }
 */
struct comment {
    var id: String
    var rating: Int
    var timestamp: Date
    var writer: String
    var movieID: String
    var contents: String
    
    enum comment: String, CodingKey {
        case id
        case rating
        case timestamp
        case writer
        case movieID = "movie_id"
        case contents
    }
}
