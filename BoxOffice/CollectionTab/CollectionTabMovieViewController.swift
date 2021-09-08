//
//  CollectionMovieViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/27.
//

import UIKit

class CollectionTabMovieViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
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
            self.collectionView.reloadData()
            self.navigationItem.title = newTitle
            self.indicator.isHidden = true
        }
    }
    
    @objc func pullingCollectionView(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        collectionView.reloadData()
    }
    
    func layoutCollectionView() {
        let cellSize = UIScreen.main.bounds.width / 2.0
        let flowLayout: UICollectionViewFlowLayout = {
           let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: cellSize - 30, height: cellSize + 70)
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 15
            layout.sectionInset = UIEdgeInsets(top: CGFloat.zero, left: 15, bottom: CGFloat.zero, right: 15)
            return layout
        }()
        
        self.collectionView.collectionViewLayout = flowLayout
        
        let refreshController: UIRefreshControl = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(pullingCollectionView(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        layoutCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(didRequestMovieImageDataNotification(_:)), name: DidRequestMovieImageDataNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieImageDataNotification(_:)), name: DidReceiveMovieImageDataNotification, object: nil)
        indicator.isHidden = true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let destination: MovieDetailTableViewController = segue.destination as? MovieDetailTableViewController else { return }
        guard let cell: MovieCollectionViewCell = sender as? MovieCollectionViewCell else { return }
        
        destination.id = cell.id
    }

}

extension CollectionTabMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieListData.shared.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.movieTitleLabel.text = MovieListData.shared.data?[indexPath.item].title
        cell.rateLabel.text = MovieListData.shared.data?[indexPath.item].collectionCellRateString
        cell.openDateLabel.text = MovieListData.shared.data?[indexPath.item].date
        cell.id = MovieListData.shared.data?[indexPath.item].id
        
        guard let grade: Int = MovieListData.shared.data?[indexPath.item].grade else { return UICollectionViewCell() }
        
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

extension CollectionTabMovieViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell: MovieCollectionViewCell = cell as? MovieCollectionViewCell else { return }
        DispatchQueue.global().async {
            guard let url = MovieListData.shared.data?[indexPath.item].thumbnailURL else { return }
            do {
                let data: Data = try Data(contentsOf: url)
                guard let image: UIImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    guard let index: IndexPath = self.collectionView.indexPath(for: cell) else { return }
                    if index.item == indexPath.item {
                        cell.posterImage.image = image
                    }
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
    }
}
