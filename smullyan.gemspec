# frozen_string_literal: true

require_relative 'lib/smullyan/version'

Gem::Specification.new do |spec|
  spec.name = 'smullyan'
  spec.version = Smullyan::VERSION
  spec.authors = ['Phil Crissman']
  spec.email = ['your-email@example.com']

  spec.summary = "A Ruby implementation of combinators from Raymond Smullyan's To Mock a Mockingbird"
  spec.description = "A Ruby gem implementing the combinatory logic birds from Raymond Smullyan's To Mock a Mockingbird"
  spec.homepage = 'https://github.com/philcrissman/smullyan'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Development dependencies
  spec.add_development_dependency 'minitest', '~> 5.18'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.50'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.31'
end
