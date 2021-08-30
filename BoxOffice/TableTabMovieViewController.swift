//
//  ViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/24.
//

import UIKit

class TableTabMovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var arrangeButton: UIBarButtonItem!
    
    var movieDatas: [Movie]?
    
    @IBAction func touchArrangeButton(_ sender: UIBarButtonItem) {
        showAlertController(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestMovieDatas(orderType: .curation)
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
                self.movieDatas = apiResponse.movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
}

extension TableTabMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDatas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell() }
        
        DispatchQueue.global().async {
            if let url: URL = self.movieDatas?[indexPath.row].thumbnailURL {
                do {
                    let data: Data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let index: IndexPath = self.tableView.indexPath(for: cell) {
                            if index.row == indexPath.row {
                                cell.posterImage.image = UIImage(data: data)
                            }
                        }
                    }
                } catch (let err) {
                    print(err.localizedDescription)
                }
            }
        }
        
        cell.movieTitleLabel.text = movieDatas?[indexPath.row].title
        cell.rateLabel.text = movieDatas?[indexPath.row].id
        cell.openDateLabel.text = movieDatas?[indexPath.row].date
        
        guard let grade: Int = movieDatas?[indexPath.row].grade else { return UITableViewCell() }
        switch grade {
        case 0:
            cell.gradeImage.image = UIImage(named: "ic_allages")
        case 12:
            cell.gradeImage.image = UIImage(named: "ic_12")
        case 15:
            cell.gradeImage.image = UIImage(named: "ic_15")
        case 19:
            cell.gradeImage.image = UIImage(named: "ic_19")
        default:
            cell.gradeImage.image = nil
        }
        
        return cell
    }
}

extension TableTabMovieViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
