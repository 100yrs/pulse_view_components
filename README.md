# Polaris ViewComponents

Pulse ViewComponents is an implementation of the Pulse Design System using [ViewComponent](https://github.com/github/view_component).

The implementation borrows heavily from [Primer ViewComponents](https://github.com/primer/view_components) and [Polaris ViewComponents](https://github.com/baoagency/polaris_view_components).

This is still a work in progress and breaking changes may occur.

## Usage

Render Pulse ViewComponents:

```erb
<%= render(Pulse::Badge.new(scheme: :primary)) { 'Primary' } %>
```

## Dependencies

- [Stimulus](https://stimulus.hotwired.dev/)

## Installation

Add `pulse_view_components` to your Gemfile:

```bash
bundle add pulse_view_components
```

Add stylesheet and javascript links to your application layout:

```erb
<%= stylesheet_link_tag 'pulse_view_components' %>
<%= javascript_include_tag 'pulse_view_components' %>
<%= javascript_include_tag 'js/pulse_view_components', 'data-turbo-track': 'reload', defer: true %>
```

<!-- Run installer:
```bash
bin/rails pulse_view_components:install
``` -->

## Development

To get started:

1. Run: `bundle install`
1. Run: `yarn install`
1. Run: `bin/dev`

It will open demo app with component previews on `localhost:4000`. You can change components and they will be updated on page reload. Component previews are located at `/previews`.

To run tests:

```bash
rake
```

## Releases

The library follows [semantic versioning](https://semver.org/). To draft a new release you need to run `script/release` with a new version number:

```bash
bin/release VERSION
```

Where the VERSION is the version number you want to release. This script will update the version in the gem and push it to GitHub and Rubygems automatically.

<!-- To release a new version of npm package update the package.json file with the new version number and run:

```bash
npm run release
```

After that make sure to commit changes in package.json. -->

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).