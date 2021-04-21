<template>
  <div class="sidebar collapsed opacity">
    <div class="sidebarContent">
      <div class="titleAndExit">
        <button
          class="reveal"
          @click="toggle"
        >
          <slot name="sidebarTitle">
            Reveal
          </slot>
        </button>
        <div
          class="exit hidden"
          @click="toggle"
        >
          X
        </div>
      </div>
      <div class="messageArea">
        <div class="message">
          <slot name="sidebarMessage">
            Message
          </slot>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
    name: "SidebarTwo",
    mounted(){
        window.addEventListener("load", () => this.setDimensions());
    },
    methods:{
        setDimensions(){
            const sidebar = this.$el;
            const button = this.$el.querySelector(".reveal")
            const buttonDimensions = button.getBoundingClientRect();
            sidebar.style.height = `${buttonDimensions.height}px`;
            sidebar.style.width = `${buttonDimensions.width}px`;
            sidebar.classList.remove("opacity");
        },
        toggle(){
            const exit = this.$el.querySelector(".exit");
            exit.classList.toggle("hidden");
            if(this.$el.classList.contains("expanded")){
                
                this.$el.classList.remove("expanded");
                this.$el.classList.add("collapsed");
                this.setDimensions();
            }else{
                this.$el.classList.remove("collapsed");
                this.$el.classList.add("expanded");
                this.$el.style.width = "auto";
                this.$el.style.height = "auto";
            }   
        }
    }
}
</script>
<style lang="scss" scoped>
$deepBlue: #00478F; //#00478F;
$familyMain: 'Public sans', sans-serif;
.sidebar{
    display: flex;
    flex-direction: row;
    margin: 15px 20px;
    transition: width 2s, height 2s, transform 2s;
    will-change: width;
    background: $deepBlue;
    border-radius: 5px;
    transition: opacity 0.3s;

}
.titleAndExit{
    position: relative;
    color:#fff;
    font-weight: bold;
    
}
.reveal{
    padding: 5px 10px;
    outline: none;
}
.opacity{
  opacity: 0;
}
.exit{
    position: absolute;
    right: 5px;
    top: 0;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: $familyMain;
    font-size: 1em;
    padding: 10px;
    border-radius: 5px;
    cursor: pointer;
    &:hover{
        background: #fff;
        color:$deepBlue;
        transition: background-color .1s;
    }
}
.messageArea{
    padding:0 10px 10px 10px;
}
.message{
    background: #fff;
    padding: 10px;
    *{
      padding-top: 0;
      margin-bottom: 10px;
      &:last-child{
        margin-bottom: 0;
      }
    }
}
.collapsed{
    .message{
        width: 0;
        height: 0;
        opacity: 0;
    }
}
.hidden{
    display: none;
}
</style>