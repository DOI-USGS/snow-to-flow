<template>
  <section id="authors">
    <div class="text-content">
      <h1
        v-if="titleLevel === '1'"
        v-html="authors.title"
      />
      <h2
        v-if="titleLevel === '2'"
        v-html="authors.title"
      />
      <h3
        v-if="titleLevel === '3'"
        v-html="authors.title"
      />
      <p v-html="formatAuthorText(authors)" />
      <p
        v-if="authors.datePublished"
        class="byline"
      >
        Published <time :datetime="authors.datePublished">{{ formatDate(authors.datePublished) }}</time><span v-if="authors.dateModified && authors.dateModified !== authors.datePublished">. Last updated <time :datetime="authors.dateModified">{{ formatDate(authors.dateModified) }}</time></span>.
      </p>
    </div>
  </section>
</template>

<script setup>
  // define props
  defineProps({
    titleLevel: {
      type: String,
      default: "2"
    },
    authors: {
      type: Object,
      // Object or array defaults must be returned from
      // a factory function.
      default() {
        return {
          title: "USGS Vizlab",
          authorText: "",
          projectTeam: [],
          leadAuthors: [],
          additionalAuthors: [],
          lastAuthor: [],
          datePublished: "",
          dateModified: ""
        }
      }
    },
  })


  // Format an ISO date string (YYYY-MM-DD) as e.g. "April 27, 2021".
  // Parsed as local time (not UTC) so the day doesn't shift by timezone.
  function formatDate(isoDate) {
    const [year, month, day] = isoDate.split('-').map(Number);
    return new Date(year, month - 1, day).toLocaleDateString('en-US', {
      year: 'numeric', month: 'long', day: 'numeric'
    });
  }

  function createLink(data) {
    return data.link ? `<a href="${data.link}" target="_blank">${data.name}</a>` : data.name;
  }

  function formatAuthorText(data) {
    // Map placeholders to their replacement text
    const replacements = {
      "{projectTeam}": createLink(data.projectTeam[0]),
      "{leadAuthors}": data.leadAuthors.length > 2 ? `${data.leadAuthors.slice(0, data.leadAuthors.length - 1).map(createLink).join(', ')}, and ${data.leadAuthors.slice(-1).map(createLink)}` : data.leadAuthors.map(createLink).join(' and '),
      "{additionalAuthors}": data.additionalAuthors.map(createLink).join(', '),
      "{lastAuthor}": createLink(data.lastAuthor[0])
    };
    
    // Replace placeholders in the authorText
    return data.authorText.replace(/{\w+}/g, (match) => {
      return replacements[match] || match; // Return the replacement or the original text if not found
    });
  }

</script>

<style scoped lang="scss">
  .byline {
    margin-top: 1em;
    font-size: 0.85em;
    color: #5c5c5c;
  }
</style>
