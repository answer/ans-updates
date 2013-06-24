# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ans-updates/version'

Gem::Specification.new do |gem|
  gem.name          = "ans-updates"
  gem.version       = Ans::Updates::VERSION
  gem.authors       = ["sakai shunsuke"]
  gem.email         = ["sakai@ans-web.co.jp"]
  gem.description   = %q{更新情報の取得、整形を行う}
  gem.summary       = %q{更新情報リポジトリを外部に用意して、そこから更新情報を読みだして html に整形するヘルパーを提供する}
  gem.homepage      = "https://github.com/answer/ans-updates"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "redcarpet"
end
