//
//  MovieDetailTableViewCell.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/04.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var genreAndTimeLabel: UILabel!
    
    @IBOutlet weak var reservationRateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var starRateImageStack: UIStackView!
    @IBOutlet weak var audienceLabel: UILabel!
    
    @IBOutlet weak var synopsisTextView: UITextView!
    
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorListLabel: UILabel!
    
    @IBOutlet weak var commentTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
