//
//  Category.swift
//  Todoey
//
//  Created by Barthold Albrecht on 23.01.18.
//  Copyright © 2018 Barthold Albrecht. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
