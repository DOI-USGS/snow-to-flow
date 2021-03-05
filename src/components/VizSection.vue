<template>
  <section class="vizSection">
    <div class="vizSectionContent">
      <div class="takeAway">
        <slot name="takeAway">
          Take Away Title
        </slot>
      </div>
      <div class="aboveExplanation explanation">
        <slot name="aboveExplanation" />
      </div>
      <div class="figures">
        <slot name="figures">
          Figure(s)
        </slot>
      </div>
      <div class="figureCaption">
        <slot name="figureCaption">
          Figure Caption
        </slot>
      </div>
      <div class="belowExplanation explanation">
        <slot name="belowExplanation">
          Explanation
        </slot>
      </div>
    </div>
  </section>
</template>
<script>
export default {
    name: "VizSection"
}
</script>
<style scoped lang="scss">
$spacing: 15px;
$border: 10px solid #000;
.vizSection{
    p{
        padding: 0; 
        margin: 0;
    }
}
/*#####vizSectionContent#####*/
.vizSectionContent{
  flex: 1;
}
/*#####TAKE AWAY#####*/
.takeAway{
    h1{
        text-align: center;
    }
    margin-bottom: $spacing;
}
/*#####FIGURES#####*/
.figures{
    &>*{
        margin-bottom: $spacing;
    }
    figure{
      img{
          width:100%;
        }
    }
    img{
      width: 100%;
    }
}
/*#####FIGURE CAPTION#####*/

/*#####EXPLANATION#####*/
/*#####SHARED CSS#####*/
.figureCaption,
.explanation{
  max-width: 700px;
  margin: 0 auto 15px auto;
}
/*#####CUSTOMIZATION CLASSES#####*/
.maxWidth{
    max-width: 1500px;
    margin: 0 auto 15px auto;
    p {
      max-width: 700px;
      margin: 0 auto;
    }
}
.text-content{
  max-width: 700px;
  margin: 0 auto;
}
.single{
    text-align: center;
    figure{
        min-height: 300px;
    }
}
.group{
    align-items: center;
    figure{
        margin-bottom: $spacing;
    }
}
.center{
  justify-items: center; 
}
@media screen and (min-width: 1024px){
  /*#####CUSTOMIZATION CLASSES#####*/
    .group{
        display: grid;
        gap: 15px;
    }
    .two{
        grid-template-columns: repeat(2, 1fr);
    }
    .three{
        grid-template-columns: repeat(3, 1fr);
    }   
}
</style>