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
    var imageData: [Data] = []
    
    @IBAction func touchArrangeButton(_ sender: UIBarButtonItem) {
        showAlertController(viewController: self)
    }
    
    @objc func didReceiveMovieImageDataNotification(_ noti: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "예매율"
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveMovieImageDataNotification(_:)), name: DidReceiveMovieImageDataNotification, object: nil)
        requestMovieDatas(orderType: .curation)
    }
    
}

extension TableTabMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieListData.shared.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell() }
        
        cell.movieTitleLabel.text = MovieListData.shared.data?[indexPath.row].title
        cell.rateLabel.text = MovieListData.shared.data?[indexPath.row].rateString
        cell.openDateLabel.text = MovieListData.shared.data?[indexPath.row].openDateString
        
        guard let grade: Int = MovieListData.shared.data?[indexPath.row].grade else { return UITableViewCell() }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell: MovieTableViewCell = cell as? MovieTableViewCell else { return }
        DispatchQueue.global().async {
            guard let url = MovieListData.shared.data?[indexPath.row].thumbnailURL else { return }
            do {
                let data: Data = try Data(contentsOf: url)
                guard let image: UIImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    guard let index: IndexPath = tableView.indexPath(for: cell) else { return }
                    if index.row == indexPath.row {
                        cell.posterImage.image = image
                    }
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
    }
}
