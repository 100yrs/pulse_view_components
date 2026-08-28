# CLAUDE.md

Guidance for Claude Code working in this repository.

## What this is

`pulse_view_components` is a Rails engine gem packaging the 100Years Pulse Design
System as [ViewComponent](https://github.com/ViewComponent/view_component) classes.
Patterns are borrowed from Primer ViewComponents and Polaris ViewComponents.

Requires Ruby 3.4+ and Rails 8.1+. Components are namespaced under `Pulse::`.

## Commands

```bash
bundle install && yarn install   # setup
bin/dev                          # Lookbook previews on localhost:4000, plus js/css watchers
rake                             # default task: rspec then rubocop
bundle exec rspec                # tests only
bundle exec rspec spec/components/pulse/badge_spec.rb
bundle exec rubocop -A           # lint with autocorrect
yarn build                       # esbuild JS bundle -> app/assets/builds/js
yarn build:css                   # tailwind -> app/assets/builds/pulse_view_components.css
bin/release VERSION              # tag, build, push gem to Rubygems
```

`rspec` runs with `fail_fast = true` and random ordering, so a run stops at the
first failure.

## Layout

- `app/components/pulse/` — components. A component is a `.rb` class plus an
  optional sidecar `.html.slim` template, `_controller.js` Stimulus controller,
  and `.yml` translations. Sub-components live in a matching subdirectory
  (`nav_list/item.rb` → `Pulse::NavList::Item`).
- `app/lib/pulse/` — helper modules mixed into `Pulse::Component`.
- `app/javascript/` — esbuild entry point; Stimulus controllers are auto-registered
  by globbing `app/components/**/*_controller.js`.
- `previews/pulse/` — Lookbook previews, one per component. These ship in the gem.
- `spec/components/pulse/` — component specs.
- `demo/` — a Rails app that mounts Lookbook and loads the gem via `path: '../'`.
  Specs boot this app through `spec/rails_helper.rb`.
- `lib/pulse/view_components/` — gem entry point, engine, version.

## Component conventions

Inherit from `Pulse::Component`, which supplies `merge_classes`,
`merge_attributes`, `merge_aria`, `merge_data`, `fetch_or_fallback`, and
`render_svg`.

Options follow the Primer style: a `DEFAULT_X` constant, an `X_MAPPINGS` hash of
symbol to Tailwind classes, and `X_OPTIONS` derived from the mapping keys. Coerce
incoming values with `fetch_or_fallback(X_OPTIONS, x, DEFAULT_X)` — it raises
outside production and falls back quietly in production.

Extra keyword arguments are collected as `**system_arguments` and forwarded to
`Pulse::BaseComponent`, which wraps `content_tag`. Pass caller classes through
`merge_classes` so `tailwind_merge` resolves conflicts rather than concatenating.

```ruby
@system_arguments[:classes] = merge_classes(
  VARIANT_MAPPINGS[@variant],
  system_arguments[:classes]
)
```

Components with no template define `call`; ones with markup use a sidecar
`.html.slim` file. Use `render?` to suppress empty output.

`deny_tag_argument` and `deny_single_argument` reject arguments a component does
not support.

## Tailwind

Every utility class carries the `pulse-` prefix (`pulse-bg-primary`,
`hover:pulse-text-white`). The prefix is set in `tailwind.config.js` and in the
`TailwindMerge::Merger` config in `component.rb` — the two must stay in step.

Semantic color names (`primary`, `secondary`, `tertiary`, `success`, `danger`,
`error`) map onto the named palettes in `tailwind.config.js`. Prefer the semantic
name over the raw palette name.

CSS custom properties are declared in
`app/assets/stylesheets/pulse_view_components/application.tailwind.css`.

## Adding a component

1. `app/components/pulse/thing.rb`, plus `thing.html.slim` if it needs markup.
2. `previews/pulse/thing_preview.rb` with a `default` playground method. Use
   `@param x select {{ Pulse::Thing::X_OPTIONS }}` annotations to expose knobs.
3. `spec/components/pulse/thing_spec.rb`, tagged `type: :component`, using
   `render_inline` and Capybara matchers.
4. Restart `bin/dev` if you added a Stimulus controller, since the glob is
   resolved at build time.

## Gotchas

- `bin/release` overwrites `lib/pulse/view_components/version.rb` with a flat
  `VERSION = "x.y.z"` constant, but the codebase reads
  `Pulse::ViewComponents::VERSION::STRING` from a `MAJOR`/`MINOR`/`PATCH` module.
  Check the file after running it.
- The sidecar `.css` files under `app/components/pulse/` (`counter.css`,
  `layout.css`, `action_list.css`) are not imported anywhere, so their rules do
  not reach the built stylesheet. Put styles in the component's Tailwind classes
  instead.
- `app/assets/builds/` is committed. Rebuild and commit it when JS or CSS changes.
- RuboCop inherits a remote config from the `100yrs/code-style-guides` repo, which
  needs network access on first run.
- CI (`.circleci/config.yml`) still pins Ruby 3.3.0 while the gem requires 3.4.
