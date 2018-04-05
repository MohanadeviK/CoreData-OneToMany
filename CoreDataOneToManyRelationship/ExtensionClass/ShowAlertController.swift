//
//  ShowAlertController.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation
import UIKit

public typealias OnActionHandler = (_ actionValue : String?) -> Void

extension UIViewController {
    
    func showAlertWithTitle(title : String? = "", message : String? = "", actionTitle : [String], actionStyle : [UIAlertActionStyle], actionCompletionHandler : OnActionHandler? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        for(title, style) in zip(actionTitle, actionStyle) {
            
            alert.addAction(UIAlertAction(title: title, style: style, handler: { action in
                if (actionCompletionHandler != nil) {
                    actionCompletionHandler!(title)
                }
            }))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
