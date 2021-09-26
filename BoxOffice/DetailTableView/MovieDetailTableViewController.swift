//
//  MovieDetailTableViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/05.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    
    var id: String!
    
    var movieInformationData: MovieData?
    var userComments: [comment] = []
    
    let emptyStar: UIImage = UIImage(named: "ic_star_large") ?? UIImage()
    let halfStar: UIImage = UIImage(named: "ic_star_large_half") ?? UIImage()
    let fullStar: UIImage = UIImage(named: "ic_star_large_full") ?? UIImage()
    
    func layoutTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        requestUserComment()
        layoutTableView()
        requestMovieDetailData(id: id)
    }
    
    func showNoCommentDataAlert() {
        let alertController: UIAlertController = UIAlertController(title: "데이터 수신 실패", message: "평점 데이터를 수신하는데 실패했습니다.", preferredStyle: .alert)
        let confirmAction: UIAlertAction = UIAlertAction(title: "confirm", style: .cancel, handler: {(handler) in self.dismiss(animated: true, completion: nil)})
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func requestUserComment() {
        guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/comments?movie_id="+self.id) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let err = error {
                print(err.localizedDescription)
            }
            
            guard let data: Data = data else { return }
            do {
                let apiResponse: comments = try JSONDecoder().decode(comments.self, from: data)
                self.userComments = apiResponse.comments
                DispatchQueue.main.async {
                    if self.userComments.count == 0 {
                        self.showNoCommentDataAlert()
                    }
                    else {
                        self.tableView.reloadData()
                    }
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    func requestMovieDetailData(id: String) {
        guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movie?id=\(id)") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let err = error {
                print(err.localizedDescription)
            }
            
            guard let data: Data = data else { return }
            do {
                let apiResponse: MovieData = try JSONDecoder().decode(MovieData.self, from: data)
                self.movieInformationData = apiResponse
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
            
        }
        dataTask.resume()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4 + userComments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movieData: MovieData = movieInformationData else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            guard let cell: InformationTableViewCell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.identifier, for: indexPath) as? InformationTableViewCell else { return UITableViewCell() }
            
            do {
                let data: Data = try Data(contentsOf: movieData.imageURL)
                guard let image: UIImage = UIImage(data: data) else { return UITableViewCell() }
                cell.posterImageView.image = image
            } catch (let err) {
                print(err.localizedDescription)
            }
            cell.movieTitleLabel.text = movieData.title
            cell.openDateLabel.text = movieData.date
            cell.genreTimeLabel.text = movieData.genreAndTime
            cell.reservationRateLabel.text = String(describing: movieData.reservationRate)
            cell.ratingLabel.text = String(describing: movieData.userRating)
            cell.audienceLabel.text = String(describing: movieData.audience)
            
            switch movieData.userRating {
            case 0...1:
                cell.firstStarImage.image = halfStar
                cell.secondStarImage.image = emptyStar
                cell.thirdStarImage.image = emptyStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 1...2:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = emptyStar
                cell.thirdStarImage.image = emptyStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 2...3:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = halfStar
                cell.thirdStarImage.image = emptyStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 3...4:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = emptyStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 4...5:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = halfStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 5...6:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 6...7:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = halfStar
                cell.fifthStarImage.image = emptyStar
            case 7...8:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = fullStar
                cell.fifthStarImage.image = emptyStar
            case 8...9:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = fullStar
                cell.fifthStarImage.image = halfStar
            default:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = fullStar
                cell.fifthStarImage.image = fullStar
            }
            
            return cell
            
        case 1:
            guard let cell: SynopsisTableViewCell = tableView.dequeueReusableCell(withIdentifier: SynopsisTableViewCell.identifier, for: indexPath) as? SynopsisTableViewCell else { return UITableViewCell() }
            cell.synopsisLabel.text = movieData.synopsis
            
            return cell
            
        case 2:
            guard let cell: DirectorAndActorTableViewCell = tableView.dequeueReusableCell(withIdentifier: DirectorAndActorTableViewCell.identifier, for: indexPath) as? DirectorAndActorTableViewCell else { return UITableViewCell() }
            
            cell.actorLabel.text = movieData.actor
            cell.directorLabel.text = movieData.director
            
            return cell
            
        case 3:
            guard let cell: CommentHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentHeaderTableViewCell.identifier, for: indexPath) as? CommentHeaderTableViewCell else { return UITableViewCell() }
            
            return cell
            
        case 4...:
            guard let cell: UserCommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: UserCommentTableViewCell.identifier, for: indexPath) as? UserCommentTableViewCell else { return UITableViewCell() }
            
            let commentIndex: Int = indexPath.row - 4
            
            cell.userLabel.text = userComments[commentIndex].writer
            cell.timeLabel.text = userComments[commentIndex].timeString
            cell.commentLabel.text = userComments[commentIndex].contents
            
            switch userComments[commentIndex].rating {
            case 0...1:
                cell.firstStarImage.image = halfStar
                cell.secondStarImage.image = emptyStar
                cell.thirdStarImage.image = emptyStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 1...2:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = emptyStar
                cell.thirdStarImage.image = emptyStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 2...3:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = halfStar
                cell.thirdStarImage.image = emptyStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 3...4:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = emptyStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 4...5:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = halfStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 5...6:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = emptyStar
                cell.fifthStarImage.image = emptyStar
            case 6...7:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = halfStar
                cell.fifthStarImage.image = emptyStar
            case 7...8:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = fullStar
                cell.fifthStarImage.image = emptyStar
            case 8...9:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = fullStar
                cell.fifthStarImage.image = halfStar
            default:
                cell.firstStarImage.image = fullStar
                cell.secondStarImage.image = fullStar
                cell.thirdStarImage.image = fullStar
                cell.fourthStarImage.image = fullStar
                cell.fifthStarImage.image = fullStar
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "touchPosterImage" {
            guard let movieData: MovieData = movieInformationData else { return }
            guard let destination: posterImageViewController = segue.destination as? posterImageViewController else { return }
            
            do {
                let data: Data = try Data(contentsOf: movieData.imageURL)
                guard let image: UIImage = UIImage(data: data) else { return }
                destination.imageForZoom = image
            } catch (let err) {
                print(err.localizedDescription)
            }
            
        }
    }
    

}
