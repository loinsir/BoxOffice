//
//  TableViewCell.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/27.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
