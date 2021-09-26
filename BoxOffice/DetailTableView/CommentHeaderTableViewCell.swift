//
//  CommentHeaderTableViewCell.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/26.
//

import UIKit

class CommentHeaderTableViewCell: UITableViewCell {
    
    static let identifier: String = "commentHeaderCell"
    
    @IBOutlet var addCommentButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
