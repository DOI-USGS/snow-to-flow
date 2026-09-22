<template>
  <section id="references">       
    <div class="text-content">
      <h2>References</h2>
      <div>
        <div
          v-for="reference in references.references"
          :key="reference.num"
        >
          <p>
            <span v-html="reference.num" />. <span v-html="reference.authors" /> (<span v-html="reference.year" />). <a
              :href="reference.link"
              target="_blank"
            ><span v-html="reference.title" /></a>
            <span v-if="reference.data_release">: U.S. Geological Survey data release</span>.
            <span v-if="reference.journal">
              <span
                class="journal-name"
                v-html="reference.journal_name"
              />
              <span v-if="reference.journal_issue">, {{ reference.journal_issue }}</span>.
            </span>
            <span
              v-if="reference.doi"
              v-html="reference.doi"
            />
            <span
              v-else
              v-html="reference.link"
            />
          </p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
  import references from "@/assets/text/references";
</script>

<style scoped lang="scss">
  .journal-name {
    font-style: italic;
  }
</style>