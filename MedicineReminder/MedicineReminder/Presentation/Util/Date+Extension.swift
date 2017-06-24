//
//  Date+Extension.swift
//  RMS
//
//  Created by Marian on 1/30/17.
//  Copyright © 2017 mohamed salah. All rights reserved.
//

import UIKit

extension Date {
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    
}
