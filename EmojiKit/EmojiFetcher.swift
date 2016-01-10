//
//  Fetcher.swift
//  EmojiKit
//
//  Created by Dasmer Singh on 12/20/15.
//  Copyright © 2015 Dastronics Inc. All rights reserved.
//

import Foundation

public struct EmojiFetcher {

    // MARK: - Properties

    private let backgroundQueue: NSOperationQueue = {
        let queue = NSOperationQueue()
        queue.qualityOfService = .UserInitiated
        return queue
    }()


    // MARK: - Initializers

    public init() {}

    // MARK: - Functions

    public func query(searchString: String, completion: ([Emoji] -> Void)) {
        cancelFetches()

        if let emoji = EmojiFetchOperation.emojiDictionary[searchString] {
            dispatch_async(dispatch_get_main_queue()) {
                completion([emoji])
            }
        } else {
            let operation = EmojiFetchOperation(searchString: searchString)

            operation.completionBlock = {

                if operation.cancelled {
                    return;
                }

                dispatch_async(dispatch_get_main_queue()) {
                    completion(operation.results)
                }
            }

            backgroundQueue.addOperation(operation)
        }
    }

    public func cancelFetches() {
        backgroundQueue.cancelAllOperations()
    }

    public func isEmojiRepresentedByString(string: String) -> Bool {
        return EmojiFetchOperation.emojiDictionary[string] != nil
    }
}

private final class EmojiFetchOperation: NSOperation {

    static let allEmoji: [Emoji] = {
        guard let path = NSBundle(forClass: EmojiFetchOperation.self).pathForResource("AllEmoji", ofType: "json"),
            data = NSData(contentsOfFile: path),
            jsonObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
            jsonDictionaries = jsonObject as? [JSONDictionary] else { return [] }

        return jsonDictionaries.flatMap { Emoji(dictionary: $0) }
    }()

    static let emojiDictionary: [String: Emoji]  = {
        var dictionary = Dictionary<String, Emoji>(minimumCapacity:EmojiFetchOperation.allEmoji.count)
        EmojiFetchOperation.allEmoji.forEach {
            dictionary[$0.character] = $0
        }
        return dictionary
    }()


    // MARK: - Properties

    let searchString: String
    var results: [Emoji] = []


    // MARK: - Initializers

    init(searchString: String) {
        self.searchString = searchString
    }


    // MARK: - NSOperation

    override func main() {
        let lowercaseSearchString = self.searchString.lowercaseString
        let allEmoji = self.dynamicType.allEmoji
        guard !cancelled else { return }

        var results = [Emoji]()

        // Matches of the full names of the emoji
        results += allEmoji.filter { $0.name.hasPrefix(lowercaseSearchString) }
        guard !cancelled else { return }

        // Matches of individual words in the name
        results += allEmoji.filter { emoji in
            guard results.indexOf(emoji) == nil else { return false }

            var validResult = false

            let emojiNameWords = emoji.name.characters.split{$0 == " "}.map(String.init)

            for emojiNameWord in emojiNameWords {
                if emojiNameWord.hasPrefix(lowercaseSearchString) {
                    validResult = true
                    break
                }
            }
            return validResult
        }
        guard !cancelled else { return }

        // Alias matches
        results += allEmoji.filter { emoji in
            guard results.indexOf(emoji) == nil else { return false }

            var validResult = false

            for alias in emoji.aliases {
                if alias.hasPrefix(lowercaseSearchString) {
                    validResult = true
                    break
                }
            }

            return validResult
        }
        guard !cancelled else { return }

        // Group matches
        results += allEmoji.filter { emoji in
            guard results.indexOf(emoji) == nil else { return false }

            var validResult = false

            for group in emoji.groups {
                if lowercaseSearchString.hasPrefix(group) {
                    validResult = true
                    break
                }
            }

            return validResult
        }
        guard !cancelled else { return }

        self.results = results
    }
}
