# Changelog

All notable changes to this project are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
While the major version is `0`, a minor bump may carry a breaking change.

## [Unreleased]

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
