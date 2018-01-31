//
//  ChecklistItem.swift
//  TouristAttractionsChecklist
//
//  Created by Student on 2018-01-30.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ChecklistItem: NSObject, Codable {
    
    var text = ""
    var checked = false
    var location = ""
    
    init(text: String, checked:Bool, location: String){
        self.text = text
        self.checked = checked
        self.location = text
    }

}
