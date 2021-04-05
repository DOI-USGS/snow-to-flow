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
<script>
export default {
    name: "VizSection",
    props:{
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
    }
}
</script>
<style scoped lang="scss">
$spacing: 20px;
$border: 10px solid #000;

/*#####vizSectionContent#####*/
.vizSectionContent{
  flex: 1;
}
/*#####TAKE AWAY#####*/
.takeAway{
    h2{
      font-size: 1.4em;
    }
    margin: 0 auto $spacing auto;
    max-width: 700px;
    font-weight: 800;
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
.figureCaption{
  display: flex;
  justify-content: center;
  font-size: .85em;
  line-height: 1.5em; 
  font-style: italic;
}
/*#####EXPLANATION#####*/
.explanation{
  font-size: 1em;
  line-height: 1.75em;
  p{
    padding: 0 0 10px 0;
  }
  ul{
    margin-left: $spacing*2;
    margin-bottom: $spacing;
  }
}
/*#####SHARED CSS#####*/
.takeAway,
.figureCaption,
.explanation{
  padding: 0 10px;
}

.figureCaption,
.explanation{
  max-width: 700px;
  margin: 0 auto $spacing auto;
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
.single{
    text-align: center;
}
.group{
    /* prevent too large mobile graphs from creating a x scroll */
    overflow: hidden;
    align-items: center;
    figure{
        margin-bottom: $spacing;
    }
}
.center{
  justify-items: center; 
}
@media screen and (min-width: 1024px){
  .takeAway{
    h2{
      font-size: 1.7em
    }
  }
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