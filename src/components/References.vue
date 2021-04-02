<template>
  <section id="references">       
    <div class="text-content">
      <h2>{{ text.title }}</h2>
      <div class="usa-accordion usa-accordion--bordered">
        <div
          v-for="reference in text.references"
          :key="reference.subTitle"
        >
          <p><span v-html="reference.reference" /></p>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
    import referencesText from "@/assets/text/referencesText";
    import USWDS from "uswds/src/js/components";
    const { accordion } = USWDS;
    export default {
        name: 'References',
        components: {
        },
        data() {
            return {
                text: referencesText.referencesContent,
                titleImage:require('@/assets/titleImages/image2.png'), // insert link to parallax image used for this section
            }
        },
        mounted(){
          // This is a fix for the weird USWDS glitch that causes the Methods section accordion menus to be open on page load
            const targetAccordionDivs = document.querySelectorAll('.target');
            targetAccordionDivs.forEach((div) => {
                div.setAttribute('hidden', '""');
            });
        }
    }
</script>
/*Scope USWDS styles*/
<style scoped src="../../node_modules/uswds/dist/css/uswds.min.css"></style>
<style scoped lang="scss">

/*https://css-tricks.com/creating-a-maintainable-icon-system-with-sass/ icon system code */
$icons:(
  "chevronLeft": '<svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 165 255"><path d="M165,36v4c-1.78,2.17-3.4,4.52-5.38,6.5q-38.06,38.16-76.18,76.25c-1.48,1.48-2.85,3.08-4.46,4.83,1.73,1.82,3.06,3.28,4.45,4.67q38.1,38.13,76.19,76.25c2,2,3.6,4.33,5.38,6.5v4c-1.55,2.12-2.86,4.47-4.68,6.32Q147.78,238.13,135,250.67a48.26,48.26,0,0,1-6,4.33h-4a78.69,78.69,0,0,1-7-5.58Q62.55,194.07,7.18,138.6C4.71,136.14,2.39,133.54,0,131v-7c1.57-1.71,3.07-3.49,4.71-5.13Q61.51,62,118.4,5.22A70.08,70.08,0,0,1,125,0h5q16.42,16.11,32.81,32.25C163.8,33.24,164.28,34.74,165,36Z" style="fill:%%COLOR%%"/></svg>',
  "chevronDown": '<svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 255 165"><path d="M35,0h6c2.14,1.83,4.42,3.52,6.41,5.51Q85.59,43.6,123.63,81.86c3.49,3.54,5.34,3.18,8.63-.14q38-38.34,76.24-76.34c2-2,4.32-3.59,6.5-5.38h5a30.15,30.15,0,0,1,4,2.9Q239.57,18.4,255,34v7c-1.33,1.48-2.6,3-4,4.43Q193.48,103,135.89,160.49A54.58,54.58,0,0,1,130,165h-5c-1.75-1.51-3.61-2.92-5.24-4.55Q62.39,103.14,5.11,45.72C3,43.58,1.68,40.59,0,38V37c1-1.89,1.65-4.15,3.09-5.6C13.64,20.84,24.34,10.45,35,0Z" style="fill:%%COLOR%%"/></svg>'
);
$data-svg-prefix: 'data:image/svg+xml;utf-8,';
$brightBlue: rgb(9,98,178);

@function str-replace($string, $search, $replace: ""){
  $index: str-index($string, $search);
  @if $index{
    @return str-slice($string, 1, $index - 1) + $replace + str-replace(str-slice($string, $index + str-length($search)), $search , $replace );
  }
  @return $string;
}
@function get-icon($icon, $color: #000){
  $icon: map-get($icons, $icon);
  $placeholder: "%%COLOR%%";
  $data-uri: str-replace(url($data-svg-prefix + $icon), $placeholder, $color);
  @return str-replace($data-uri, "#", "%23");
}
/*End credited code*/
/*Reference title CSS*/
.text-content h2{
  text-align: left;
}
button:not([disabled]):focus{
  outline: none;
}
.usa-accordion__heading{
  font-size: 1.2em;
}
.usa-accordion__button{
  background-image: get-icon("chevronDown", #fff);
  background-size: 15px 10px;
  background-color: $brightBlue;
  color: white;
  &:hover{
    //overides USWDS styles
    background-color: $brightBlue;
    color: white;
  }
}
.usa-accordion__button[aria-expanded=false]{
  background-image: get-icon("chevronLeft", $brightBlue);
  background-size: 10px 15px;
  background-color: rgb(241, 240, 240);
  color: $brightBlue;
  &:hover{
    background-image: get-icon("chevronLeft", #fff);
    background-color: $brightBlue;
    color: white;
  }
}
.target p{
  padding: 0;
  font-size: 1em;
  line-height: 1.5em; 
}
/*Accordion title CSS*/
h2.usa-accordion__heading {
  margin: 0;
}
</style>