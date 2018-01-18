//
//  Model.swift
//  Todoey
//
//  Created by Barthold Albrecht on 17.01.18.
//  Copyright © 2018 Barthold Albrecht. All rights reserved.
//

import Foundation
class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
