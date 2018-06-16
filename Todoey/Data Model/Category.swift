 //
//  Category.swift
//  Todoey
//
//  Created by Marcin Szabłowski on 18.05.2018.
//  Copyright © 2018 Marcin Szabłowski. All rights reserved.
//

import Foundation
import RealmSwift
 
 
 //Defining model for Realm use like regular Swift classes
 class Category : Object {

    @objc dynamic var name = ""
    let items = List<Item>()
    
 }
