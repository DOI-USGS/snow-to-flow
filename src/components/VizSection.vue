<template>
  <section class="vizSection">
    <div class="takeAway">
      <slot name="takeAway">
        Take Away Title
      </slot>
    </div>
    <div class="figures">
      <slot name="figures">
        Figure(s)
      </slot>
    </div>
    <div class="figureCaption maxWidth">
      <slot name="figureCaption">
        Figure Caption
      </slot>
    </div>
    <div class="explanation maxWidth">
      <slot name="explanation">
        Explanation
      </slot>
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
$border: 1px solid #000;
.vizSection{
    padding: 10px;
    p{
        padding: 0; 
        margin: 0;
    }
}
.takeAway{
    h1{
        text-align: center;
    }
    margin-bottom: $spacing;
}
.figures{
    &>*{
        margin-bottom: $spacing;
    }
    figure{
        border: $border;
    }
}
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
    width: 100%;
    figure{
        min-height: 300px;
    }
}
.group{
    figure{
        margin-bottom: $spacing;
    }
}
.figureCaption{
    margin-bottom: $spacing;
}

@media screen and (min-width: 1024px){
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