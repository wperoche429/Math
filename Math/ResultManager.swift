//
//  ResultManager.swift
//  Math
//
//  Created by William Peroche on 24/06/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import Foundation
import RealmSwift

class ResultManager {
    static let instance = ResultManager()
    
    private var tests : Results<Test>!
    let realm = try! Realm()
    
    init() {
        tests = realm.objects(Test.self)
    }
    
    func add(test:Test) {
        try! realm.write {
            realm.add(test)
        }
    }
    
    func clearAll() {
        for item in tests {
            try! realm.write {
                realm.delete(item)
            }
        }
    }
    
    func clear(dateString : String) {
        for item in tests {
            if item.dateString == dateString {
                try! realm.write {
                    realm.delete(item)
                }
            }
        }
    }
    
    func getDateArray() -> [String] {
        var result = [String]()
        
        for item in tests {
            if !result.contains(item.dateString) {
                result.append(item.dateString)
            }
        }
        
        return result
    }
    
    func getTests(forDate date: String) -> [Test] {
        var result = [Test]()
        
        for item in tests {
            if item.dateString == date {
                result.append(item)
            }
        }
        
        return result
    }
}
