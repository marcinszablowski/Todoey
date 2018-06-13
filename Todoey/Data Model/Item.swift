//
//  Item.swift
//  Todoey
//
//  Created by Marcin Szabłowski on 18.05.2018.
//  Copyright © 2018 Marcin Szabłowski. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

