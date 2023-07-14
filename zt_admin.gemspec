# frozen_string_literal: true

require_relative "lib/zt_admin/version"

Gem::Specification.new do |spec|
  spec.name = "zt_admin"
  spec.version = ZtAdmin::VERSION
  spec.authors = ["Zhenya Telyukov"]
  spec.email = ["telyukov@gmail.com"]

  spec.summary = %q{Admin BackEnd Generator for RoR 7 App}
  spec.description = %q{Tool to generate Admin controllers, helpers and views for a Model}
  spec.homepage = "http://dummy.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir        = "bin" #"exe"
  spec.executables   = ["zt_admin"] #spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
