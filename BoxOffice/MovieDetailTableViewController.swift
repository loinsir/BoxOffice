//
//  MovieDetailTableViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/05.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    
    var id: String!

    var posterImageURL: URL?
    var movieTitleToSet: String?
    var openDateToSet: String?
    var genreTimeToSet: String?
    weak var gradeImageToSet: UIImage!
    
    var reservationRateToSet: Float?
    var ratingToSet: Float?
    var audienceToSet: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        requestMovieDetailData(id: id)
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
                self.posterImageURL = apiResponse.imageURL
                self.movieTitleToSet = apiResponse.title
                self.openDateToSet = apiResponse.date
                self.genreTimeToSet = apiResponse.genreAndTime
                self.reservationRateToSet = apiResponse.reservationRate
                self.ratingToSet = apiResponse.userRating
                self.audienceToSet = apiResponse.audience
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1. movie information cell
        guard let cell: MovieDetailInformationTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieDetailInformationTableViewCell.identifier, for: indexPath) as? MovieDetailInformationTableViewCell else { return UITableViewCell() }
        
        guard let title = self.movieTitleToSet else { return UITableViewCell() }
        guard let openDate = self.openDateToSet else { return UITableViewCell() }
        guard let reservation = self.reservationRateToSet else { return UITableViewCell() }
        guard let audience = self.audienceToSet else { return UITableViewCell() }
        guard let rating = self.ratingToSet else { return UITableViewCell() }
        guard let genreTime = self.genreTimeToSet else { return UITableViewCell () }
        
//        cell.posterImageView.image = posterImageToSet
        cell.movieTitleLabel.text = title
        cell.openDateLabel.text = openDate
        cell.reservationRateLabel.text = String(describing: reservation)
        cell.audienceLabel.text = String(describing: audience)
        cell.ratingLabel.text = String(describing: rating)
        cell.genreTimeLabel.text = String(describing: genreTime)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
