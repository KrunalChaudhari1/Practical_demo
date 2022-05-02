//
//  HelperClass.swift
//  LoginAppCoreData
//
//  Created by Aswath Ravichandran on 15/04/22.
//

import Foundation
import UIKit

extension UIButton {
    func ToRound(){
        self.layer.cornerRadius = self.frame.size.width/8
        self.clipsToBounds = true
    }
}


