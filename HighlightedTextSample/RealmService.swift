//
//  RealmService.swift
//  HighlightedTextSample
//
//  Created by 高井　翔太 on 2018/05/23.
//  Copyright © 2018年 Medley, inc. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService()
    var realm: Realm?

    private init() {
        do {
            realm = try Realm()
#if DEBUG
            storeDummyData()
#endif
        } catch {
            print("realm initialization error")
            return
        }
    }

    func get(by id: String, _ type: Object.Type) -> Object? {
        let results = realm?.objects(type).filter("id = '\(id)'")
        print("\(type.description): getting realm object is done")
        return results?.first
    }

    func getAll(_ type: Object.Type) -> Results<Object>? {
        let results = realm?.objects(type)
        print("\(type.description): getting realm objects is done")

        return results
    }

    func store(_ object: Object) -> Bool {
        do {
            try realm?.write {
                realm?.add(object, update: true)
                print("store is completedv: \(object.description)")
            }
            return true
        } catch let error {
            print("delete is error: \(error.localizedDescription)")
            return false
        }
    }

    func delete(_ object: Object) -> Bool {
        do {
            try realm?.write {
                realm?.delete(object)
                print("delete is completed: \(object.description)")
            }
            return true
        } catch let error {
            print("delete is error: \(error.localizedDescription)")
            return false
        }
    }

    func deleteAll() -> Bool {
        do {
            try realm?.write {
                realm?.deleteAll()
                print("deleteAll is completed")
            }
            return true
        } catch let error {
            print("delete is error: \(error.localizedDescription)")
            return false
        }
    }

    /// Realm初期化の際に前の状態をリセットするため、ダミーデータを突っ込む
    private func storeDummyData() {

    }
}
