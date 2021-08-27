//
//  ViewController.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/24.
//

import UIKit

class TableTabMovieViewController: UIViewController {
    
    @IBOutlet var arrangeButton: UIBarButtonItem!
    
    @IBAction func touchArrangeButton(_ sender: UIBarButtonItem) {
        showAlertController(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension TableTabMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension TableTabMovieViewController: UITableViewDelegate {
    
}
