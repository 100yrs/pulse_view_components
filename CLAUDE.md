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
yarn build:css                   # tailwind 4 CLI -> app/assets/builds/pulse_view_components.css
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

Every component declares `status :alpha | :beta | :stable | :deprecated` (see
`app/lib/pulse/status.rb`). Unmarked components default to `:alpha`. Mark a
component `:stable` only when every option works with Tailwind classes. Primer
class names such as `ActionListItem--danger` or `Box--condensed` are a sign it
is not: no CSS in the build defines them. A non-stable component carries its
status in its preview's `@label` (`# @label Counter (alpha)`), and
`status_spec.rb` fails if the two disagree. Keep the README status table in
step as well.

## Tailwind

The gem uses Tailwind 4 with CSS-first configuration. There is no
`tailwind.config.js`. The theme, sources and plugins all live in
`app/assets/stylesheets/pulse_view_components/application.tailwind.css`.
Tailwind 4 needs Node 20 or later (`.nvmrc` pins 22).

Every utility carries the `pulse` prefix, written as a leading variant:
`pulse:bg-primary`, `pulse:hover:text-white`, `pulse:sm:px-4`. The prefix
always comes first, before any other variant. It is set by
`@import "tailwindcss" prefix(pulse)` and by the `TailwindMerge::Merger`
config in `component.rb` (`prefix: 'pulse'`, no dash). The two must stay in step.

Theme variables are declared unprefixed in `@theme` (`--color-primary`) and
emitted prefixed (`--pulse-color-primary`). Reference the prefixed name from
plain CSS and arbitrary values.

`source(none)` turns off automatic source detection, so only the `@source`
paths are scanned. Add a path there if components start using classes from a
new directory. Capybara selectors must escape the colon:
`have_css('.pulse\:text-sm')`.

Semantic color names (`primary`, `secondary`, `tertiary`, `success`, `danger`,
`error`, `neutral`) map onto the named palettes in
`tokens.system.css`. The palettes are `--palette-*` variables, so they have no
utility classes and every color class goes through a semantic name. Use
`neutral` for greys. Tailwind's own `gray` is switched off. The Foundations >
Colors page in Lookbook shows every token.

## Adding a component

1. `app/components/pulse/thing.rb`, plus `thing.html.slim` if it needs markup.
2. `previews/pulse/thing_preview.rb` with a `default` playground method. Use
   `@param x select {{ Pulse::Thing::X_OPTIONS }}` annotations to expose knobs.
3. `spec/components/pulse/thing_spec.rb`, tagged `type: :component`, using
   `render_inline` and Capybara matchers.
4. Restart `bin/dev` if you added a Stimulus controller, since the glob is
   resolved at build time.

## Gotchas

- The sidecar `.css` files under `app/components/pulse/` (`counter.css`,
  `layout.css`, `action_list.css`) are not imported anywhere, so their rules do
  not reach the built stylesheet. They still use the Tailwind 3 `pulse-` class
  syntax in `@apply`. Put styles in the component's Tailwind classes instead.
- `app/assets/builds/` is committed. Rebuild and commit it when JS or CSS changes.
- RuboCop inherits a remote config from the `100yrs/code-style-guides` repo, which
  needs network access on first run.
