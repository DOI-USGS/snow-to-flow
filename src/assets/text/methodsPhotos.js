// Field photos showing how USGS snow hydrologists measure SWE.
// Captions carry the photographer credit that previously lived in the
// alt text of each slide in ImgCarousel.

const jpgs = import.meta.glob('../methods/*.jpg', {
  eager: true,
  query: '?url',
  import: 'default'
});
const webps = import.meta.glob('../methods/*.webp', {
  eager: true,
  query: '?url',
  import: 'default'
});

function photo(id, name, text) {
  return {
    id,
    jpg: jpgs[`../methods/${name}.jpg`],
    webp: webps[`../methods/${name}.webp`],
    alt: text,
    title: text
  };
}

export default [
  photo(
    'field1',
    'person1',
    'USGS Research Hydrologist Graham Sexstone completes snowpit measurement at Buffalo Pass, CO. Photographer: Colin Penn.'
  ),
  photo(
    'field2',
    'drone1',
    'USGS scientists flying UAS near Winter Park, CO under a DOI readiness waiver. Lidar and photogrammetry were used to map snow depth. Photographer: Mark Bauer'
  ),
  photo(
    'field3',
    'person2',
    'USGS Research Hydrologist Graham Sexstone measures the snow depth at Molas Pass, CO. Photographer: Joe Mills'
  ),
  photo(
    'field4',
    'station4',
    'USGS Next Generation Water Observing System (NGWOS) snow test bed site (Ranch Creek Meadow) in Winter Park, Colorado shown recording snow water equivalent, snow depth, soil moisture, and other meteorological variables. Photographer: Graham Sexstone'
  ),
  photo(
    'field6',
    'station2',
    'NRCS SNOTEL site (Lake Irene, CO) shown recording snow water equivalent, snow depth, and other meteorological variables. Photographer: Graham Sexstone'
  ),
  photo(
    'field7',
    'person4',
    'USGS scientists Graham Sexstone and Colin Penn collecting a snow sample to analyze for snow chemistry in Rocky Mountain National Park, CO. Photographer: Garrett Akie.'
  ),
  photo(
    'field8',
    'station3',
    'USGS snow monitoring site (Loch Vale – Andrews Meadow) in Rocky Mountain National Park, Colorado shown recording snow sublimation and other meteorological variables. Photographer: Graham Sexstone'
  ),
  photo(
    'field9',
    'person3',
    'USGS Hydrologist Colin Penn measures the snow density and snow temperature of the snowpack at Noisy Basin, MT. Photographer: Evan Gohring'
  )
];
