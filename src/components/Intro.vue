<template>
  <!---VizSection-->
  <VizSection
    id="intro"
    :figures="false"
    :fig-caption="false"
  >
    <!-- TAKEAWAY TITLE -->
    <template v-slot:takeAway>
      <h2>Almost 70% of water in the west comes from snowmelt.</h2>
    </template>
    <template v-slot:aboveExplanation>
      <p>So with warmer, shorter winters, what does that mean for water availability?</p>
      <p>Taleggio cheese strings manchego. Cheese strings queso when the cheese comes out everybody's happy pecorino say cheese when the cheese comes out everybody's happy blue castello boursin. Brie blue castello cauliflower cheese paneer goat edam cut the cheese bavarian bergkase. Roquefort mozzarella squirty cheese airedale cauliflower cheese cream cheese goat goat. Lancashire cheese slices smelly cheese smelly cheese.</p>
    </template>
    <!-- EXPLANATION -->
    <template v-slot:belowExplanation>
      <p>Parmesan cheeseburger emmental. Monterey jack dolcelatte stinking bishop paneer croque monsieur manchego airedale squirty cheese. The big cheese mozzarella red leicester port-salut the big cheese cheeseburger queso cheesy grin. Boursin babybel.</p>
    </template>
  </VizSection>
</template>
<script>
import VizSection from '@/components/VizSection';
export default {
    name: "Intro",
    components:{
        VizSection
    }
}
</script>
<style lang="scss" scoped>
</style>