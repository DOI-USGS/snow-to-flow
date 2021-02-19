<template>
  <div class="sidebar">
    <div class="sidebarContent hidden">
      <div class="titleAndExit">
        <div class="title">
          <slot>Title</slot>
        </div>
        <div
          class="exit"
          @click="toggle"
        >
          X
        </div>
      </div>
      <div class="message">
        <slot>Message Area</slot>
      </div>
    </div>
    <button
      class="sidebarReveal"
      @click="toggle"
    >
      <slot>Button Text</slot>
    </button>
  </div>
</template>
<script>
export default {
    name: "Sidebar",
    data() {
        return {
            visible: true
        }
    },
    methods:{
        toggle(){
            const sidebarContent = this.$el.children[0];
            const sidebarReveal = this.$el.children[1];
            if(sidebarContent.classList.contains("hidden")){
                sidebarContent.classList.remove("hidden");
                sidebarReveal.classList.add("hidden");
                
            }else{
                sidebarContent.classList.add("hidden");
                sidebarReveal.classList.remove("hidden");
            } 
        }
    }
}
</script>
<style lang="scss" scoped>
.hidden{
   display: none;
   opacity: 0;
}
.sidebar{
    margin-top: 15px;
}
.titleAndExit{
    display: flex;
    align-items: center;
    border: 1px solid #000;
}
.title,
.exit{
    padding: 0 10px;
}
.message,
.sidebarReveal{
   padding: 10px;  
}
.title{
    flex: 1;
    font-size: 1.2em;
}
.exit{
    text-align: center;
    font-weight: bold;
    font-size: 1.5em;
    cursor: pointer;
    &:hover{
        background: rgb(100,100,100);
        color: #fff;
    }
}
.message{
    border: 1px solid #000;
}
.sidebarReveal{
    border: 1px solid #000;
}
</style>