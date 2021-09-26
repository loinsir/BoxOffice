//
//  ViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/24.
//

import UIKit

class TableTabMovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    var imageData: [Data] = []
    
    @objc func didRequestMovieImageDataNotification(_ noti: Notification) {
        self.indicator.isHidden = false
    }
    
    @objc func didReceiveMovieImageDataNotification(_ noti: Notification) {
        guard let orderType: OrderType = noti.userInfo?["orderType"] as? OrderType else { return }
        
        var newTitle: String = ""
        switch orderType {
        case .curation:
            newTitle = "큐레이션"
        case .ticketingRate:
            newTitle = "예매율"
        case .openDate:
            newTitle = "개봉일"
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.navigationItem.title = newTitle
            self.indicator.isHidden = true
        }
    }
    
    @objc func pullingTableView(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        tableView.reloadData()
    }
    
    func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        let refreshController: UIRefreshControl = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(pullingTableView(_:)), for: .valueChanged)
        tableView.refreshControl = refreshController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveMovieImageDataNotification(_:)), name: DidReceiveMovieImageDataNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRequestMovieImageDataNotification(_:)), name: DidRequestMovieImageDataNotification, object: nil)
        requestMovieDatas(orderType: .curation)
        layoutTableView()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let destination: MovieDetailTableViewController = segue.destination as? MovieDetailTableViewController else { return }
        
        guard let cell: MovieListTableViewCell = sender as? MovieListTableViewCell else { return }
        
        destination.id = cell.id
    }
    
}

extension TableTabMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieListData.shared.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieListTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier) as? MovieListTableViewCell else { return UITableViewCell() }
        
        cell.movieTitleLabel.text = MovieListData.shared.data?[indexPath.row].title
        cell.rateLabel.text = MovieListData.shared.data?[indexPath.row].tableCellRateString
        cell.openDateLabel.text = MovieListData.shared.data?[indexPath.row].openDateString
        cell.id = MovieListData.shared.data?[indexPath.row].id
        
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
        guard let cell: MovieListTableViewCell = cell as? MovieListTableViewCell else { return }
        DispatchQueue.global().async {
            guard let url = MovieListData.shared.data?[indexPath.row].thumbnailURL else { return }
            do {
                let data: Data = try Data(contentsOf: url)
                guard let image: UIImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    guard let index: IndexPath = tableView.indexPath(for: cell) else { return }
                    if index.row == indexPath.row {
                        cell.posterImage.image = image
                        cell.imageData = data
                    }
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
