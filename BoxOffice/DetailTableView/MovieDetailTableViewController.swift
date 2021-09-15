//
//  MovieDetailTableViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/05.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    
    var id: String!
    
// - MARK: IBOutlet
    @IBOutlet weak var posterImageView: UIImageView!

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var genreTimeLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    
    @IBOutlet weak var reservationRateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var firstStarImage: UIImageView!
    @IBOutlet weak var secondStarImage: UIImageView!
    @IBOutlet weak var thirdStarImage: UIImageView!
    @IBOutlet weak var fourthStarImage: UIImageView!
    @IBOutlet weak var fifthStarImage: UIImageView!
    
    @IBOutlet weak var audienceLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    
    @IBAction func touchPosterImage(_ sender: UITapGestureRecognizer) {
        print("touch!")
    }
    
    var posterImageData: Data?
    var movieTitleToSet: String?
    var openDateToSet: String?
    var genreTimeToSet: String?
    weak var gradeImageToSet: UIImage!
    
    var reservationRateToSet: Float?
    var ratingToSet: Float?
    var audienceToSet: Int?
    
    func layoutTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 240
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "informationCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "synopsisCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "directorCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.layoutTableView()
        requestMovieDetailData(id: id)
        self.posterImageView.isUserInteractionEnabled = true
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
                guard let emptyStar: UIImage = UIImage(named: "ic_star_large") else { return }
                guard let halfStar: UIImage = UIImage(named: "ic_star_large_half") else { return }
                guard let fullStar: UIImage = UIImage(named: "ic_star_large_full") else { return }
                
                DispatchQueue.main.async {
                    self.posterImageView.image = posterImage
                    self.movieTitleLabel.text = apiResponse.title
                    self.openDateLabel.text = apiResponse.date
                    self.genreTimeLabel.text = apiResponse.genreAndTime
                    self.reservationRateLabel.text = String(describing: apiResponse.reservationRate)
                    self.ratingLabel.text = String(describing: apiResponse.userRating)
                    self.audienceLabel.text = String(describing: apiResponse.audience)
                    self.synopsisLabel.text = apiResponse.synopsis
                    self.directorLabel.text = apiResponse.director
                    self.actorLabel.text = apiResponse.actor
                    
                    
                    switch apiResponse.userRating {
                    case 0...1:
                        self.firstStarImage.image = halfStar
                        self.secondStarImage.image = emptyStar
                        self.thirdStarImage.image = emptyStar
                        self.fourthStarImage.image = emptyStar
                        self.fifthStarImage.image = emptyStar
                    case 1...2:
                        self.firstStarImage.image = fullStar
                        self.secondStarImage.image = emptyStar
                        self.thirdStarImage.image = emptyStar
                        self.fourthStarImage.image = emptyStar
                        self.fifthStarImage.image = emptyStar
                    case 2...3:
                        self.firstStarImage.image = fullStar
                        self.secondStarImage.image = halfStar
                        self.thirdStarImage.image = emptyStar
                        self.fourthStarImage.image = emptyStar
                        self.fifthStarImage.image = emptyStar
                    case 3...4:
                        self.firstStarImage.image = fullStar
                        self.secondStarImage.image = fullStar
                        self.thirdStarImage.image = emptyStar
                        self.fourthStarImage.image = emptyStar
                        self.fifthStarImage.image = emptyStar
                    case 4...5:
                        self.firstStarImage.image = fullStar
                        self.secondStarImage.image = fullStar
                        self.thirdStarImage.image = halfStar
                        self.fourthStarImage.image = emptyStar
                        self.fifthStarImage.image = emptyStar
                    case 5...6:
                        self.firstStarImage.image = fullStar
                        self.secondStarImage.image = fullStar
                        self.thirdStarImage.image = fullStar
                        self.fourthStarImage.image = emptyStar
                        self.fifthStarImage.image = emptyStar
                    case 6...7:
                        self.firstStarImage.image = fullStar
                        self.secondStarImage.image = fullStar
                        self.thirdStarImage.image = fullStar
                        self.fourthStarImage.image = halfStar
                        self.fifthStarImage.image = emptyStar
                    case 7...8:
                        self.firstStarImage.image = fullStar
                        self.secondStarImage.image = fullStar
                        self.thirdStarImage.image = fullStar
                        self.fourthStarImage.image = fullStar
                        self.fifthStarImage.image = emptyStar
                    case 8...9:
                        self.firstStarImage.image = fullStar
                        self.secondStarImage.image = fullStar
                        self.thirdStarImage.image = fullStar
                        self.fourthStarImage.image = fullStar
                        self.fifthStarImage.image = halfStar
                    default:
                        self.firstStarImage.image = fullStar
                        self.secondStarImage.image = fullStar
                        self.thirdStarImage.image = fullStar
                        self.fourthStarImage.image = fullStar
                        self.fifthStarImage.image = fullStar
                    }
                    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "touchPosterImage" {
            guard let destination: posterImageViewController = segue.destination as? posterImageViewController else { return }
            
            destination.imageForZoom = self.posterImageView.image
        }
        
    }
    

}
