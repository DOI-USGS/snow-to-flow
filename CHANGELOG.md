# Changelog

## Unreleased

v2.0.0

Migration to Vue 3 and the water.usgs.gov/vizlab domain.

### Added

- Vizlab authorship section with published and last-updated dates
- In-text citation numbers link to their entries in the References section
- USWDS government banner, and site-wide notices driven by the shared `status.json`
- Centered, equal-height photo carousel for the measuring-snowpack section, and an in-house carousel with an accessible lightbox for the snow-year diagrams
- Changelog entries for this release

### Changed

- Switched from Vue 2 to Vue 3 (`<script setup>`), from Vue CLI to Vite, and to Pinia for shared state
- Moved the site from labs.waterdata.usgs.gov/visualizations to water.usgs.gov/vizlab, and updated links and metadata to match
- Adopted the vue3-template header, footer, prefooter, and stylesheet structure while keeping the site's own palette and fonts
- Switched analytics to the shared Vizlab Google Analytics property
- Larger hero title and section titles, sans-serif hero subtitle, lighter image overlays (contrast kept at 4.5:1 or better), and more space below section images
- The SNOTEL mini charts keep showing the last hovered site until a new one is hovered
- Removed the Jenkins and Docker build files, and dropped unused dependencies

### Fixed

- Ridgeline chart hover no longer leaves lines stuck or highlights several sites at once
- Restored the axes and labels on the current-year SWE chart
- Methods text is back to body size
- A collapsed sidebar no longer blocks clicks on the text below it
- Corrected the structured data (JSON-LD) block in `index.html`, which was not valid JSON

## April 30, 2021

v1.0.3

Clean splash - removed people from images on splash

## April 28, 2021

v1.0.2

Mobile images fix: Merged pull request to omit people in images on mobile

## April 27, 2021

v1.0.1 (and v1.0.0)

Public release

## April 22, 2021

v0.2.4

Beta Release for EC Review with Pull Limit Fix. This release includes a few more bug fixes, especially ones that help us get around the Docker pull rate limit so that Jenkins will build.

## April 21, 2021

v0.2.3

Beta Release for EC Review

## April 8, 2021

v0.2.2

Release for IPDS Review

## March 30, 2021

v0.2.0

Beta Release for Text Review: This release includes code and text edits up to March 30th. There is still lots of refining to do, but we wanted to see all the pieces together as a whole to assess the revisions needed from here.

## March 11, 2021

Pre-Release v0.0.2

Purpose: First release as a test site with placeholder images. 
