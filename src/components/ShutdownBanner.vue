<template>
  <div
    class="usa-alert usa-alert--emergency"
    :class="{ 'usa-alert--slim': slim }"
    role="region"
    :aria-label="ariaLabel"
  >
    <div class="usa-alert__body">
      <h2
        v-if="heading"
        class="usa-alert__heading"
      >
        {{ heading }}
      </h2>
      <p class="usa-alert__text">
        {{ message }}
        <template v-if="linkUrl">
          For more information please visit:
          <a
            class="usa-link"
            :href="linkUrl"
            target="_blank"
            rel="noopener noreferrer"
          >{{ linkText }}</a>.
        </template>
      </p>
    </div>
  </div>
</template>

<script setup>
  // Site-wide emergency notice, e.g. a lapse in government funding.
  //
  // Built on the USWDS emergency alert, which is the design system's designated
  // pattern for time-sensitive, site-wide notices. It supplies the background
  // colour, icon, and an accessible link colour, so this component should not
  // restyle them - override the USWDS theme instead if the look needs to change.
  //
  // Presentation only - SiteNotice.vue decides whether this is shown and feeds
  // it content from the shared status file. Defaults cover the government
  // shutdown case, and apply to any field the status file leaves out.
  defineProps({
    message: {
      type: String,
      default: 'Due to a lapse in government funding, this website is not currently being updated.'
    },
    linkUrl: {
      type: String,
      default: 'https://www.doi.gov/shutdown'
    },
    linkText: {
      type: String,
      default: 'www.doi.gov/shutdown'
    },
    heading: {
      type: String,
      default: ''
    },
    // Compact variant - drops the icon and tightens the padding
    slim: {
      type: Boolean,
      default: false
    },
    // Names the landmark for screen reader users
    ariaLabel: {
      type: String,
      default: 'Site notice'
    }
  })
</script>

<style scoped lang="scss">
  /* Scoped USWDS import, matching HeaderUSWDSBanner.vue.

     While the tag in App.vue stays commented out this costs nothing - the
     unused binding is tree-shaken and none of this ships. Enabling the banner
     adds a second, separately-scoped copy of the USWDS sheet, which roughly
     doubles the main CSS chunk (722 kB -> 1,430 kB in this template). That is
     the accepted trade for keeping the alert styles sourced from USWDS rather
     than hand-copied. */
  @import '../../node_modules/@uswds/uswds/dist/css/uswds.css';

  .usa-alert__text {
    max-width: 60em;
  }
</style>
