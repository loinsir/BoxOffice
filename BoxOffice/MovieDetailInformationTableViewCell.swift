//
//  MovieDetailInformationTableViewCell.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/05.
//

import UIKit

class MovieDetailInformationTableViewCell: UITableViewCell {
    
    static let identifier: String = "informationCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var genreTimeLabel: UILabel!
    @IBOutlet weak var reservationRateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
