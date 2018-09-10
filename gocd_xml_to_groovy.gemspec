
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gocd_xml_to_groovy/version"

Gem::Specification.new do |spec|
  spec.name          = "gocd_xml_to_groovy"
  spec.version       = GocdXmlToGroovy::VERSION
  spec.authors       = ["Ketan Padegaonkar"]
  spec.email         = ["KetanPadegaonkar@gmail.com"]

  spec.summary       = %q{Converts GoCD XML configuration to the groovy DSL configuration.}
  spec.description   = %q{Converts GoCD XML configuration to the groovy DSL configuration.}
  spec.homepage      = "https://github.com/ketan/gocd_xml_to_groovy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', '0.20.0'
  spec.add_dependency 'hashie', '3.6.0'
  spec.add_dependency "activesupport", "~> 5.2"
  spec.add_dependency "tilt", "~> 2.0"
  spec.add_dependency "erubis", "~> 2.7"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.11"
  spec.add_development_dependency "pry-state", "~> 0.1"
end
