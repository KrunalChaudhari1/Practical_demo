//
//  CustomAlert.swift
//  LoginAppCoreData
//
//  Created by Aswath Ravichandran on 15/04/22.
//

import Foundation
import UIKit

class CustomAlert {
    static  func alertMessage (_ title : String?, _ message : String?) -> UIAlertController {
        
        let alert = UIAlertController(title:  title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok", style:.default, handler: nil))
        return alert
    }
}
