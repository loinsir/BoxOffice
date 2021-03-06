//
//  DirectorAndActorTableViewCell.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/26.
//

import UIKit

class DirectorAndActorTableViewCell: UITableViewCell {
    
    static let identifier: String = "directorAndActorCell"
    
    @IBOutlet var directorLabel: UILabel!
    @IBOutlet var actorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
