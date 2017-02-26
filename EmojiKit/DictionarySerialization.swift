//
//  DictionarySerialization.swift
//  EmojiKit
//
//  Created by Dasmer Singh on 12/22/15.
//  Copyright © 2015 Dastronics Inc. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: Any]

public protocol DictionaryDeserializable {
    init?(dictionary: JSONDictionary)
}

public protocol DictionarySerializable {
    var dictionary: JSONDictionary { get }
}
