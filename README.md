# EmojiKit
EmojiKit is a simple emoji-querying framework in Swift. It is used in [Paste](https://github.com/dasmer/Paste), an Emoji Search app in the [App Store](https://itunes.apple.com/us/app/paste-emoji-search/id1070640289).

Installation
------------
If you’re using [Carthage](http://github.com/Carthage/Carthage), add EmojiKit to your `Cartfile`:

```swift
github "dasmer/EmojiKit"
```

Otherwise, if you're using [Cocoapods](http://cocoapods.org), add EmojiKit to your `Podfile`:

```ruby
pod 'EmojiKit', '~> 0.0.1'
```

Usage
-----
##### 1. Create an EmojiFetcher instance variable.
```
let fetcher = EmojiFetcher()
```
##### 2. Use EmojiFetcher's `query` function to get an array of `Emoji` structs that match the given search string.
```
  fetcher.query("food") { emojiResults in
      // Use emojiResults
  }
```

Contributing
------------

The best way to contribute is by submitting a pull request. You can also submit a [new Github issue](https://github.com/dasmer/EmojiKit/issues/new) if you find bugs or have questions. :octocat:

Please make sure to follow the general coding style and add test coverage for new features!
