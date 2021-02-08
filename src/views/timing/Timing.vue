<template>
    <section id="intro">
        <div id="header">
            <div class="text-content">
              <p>I love cheese, especially danish fontina cow. Cottage cheese lancashire bocconcini danish fontina cheeseburger queso croque monsieur manchego. Brie fondue edam stinking bishop taleggio parmesan lancashire bocconcini. Smelly cheese airedale cheesy feet babybel the big cheese say cheese.
                  <br><br>  Say cheese chalk and cheese gouda. Gouda cheesy grin cheesy grin pecorino boursin cheddar edam paneer. Halloumi fromage frais red leicester airedale edam melted cheese say cheese port-salut. Cheesy feet.
                <br><br>    Halloumi port-salut cheesecake. Blue castello croque monsieur emmental cheese slices red leicester cheese strings boursin red leicester. Danish fontina emmental caerphilly queso paneer edam when the cheese comes out everybody's happy emmental. Melted cheese monterey jack cheese on toast cheese strings emmental cheesecake feta monterey jack. Cheesy grin.</p>
            </div>
        </div>
    </section>
</template>

<script>
    export default {
        name: 'Intro',
        data() {
            return {
              title: process.env.VUE_APP_TITLE
            }
        },
        computed: {
            windowHeight: function () {
                const usgsBannerHeight = 85;
                return Number(this.$store.state.windowHeight - this.$store.state.warningHeight - usgsBannerHeight) + 'px';
            }
        },
        mounted() {
        }
    }
</script>

<style scoped lang="scss">

#header {
    position: relative;
    height: 80vh;
    background-color:  white;
}
#title {
    margin:0;
    margin-top:20vh;
}
#subheader {
    font-size: 1.9em;
}
</style>