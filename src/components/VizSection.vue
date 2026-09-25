<template>
  <section class="vizSection">
    <div class="vizSectionContent">
      <div
        v-if="takeAway"
        class="takeAway"
      >
        <slot name="takeAway">
          <!--    Take Away Title -->
        </slot>
      </div>
      <div class="aboveExplanation explanation">
        <slot name="aboveExplanation" />
      </div>
      <div
        v-if="figures"
        class="figures"
      >
        <slot name="figures">
          Figure(s)
        </slot>
      </div>
      <div
        v-if="figCaption"
        class="figureCaption"
      >
        <slot name="figureCaption">
          Figure Caption
        </slot>
      </div>
      <div class="belowExplanation explanation">
        <slot name="belowExplanation" />
      </div>
    </div>
  </section>
</template>

<script setup>
  defineProps({
    takeAway:{
      type: Boolean,
      default: true
    },
    figCaption:{
      type: Boolean,
      default: true
    },
    figures:{
      type: Boolean,
      default: true
    }
  })
</script>
