# Pulse ViewComponents

Pulse ViewComponents is an implementation of the future Pulse Design System using [ViewComponent](https://github.com/github/view_component).

The implementation borrows heavily from [Primer ViewComponents](https://github.com/primer/view_components) and [Polaris ViewComponents](https://github.com/baoagency/polaris_view_components).

This is still a work in progress and breaking changes may occur. Currently this requires Ruby 3.4 and Rails 8.1.

## Usage

Render Pulse ViewComponents:

```erb
<%= render(Pulse::Badge.new(scheme: :primary)) { 'Primary' } %>
```

## Component status

Each component declares how complete it is. Check it with
`Pulse::ActionList.status`. Lookbook shows the status after the name of any
component that is not stable.

| Status | Meaning |
| --- | --- |
| `stable` | Complete and safe to use. |
| `beta` | Core usage works. Some documented options are not implemented. |
| `alpha` | Incomplete. Features may be broken, unstyled or missing, and the API may change without notice. |
| `deprecated` | Scheduled for removal. |

Components that are not stable:

| Component | Status | Gaps |
| --- | --- | --- |
| `ActionList` | alpha | Select variants, trailing actions, tooltips, avatar items and the `:inset` scheme do not work. |
| `NavList` | alpha | Avatar items raise. Sub-items cannot be collapsed. The show-more item has no JavaScript. |
| `Counter` | alpha | Renders unstyled. |
| `BorderBox` | beta | `padding:` and row `scheme:` have no effect. |
| `Flash` | beta | `dismissible: true` raises. `full: true` has no effect. |

The comment above each `status` call in the source lists what is missing.

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
