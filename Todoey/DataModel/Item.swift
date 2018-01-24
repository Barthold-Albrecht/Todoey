//
//  Item.swift
//  Todoey
//
//  Created by Barthold Albrecht on 23.01.18.
//  Copyright © 2018 Barthold Albrecht. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var done: Bool = false
   
    
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
