Pod::Spec.new do |s|
  s.name = 'EmojiKit'
  s.version = '0.0.2'
  s.license = 'MIT'
  s.summary = 'Effortless emoji-querying in Swift'
  s.homepage = 'https://github.com/dasmer/EmojiKit'
  s.author = 'Dasmer Singh'
  s.source = { :git => 'https://github.com/dasmer/EmojiKit.git', :tag => s.version }
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.source_files = 'EmojiKit/*.swift'
  s.resources = 'AllEmoji.json'
  s.requires_arc = true
end
