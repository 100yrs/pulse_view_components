# frozen_string_literal: true

require_relative 'lib/pulse/view_components/version'

Gem::Specification.new do |spec|
  spec.name = 'pulse_view_components'
  spec.version = Pulse::ViewComponents::VERSION::STRING
  spec.authors = ['Nick Coyne']
  spec.email = ['nick@codevader.com']

  spec.summary = 'ViewComponents for the 100Years Pulse Design System'
  spec.homepage = 'https://github.com/100yrs/pulse_view_components'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage

  spec.files = Dir['lib/**/*', 'app/**/*', 'LICENSE.txt', 'README.md',
                   'previews/**/*']

  # spec.require_paths = ['lib']

  spec.add_runtime_dependency 'active_link_to', '>= 1.0.0'

  spec.add_runtime_dependency 'inline_svg', '>= 1.9.0'
  spec.add_runtime_dependency 'rails', '>= 7.0.0'
  spec.add_runtime_dependency 'tailwind_merge', ['>= 0.10.1', '< 1.0.0']
  spec.add_runtime_dependency 'view_component', ['>= 3.1', '< 4.0.0']

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
