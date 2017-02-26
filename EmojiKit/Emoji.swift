//
//  Emoji.swift
//  EmojiKit
//
//  Created by Dasmer Singh on 12/20/15.
//  Copyright © 2015 Dastronics Inc. All rights reserved.
//

public struct Emoji: Equatable {

    public let name: String
    public let character: String
    internal let aliases: [String]
    internal let groups: [String]

    public var ID: String {
        // There will never be more that 1 emoji struct for a given character,
        // so we can use the character itself to represent the unique ID
        return character
    }
}

extension Emoji: DictionaryDeserializable, DictionarySerializable {

    public init?(dictionary: JSONDictionary) {
        guard let name = dictionary["name"] as? String,
            let character = dictionary["character"] as? String,
            let aliases = dictionary["aliases"] as? [String],
            let groups = dictionary["groups"] as? [String] else { return nil }

        self.name = name
        self.character = character
        self.aliases = aliases
        self.groups = groups
    }

    public var dictionary: JSONDictionary {
        return [
            "name": name,
            "character": character,
            "aliases": aliases,
            "groups": groups
        ]
    }
}


extension Emoji: Hashable {

    public var hashValue: Int {
        return ID.hashValue
    }
}


public func ==(lhs: Emoji, rhs: Emoji) -> Bool {
    return lhs.ID == rhs.ID
}
