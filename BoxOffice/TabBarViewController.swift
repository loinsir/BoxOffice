//
//  TabBarViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/04.
//

import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var orderSettingButton: UIBarButtonItem!
    
    @IBAction func touchArrangeButton(_ sender: UIBarButtonItem) {
        showAlertController(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "예매율"
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
