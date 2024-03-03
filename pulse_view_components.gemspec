# frozen_string_literal: true

require_relative "lib/pulse_view_components/version"

Gem::Specification.new do |spec|
  spec.name = "pulse_view_components"
  spec.version = PulseViewComponents::VERSION
  spec.authors = ["Nick Coyne"]
  spec.email = ["nick@codevader.com"]

  spec.summary = "ViewComponents for the 100Years Pulse Design System"
  spec.homepage = "https://github.com/100yrs/pulse_view_components"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(__dir__) do
  #   `git ls-files -z`.split("\x0").reject do |f|
  #     (File.expand_path(f) == __FILE__) ||
  #       f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
  #   end
  # end
  # spec.files = Dir["CHANGELOG.md", "LICENSE.txt", "README.md", "lib/**/*", "app/**/*", "static/**/*", "previews/**/*"] - Dir["lib/**/*.rake"]
  # spec.files = Dir["lib/**/*", "app/**/*", "config/**/*", "LICENSE.txt", "README.md"]
  spec.files = Dir["lib/**/*", "app/**/*", "doc/**/*", "LICENSE.txt", "README.md"]

  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_runtime_dependency     "actionview", ">= 5.0.0"
  # spec.add_runtime_dependency     "activesupport", ">= 5.0.0"
  spec.add_runtime_dependency "rails", ">= 7.0.0"
  spec.add_runtime_dependency "view_component", [">= 3.1", "< 4.0.0"]


  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
