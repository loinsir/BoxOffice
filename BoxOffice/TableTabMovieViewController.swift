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
        guard let datas: [Data] = MovieListData.shared.imageData else { return }
        self.imageData = datas
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "예매율"
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveMovieImageDataNotification(_:)), name: DidReceiveMovieImageDataNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        cell.posterImage.image = UIImage(data: imageData[indexPath.item])
        
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
}
