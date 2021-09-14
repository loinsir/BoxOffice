//
//  MovieDetailTableViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/05.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    
    var id: String!

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var genreTimeLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    
    @IBOutlet weak var reservationRateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    
    @IBOutlet weak var synopsisTextView: UITextView!
    
    
    var posterImageData: Data?
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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "informationCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "synopsisCell")
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
                let imageData: Data = try Data(contentsOf: apiResponse.imageURL)
                guard let posterImage: UIImage = UIImage(data: imageData) else { return }
                
                DispatchQueue.main.async {
                    self.posterImageView.image = posterImage
                    self.movieTitleLabel.text = apiResponse.title
                    self.openDateLabel.text = apiResponse.date
                    self.genreTimeLabel.text = apiResponse.genreAndTime
                    self.reservationRateLabel.text = String(describing: apiResponse.reservationRate)
                    self.ratingLabel.text = String(describing: apiResponse.userRating)
                    self.audienceLabel.text = String(describing: apiResponse.audience)
                    self.synopsisTextView.text = apiResponse.synopsis
                    
                    self.tableView.reloadData()
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
            
        }
        dataTask.resume()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }


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
