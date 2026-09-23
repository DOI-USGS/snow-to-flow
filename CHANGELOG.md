# Change Log
All notable changes to this project will be documented in this file.
 
The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).
 
## [Unreleased]
 
Here we track upcoming changes.
 
## [2.0.0] - 2026-09-23
 
### Added
- Added a change log in the Vizlab template format
- Vizlab authorship section with published and last-updated dates
- In-text citations link to the References section
- USWDS government banner and site-wide notices from the shared `status.json`
- Centered, equal-height photo carousel for the measuring snowpack section
- Site picker for the SNOTEL map, and keyboard access to the chart toggles
 
### Changed
- Updated dependencies; switch from Vue 2 to Vue 3 and composition API
- Switched the build from Vue CLI to Vite, and to Pinia for state
- Site moved to the water.usgs.gov/vizlab domain; updated links and metadata to match
- Adopted the vue3-template header, footer, prefooter, and CSS structure, keeping the site's palette and fonts
- Switched analytics to the shared Vizlab Google Analytics property
- Replaced the Vue 2 carousels with an in-house carousel and lightbox
- Larger hero and section titles, sans-serif subtitle, and lighter image overlays
- SNOTEL mini charts keep the last hovered site until a new one is hovered
- Removed Jenkins and Docker build files and unused dependencies
- README rewritten for this site
- Vizlab template 404 page
- Bold, consistently sized chart toggle buttons
- Shared styles consolidated into `assets/css`; dead CSS removed
- Methods accordion no longer loads the full USWDS stylesheet
- Hero and section images served as WebP sized to the screen
- Unused images, video, and data moved out of the repo
 
### Fixed
- Ridgeline hover leaving lines stuck or several sites highlighted
- Missing axes on the current-year SWE chart
- Methods text rendering too small
- Collapsed sidebar blocking clicks on the text below it
- Invalid structured data (JSON-LD) block in `index.html`
- Bold emphasis lost in the migration
- SNOTEL legend drawn three times
- Sidebars invisible when mounted after page load
- Overlapping hero parallax breakpoints
- Duplicate element ids and missing section image alt text
- Carousel lightbox not centered
- Typos in copy and references
- Outdated links updated to their current addresses (NRCS, USGS, pubs.usgs.gov, DOI-USGS GitHub)
 
## [1.0.3] - 2021-04-30
 
### Changed
- Clean splash: removed people from images on splash
 
## [1.0.2] - 2021-04-28
 
### Fixed
- Mobile images: omit people in images on mobile
 
## [1.0.1] - 2021-04-27
 
### Added
- Public release (also tagged 1.0.0)
 
## [0.2.4] - 2021-04-22
 
### Fixed
- Beta release for EC review with fixes to get around the Docker pull rate limit so Jenkins builds
 
## [0.2.3] - 2021-04-21
 
### Added
- Beta release for EC review
 
## [0.2.2] - 2021-04-08
 
### Added
- Release for IPDS review
 
## [0.2.0] - 2021-03-30
 
### Added
- Beta release for text review, with code and text edits up to March 30
 
## [0.0.2] - 2021-03-11
 
### Added
- First pre-release as a test site with placeholder images
