//
//  posterImageViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/15.
//

import UIKit

class posterImageViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    var imageForZoom: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        posterImage.image = imageForZoom
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

extension posterImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return posterImage
    }
}
