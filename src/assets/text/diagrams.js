// Seasonal watershed diagrams, grouped by snow year type.
// Captions are the lightbox titles that were previously inline in the
// DiagramCarousel* components.

const jpgs = import.meta.glob('../diagrams/*.jpg', {
  eager: true,
  query: '?url',
  import: 'default'
});
const webps = import.meta.glob('../diagrams/*.webp', {
  eager: true,
  query: '?url',
  import: 'default'
});

function image(name) {
  return {
    jpg: jpgs[`../diagrams/${name}.jpg`],
    webp: webps[`../diagrams/${name}.webp`]
  };
}

export default {
  typical: [
    {
      id: 'diagram-normal-winter',
      ...image('Diagram_typical-winter'),
      alt: 'Diagram of a mountain watershed covered in snow in winter',
      title: 'A Typical Winter: Soil saturation sets the stage for the coming snow season - whether the prior year was wet or dry determines soil saturation for the current year. Around October, snow begins to fall and SWE begins to accumulate. Especially at high elevations, the snowpack can be several feet thick and store several inches of water (SWE).'
    },
    {
      id: 'diagram-normal-spring',
      ...image('Diagram_typical-spring'),
      alt: 'Diagram of a mountain watershed covered in snow in early spring',
      title: 'A Typical Spring: At some point, snowpack SWE reaches its peak and then begins to decline as the snow begins to melt. The date of peak SWE marks the beginning of the melt timing, and the melt duration is the time required for one-half of the peak SWE to melt (SM50).'
    },
    {
      id: 'diagram-normal-summer',
      ...image('Diagram_typical-summer'),
      alt: 'Diagram of a mountain watershed covered in snow in late spring',
      title: 'A Typical Summer: During the melt season, infiltration of meltwater increases soil saturation and runoff to streams. Streamflow often peaks in the early summer in response to spring snowmelt, filling streams with a surge of water that can be captured by downstream diversions or in reservoirs. For many places in the Western U.S., spring snowmelt composes the majority of the annual water budget.'
    }
  ],
  high: [
    {
      id: 'diagram-high-winter',
      ...image('Diagram_high-winter'),
      alt: 'A diagram of a watershed with snowy mountain tops.',
      title: 'A High Snow Winter: If soils are well saturated from the previous year, and winter snow accumulation is high, the stage is set for a year with ample meltwater availability.'
    },
    {
      id: 'diagram-high-spring',
      ...image('Diagram_high-spring'),
      alt: 'Diagram of a mountain watershed covered in snow in early spring',
      title: 'A High Snow Spring: In a high snow year, SWE continues to accumulate late into the spring in response to continued snowfall and cold temperatures. Usually, high SWE goes hand-in-hand with a late onset of melt because both can result from cold spring temperatures. The later peak snowpack occurs, the more likely it is that the snow will melt all at once in a rapid surge.'
    },
    {
      id: 'diagram-high-summer',
      ...image('Diagram_high-summer'),
      alt: 'Diagram of a mountain watershed covered in snow in the summer.',
      title: 'A High Snow Summer: A lot of snow combined with well-saturated soils and late melt timing can result in a large surge of streamflow as temperatures warm. High runoff in the spring can cause flooding and streamflow may be sustained throughout the summer.'
    }
  ],
  low: [
    {
      id: 'diagram-low-winter',
      ...image('Diagram_low-winter'),
      alt: 'Diagram of a mountain watershed covered in snow in winter',
      title: 'A Low Snow Winter: If winter temperatures remain above freezing during precipitation events, or if there is not much precipitation at all, SWE accumulation in a given location can be quite low compared to other years. '
    },
    {
      id: 'diagram-low-early-spring',
      ...image('Diagram_low-spring'),
      alt: 'Diagram of a mountain watershed covered in snow in spring',
      title: 'A Low Snow Spring: Warming winters can mean that there is not much snow accumulation. If those years also face an early, warm spring, the snowmelt season releases meltwater slowly and gradually, and there may not be a spring streamflow peak. Melting in this way means that the slow trickle of melt can be absorbed by the soil, which slows down meltwater on its journey over and through the soil towards streams.'
    },
    {
      id: 'diagram-normal-late-summer',
      ...image('Diagram_low-summer'),
      alt: 'Diagram of a mountain watershed covered in snow in summer',
      title: 'A Low Snow Summer: Snowpack melts earlier and streamflow is diminished compared to high-snow conditions. Summer streamflow will be low, and downstream reservoirs may only receive a fraction of their usual water budget.'
    }
  ]
};
