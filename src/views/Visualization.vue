<template>
  <div id="visualization">
    <Test />
  </div>
</template>

<script>
   import Test from '@/components/TestFigure';
    export default {
        name: 'Visualization',
        components: {
          Test
        }
    }
</script>

<style lang="scss">
SWE {
  z-index: 1;
}
</style>
