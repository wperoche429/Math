//
//  Test.swift
//  Math
//
//  Created by William Peroche on 24/06/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import Foundation
import RealmSwift

class Test : Object {
    @objc dynamic var formula = ""
    @objc dynamic var dateString = ""
    @objc dynamic var timeString = ""
    @objc dynamic var timeSpent : TimeInterval = 0
    @objc dynamic var isCorrect = false
}
