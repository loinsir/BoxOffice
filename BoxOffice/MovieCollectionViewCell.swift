//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/31.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "MovieCollectionViewCell"
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var gradeImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
    }
    
}
