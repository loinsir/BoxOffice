//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/27.
//

import UIKit

class CommentViewController: UIViewController {
    
    let emptyStar: UIImage = UIImage(named: "ic_star_large") ?? UIImage()
    let halfStar: UIImage = UIImage(named: "ic_star_large_half") ?? UIImage()
    let fullStar: UIImage = UIImage(named: "ic_star_large_full") ?? UIImage()

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    
    @IBOutlet weak var firstStarImage: UIImageView!
    @IBOutlet weak var secondStarImage: UIImageView!
    @IBOutlet weak var thirdStarImage: UIImageView!
    @IBOutlet weak var fourthStarImage: UIImageView!
    @IBOutlet weak var fifthStarImage: UIImageView!
    
    @IBOutlet weak var ratePointLabel: UILabel!
    
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var commentField: UITextView!
    
    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var touchOutsideGestureRecognizer: UITapGestureRecognizer!
    
    var movieIdToSet: String?
    var movieTitleToSet: String?
    var gradeImageToSet: UIImage?
    
    var currentUserRate: Double = 1
    
    @IBAction func touchCommentAddButton(_ sender: UIButton) {
        let alertController: UIAlertController = {
            let controller: UIAlertController = UIAlertController(title: "필드가 채워지지 않음", message: "모든 입력창에 값을 입력해주시기 바랍니다.", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "확인", style: .cancel, handler: {action in self.dismiss(animated: true, completion: nil)}))
            return controller
        }()
        
        if nicknameField.text?.isEmpty ?? false ||
            commentField.text == "" ||
            commentField.text == "한줄평을 작성해주세요" &&
            commentField.textColor == .lightGray {
            self.present(alertController, animated: true, completion: nil)
        } else {
            if let nickname: String = nicknameField.text, let comment: String = commentField.text, let id: String = movieIdToSet {
                requestAddComment(rating: currentUserRate, writer: nickname, movieID: id, contents: comment, viewController: self)
            }
        }
        
    }
    
    
    @IBAction func touchInputFieldOutside(_ sender: UITapGestureRecognizer) {
        nicknameField.endEditing(true)
        commentField.endEditing(true)
    }
    
    @IBAction func valueChangedStarSlider(_ sender: UISlider) {
        switch sender.value {
        case 1..<2:
            currentUserRate = 1
            firstStarImage.image = halfStar
            secondStarImage.image = emptyStar
            thirdStarImage.image = emptyStar
            fourthStarImage.image = emptyStar
            fifthStarImage.image = emptyStar
        case 2..<3:
            currentUserRate = 2
            firstStarImage.image = fullStar
            secondStarImage.image = emptyStar
            thirdStarImage.image = emptyStar
            fourthStarImage.image = emptyStar
            fifthStarImage.image = emptyStar
        case 3..<4:
            currentUserRate = 3
            firstStarImage.image = fullStar
            secondStarImage.image = halfStar
            thirdStarImage.image = emptyStar
            fourthStarImage.image = emptyStar
            fifthStarImage.image = emptyStar
        case 4..<5:
            currentUserRate = 4
            firstStarImage.image = fullStar
            secondStarImage.image = fullStar
            thirdStarImage.image = emptyStar
            fourthStarImage.image = emptyStar
            fifthStarImage.image = emptyStar
        case 5..<6:
            currentUserRate = 5
            firstStarImage.image = fullStar
            secondStarImage.image = fullStar
            thirdStarImage.image = halfStar
            fourthStarImage.image = emptyStar
            fifthStarImage.image = emptyStar
        case 6..<7:
            currentUserRate = 6
            firstStarImage.image = fullStar
            secondStarImage.image = fullStar
            thirdStarImage.image = fullStar
            fourthStarImage.image = emptyStar
            fifthStarImage.image = emptyStar
        case 7..<8:
            currentUserRate = 7
            firstStarImage.image = fullStar
            secondStarImage.image = fullStar
            thirdStarImage.image = fullStar
            fourthStarImage.image = halfStar
            fifthStarImage.image = emptyStar
        case 8..<9:
            currentUserRate = 8
            firstStarImage.image = fullStar
            secondStarImage.image = fullStar
            thirdStarImage.image = fullStar
            fourthStarImage.image = fullStar
            fifthStarImage.image = emptyStar
        case 9..<10:
            currentUserRate = 9
            firstStarImage.image = fullStar
            secondStarImage.image = fullStar
            thirdStarImage.image = fullStar
            fourthStarImage.image = fullStar
            fifthStarImage.image = halfStar
        case 10:
            currentUserRate = 10
            firstStarImage.image = fullStar
            secondStarImage.image = fullStar
            thirdStarImage.image = fullStar
            fourthStarImage.image = fullStar
            fifthStarImage.image = fullStar
        default:
            currentUserRate = 1
            firstStarImage.image = halfStar
            secondStarImage.image = emptyStar
            thirdStarImage.image = emptyStar
            fourthStarImage.image = emptyStar
            fifthStarImage.image = emptyStar
        }
        
        
        ratePointLabel.text = "\(currentUserRate)"
    }
    
    func layoutCommentField() {
        commentField.layer.cornerRadius = 10
        commentField.layer.borderColor = UIColor.opaqueSeparator.cgColor
        commentField.layer.borderWidth = 1
    }
    
    func initStarSlider() {
        firstStarImage.image = halfStar
        secondStarImage.image = emptyStar
        thirdStarImage.image = emptyStar
        fourthStarImage.image = emptyStar
        fifthStarImage.image = emptyStar
        ratePointLabel.text = "1"
    }
    
    func setDataFromSegue() {
        movieTitleLabel.text = movieTitleToSet
        gradeImage.image = gradeImageToSet
    }
    
    func setCommentFieldPlaceholder() {
        commentField.delegate = self
        commentField.text = "한줄평을 작성해주세요"
        commentField.textColor = .lightGray
    }
    
    func setNicknameMemory() {
        if let nickname:String = WriterMemory.shared.writer {
            nicknameField.text = nickname
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataFromSegue()
        layoutCommentField()
        initStarSlider()
        setCommentFieldPlaceholder()
        setNicknameMemory()
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CommentViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "한줄평을 작성해주세요"
            textView.textColor = .lightGray
        }
    }
}
