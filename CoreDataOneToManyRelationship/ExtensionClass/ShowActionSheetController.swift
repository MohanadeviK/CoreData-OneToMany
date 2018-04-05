//
//  ShowActionSheetController.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showActionSheetWithTitle(title : String? = "", message : String? = nil, actionTitle : [String], actionStyle : [UIAlertActionStyle], sourceView : UIView, actionCompletionHandler : @escaping OnActionHandler) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for(index, value) in actionTitle.enumerated() {
            let actStyle : UIAlertActionStyle = actionStyle[index]
            alert.addAction(UIAlertAction(title: value, style: actStyle, handler: { action in
                actionCompletionHandler(value)
            }))
        }
        
        //iPad
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = sourceView
            presenter.sourceRect = sourceView.frame
        }
        self.present(alert, animated: true, completion: nil)
        
    }
}
