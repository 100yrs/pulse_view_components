# Changelog

All notable changes to this project are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
While the major version is `0`, a minor bump may carry a breaking change.

## [Unreleased]

### Added

- Components declare a status of `:alpha`, `:beta`, `:stable` or
  `:deprecated`, read with `Pulse::Thing.status`. `ActionList`, `NavList` and
  `Counter` are alpha. `BorderBox` and `Flash` are beta. See the README for
  what each level means.
- An `ActionList` Lookbook preview.

### Fixed

- `ActionList`, `ActionList::Heading` and every `NavList` group raised on
  render because they had no template.
- `NavList` items with sub-items raised, and their sub-items never rendered.
- `BorderBox` rendered a `system_arguments_denylist` HTML attribute.
  `BaseComponent` now consumes the denylist and raises outside production when
  a denied argument is passed, so `BorderBox.new(pt: 2)` now raises.
- `Forms::ErrorExplanation` rendered "Header" as its heading unless the app
  defined `errors.template.header`. It now ships a default heading and still
  prefers the app's translation.

### Changed

- `Forms::ErrorExplanation` now inherits from `Pulse::Component`. It merges
  `classes:` with `tailwind_merge` and rejects a `tag:` argument.
- **Breaking:** upgraded to Tailwind CSS 4. The class prefix is now written as
  a leading variant, so `pulse-bg-primary` becomes `pulse:bg-primary` and
  `hover:pulse-text-white` becomes `pulse:hover:text-white`. Classes passed to
  components through `classes:` must use the new form.
- Some utilities were renamed by Tailwind 4 (`outline-none` is now
  `outline-hidden`, `start-0` is now `inset-s-0`).
- CSS custom properties from the theme are now emitted with the prefix, for
  example `--pulse-color-primary`.
- `tailwind_merge` dependency raised to `~> 1.5`, which understands Tailwind 4
  class syntax.
- The Tailwind config moved from `tailwind.config.js` into the stylesheet as
  CSS-first configuration.

### Removed

- `@tailwindcss/aspect-ratio` and `@tailwindcss/typography`, which no component
  used. `aspect-*` utilities are built into Tailwind 4.
- The unused `peer-unchecked` variant. Tailwind 4's `peer-not-checked` covers
  it.
- `postcss.config.js`, `postcss` and `autoprefixer`. The Tailwind 4 CLI does
  not read the PostCSS config.

### Internal

- Development Node moved to 22, since Tailwind 4 needs Node 20 or later.
- `chokidar` is now a direct dev dependency. `esbuild.config.mjs` imports it,
  and it previously arrived only through Tailwind 3.

## [0.3.0] - 2026-08-28

No breaking changes. The component API, the gemspec constraints and the
`pulse-` Tailwind prefix are all unchanged from 0.2.1.

### Changed

- Rebuilt the shipped JS bundle with esbuild 0.28, which pulls in Turbo 8.0.23
  (was 8.0.4) and `@rails/request.js` 0.0.13 (was 0.0.9).
- Development Ruby moved to 3.4.10. The gem still supports Ruby >= 3.4.0.
- Development gems updated: `view_component` 4.15, `puma` 8.0, `rake` 13.4,
  `listen` 3.10.
- CI moved from CircleCI to GitHub Actions.

### Fixed

- `bin/release` no longer reads a zero-padded version segment as an octal Ruby
  literal, so `bin/release 0.3.09` writes a valid `version.rb`.

### Internal

- RuboCop config refreshed against `100yrs/code-style-guides`, added
  `rubocop-thread_safety`, and reformatted the affected components.
- Coverage pragmas switched from `# :nocov:` to
  `# simplecov:disable` / `# simplecov:enable`.
- `Pulse::FetchOrFallbackHelper::InvalidValueError` is declared as a class
  rather than assigned from `Class.new`.
- Added `CLAUDE.md`.

## [0.2.1] - 2026-01-14

### Changed

- Demo app gems updated.
- Tidying across components.

## [0.2.0] - 2026-01-12

### Changed

- **Breaking:** requires Ruby >= 3.4.0 (was 3.2.0), Rails >= 8.1.0 and
  `view_component` 4.x.
- **Breaking:** dropped the `turbo_power` dependency and the custom Turbo Stream
  actions registered from `app/javascript`. Applications relying on those
  actions must register them themselves.

### Fixed

- `tailwind_merge` performance in `merge_classes`.

### Added

- Missing component specs and Lookbook previews.

## [0.1.1] - 2024-11-14

### Added

- More icons, and an optional visual icon for buttons.
- `info` scheme for `Pulse::Badge`.
- `app/components` added to the autoload path.

### Changed

- Modal tracks the last focused element on open.
- Table style tweaks; scroll value is now optional and overflow is no longer
  hidden.

## [0.1.0] - 2024-03-04

- Initial release.

[Unreleased]: https://github.com/100yrs/pulse_view_components/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/100yrs/pulse_view_components/compare/v0.2.1...v0.3.0
[0.2.1]: https://github.com/100yrs/pulse_view_components/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/100yrs/pulse_view_components/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/100yrs/pulse_view_components/releases/tag/v0.1.1
[0.1.0]: https://github.com/100yrs/pulse_view_components/releases/tag/v0.1.0
