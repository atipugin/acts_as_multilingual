lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'acts_as_multilingual/version'

Gem::Specification.new do |spec|
  spec.name          = 'acts_as_multilingual'
  spec.version       = ActsAsMultilingual::VERSION
  spec.authors       = ['Alexander Tipugin']
  spec.email         = ['atipugin@gmail.com']
  spec.summary       = 'Store multilingual columns in JSON'
  spec.homepage      = 'https://github.com/atipugin/acts_as_multilingual'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rubocop', '~> 0.35'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.3'
  spec.add_development_dependency 'sqlite3'

  spec.add_dependency 'activerecord', '>= 3.2'
end
