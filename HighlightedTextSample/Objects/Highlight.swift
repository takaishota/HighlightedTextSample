//
//  SearchWord.swift
//  HighlightedTextSample
//
//  Created by 高井　翔太 on 2018/05/23.
//  Copyright © 2018年 Medley, inc. All rights reserved.
//

import Foundation
import RealmSwift

class Highlight: Object {
    @objc dynamic var id = ""
    @objc dynamic var text = ""
    @objc dynamic var location = 0
    @objc dynamic var length = 0
    @objc dynamic var created = Date()

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience required init(_ text: String, location: Int, length: Int) {
        self.init()
        self.id = NSUUID().uuidString
        self.text = text
        self.location = location
        self.length = length
        self.created = Date()
    }
}
