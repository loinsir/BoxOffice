//
//  ActionSheet.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/08/27.
//

import Foundation
import UIKit

func showAlertController(viewController: UIViewController) {
    var controllerTitle: String = ""
    
    let alertController: UIAlertController = {
        let controller: UIAlertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        let ticketingRateAction: UIAlertAction = UIAlertAction(title: "예매율", style: .default, handler: {_ in controllerTitle = "예매율"})
        let curationAction: UIAlertAction = UIAlertAction(title: "큐레이션", style: .default, handler: {_ in controllerTitle = "큐레이션"})
        let openingDateAction: UIAlertAction = UIAlertAction(title: "개봉일", style: .default, handler: {_ in controllerTitle = "개봉일"})
        let cancelAction: UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        controller.addAction(ticketingRateAction)
        controller.addAction(curationAction)
        controller.addAction(openingDateAction)
        controller.addAction(cancelAction)
        
        return controller
    }()
    
    viewController.present(alertController, animated: true, completion: {viewController.title = controllerTitle})
}
