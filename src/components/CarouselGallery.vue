<template>
  <div
    v-if="layout === 'centered'"
    class="coverflow"
    @keydown.left.prevent="go(-1)"
    @keydown.right.prevent="go(1)"
  >
    <div class="coverflow__stage">
      <!-- Side images are previews only; the nav buttons are the accessible
           controls, so the previews stay out of the tab order -->
      <div
        v-for="slot in slots"
        :key="slot.name"
        :class="['coverflow__slot', `coverflow__slot--${slot.name}`]"
      >
        <Transition
          name="coverflow-fade"
          mode="out-in"
        >
          <button
            :key="items[slot.index].id"
            :class="slot.name === 'center' ? 'carousel__thumb' : 'coverflow__peek'"
            type="button"
            :tabindex="slot.name === 'center' ? 0 : -1"
            :aria-hidden="slot.name === 'center' ? null : 'true'"
            :aria-label="slot.name === 'center' ? `Enlarge: ${items[slot.index].alt}` : null"
            @click="slot.name === 'center' ? open(slot.index) : go(slot.offset)"
          >
            <picture>
              <source
                :srcset="items[slot.index].webp"
                type="image/webp"
              >
              <img
                class="coverflow__image"
                :src="items[slot.index].jpg"
                :alt="slot.name === 'center' ? items[slot.index].alt : ''"
              >
            </picture>
          </button>
        </Transition>
      </div>
    </div>
    <button
      class="carousel__nav coverflow__nav coverflow__nav--prev"
      type="button"
      aria-label="Previous image"
      @click="go(-1)"
    >
      <span aria-hidden="true">&#8249;</span>
    </button>
    <button
      class="carousel__nav coverflow__nav coverflow__nav--next"
      type="button"
      aria-label="Next image"
      @click="go(1)"
    >
      <span aria-hidden="true">&#8250;</span>
    </button>
    <p
      class="coverflow__status"
      aria-live="polite"
    >
      Image {{ current + 1 }} of {{ items.length }}
    </p>
  </div>

  <div
    v-else
    class="carousel"
  >
    <button
      class="carousel__nav carousel__nav--prev"
      type="button"
      :disabled="atStart"
      aria-label="Previous images"
      @click="scrollBy(-1)"
    >
      <span aria-hidden="true">&#8249;</span>
    </button>

    <ul
      ref="track"
      class="carousel__track"
      @scroll="updateEdges"
    >
      <li
        v-for="(item, i) in items"
        :key="item.id"
        class="carousel__slide"
      >
        <button
          :id="item.id"
          class="carousel__thumb"
          type="button"
          :aria-label="`Enlarge: ${item.alt}`"
          @click="open(i)"
        >
          <picture>
            <source
              :srcset="item.webp"
              type="image/webp"
            >
            <img
              class="carousel__image"
              :src="item.jpg"
              :alt="item.alt"
              loading="lazy"
            >
          </picture>
        </button>
      </li>
    </ul>

    <button
      class="carousel__nav carousel__nav--next"
      type="button"
      :disabled="atEnd"
      aria-label="Next images"
      @click="scrollBy(1)"
    >
      <span aria-hidden="true">&#8250;</span>
    </button>
  </div>

  <!-- Lightbox. A native <dialog> gives us the focus trap, the backdrop, and
       Escape-to-close for free, so there is no need for a library here. -->
  <dialog
    ref="lightbox"
    class="lightbox"
    @click="onBackdropClick"
    @close="activeIndex = null"
  >
    <div
      v-if="active"
      class="lightbox__inner"
    >
      <button
        class="lightbox__close"
        type="button"
        aria-label="Close enlarged image"
        @click="close"
      >
        &times;
      </button>
      <figure class="lightbox__figure">
        <picture>
          <source
            :srcset="active.webp"
            type="image/webp"
          >
          <img
            class="lightbox__image"
            :src="active.jpg"
            :alt="active.alt"
          >
        </picture>
        <figcaption
          v-if="active.title"
          class="lightbox__caption"
        >
          {{ active.title }}
        </figcaption>
      </figure>
      <div
        v-if="items.length > 1"
        class="lightbox__controls"
      >
        <button
          type="button"
          aria-label="Previous image"
          @click="step(-1)"
        >
          &#8249; Previous
        </button>
        <span class="lightbox__count">{{ activeIndex + 1 }} of {{ items.length }}</span>
        <button
          type="button"
          aria-label="Next image"
          @click="step(1)"
        >
          Next &#8250;
        </button>
      </div>
    </div>
  </dialog>
</template>

<script setup>
  import { ref, computed, onMounted, onBeforeUnmount, nextTick } from 'vue';

  const props = defineProps({
    // [{ id, jpg, webp, alt, title }]
    items: {
      type: Array,
      required: true
    },
    // How many slides are visible at once on a wide screen ('strip' only).
    perPage: {
      type: Number,
      default: 3
    },
    // 'strip': a scrolling row of equal-width slides, for images that share
    // an aspect ratio. 'centered': one large image flanked by previews of its
    // neighbours, all at the same height, for mixed portrait/landscape photos.
    layout: {
      type: String,
      default: 'strip',
      validator: (value) => ['strip', 'centered'].includes(value)
    }
  });

  const track = ref(null);
  const lightbox = ref(null);
  const activeIndex = ref(null);
  const atStart = ref(true);
  const atEnd = ref(false);

  // Index of the image in the middle of the 'centered' layout
  const current = ref(0);

  function wrap(index) {
    const count = props.items.length;
    return (index + count) % count;
  }

  const slots = computed(() => [
    { name: 'prev', offset: -1, index: wrap(current.value - 1) },
    { name: 'center', offset: 0, index: current.value },
    { name: 'next', offset: 1, index: wrap(current.value + 1) }
  ]);

  function go(direction) {
    current.value = wrap(current.value + direction);
  }

  const active = computed(() =>
    activeIndex.value === null ? null : props.items[activeIndex.value]
  );

  function updateEdges() {
    const el = track.value;
    if (!el) return;
    atStart.value = el.scrollLeft <= 1;
    // Allow a pixel of slack; sub-pixel layout means scrollLeft rarely lands
    // exactly on the maximum.
    atEnd.value = el.scrollLeft + el.clientWidth >= el.scrollWidth - 1;
  }

  function scrollBy(direction) {
    const el = track.value;
    if (!el) return;
    const slide = el.querySelector('.carousel__slide');
    const step = slide ? slide.getBoundingClientRect().width : el.clientWidth;
    el.scrollBy({ left: direction * step, behavior: 'smooth' });
  }

  function open(index) {
    activeIndex.value = index;
    nextTick(() => lightbox.value?.showModal());
  }

  function close() {
    lightbox.value?.close();
  }

  function step(direction) {
    const count = props.items.length;
    activeIndex.value = (activeIndex.value + direction + count) % count;
  }

  // A click that lands on the <dialog> itself rather than its contents is a
  // click on the backdrop.
  function onBackdropClick(event) {
    if (event.target === lightbox.value) close();
  }

  function onKeydown(event) {
    if (activeIndex.value === null) return;
    if (event.key === 'ArrowRight') step(1);
    if (event.key === 'ArrowLeft') step(-1);
  }

  onMounted(() => {
    updateEdges();
    window.addEventListener('resize', updateEdges);
    window.addEventListener('keydown', onKeydown);
  });

  onBeforeUnmount(() => {
    window.removeEventListener('resize', updateEdges);
    window.removeEventListener('keydown', onKeydown);
  });
</script>

<style lang="scss" scoped>
  .carousel {
    position: relative;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    width: 100%;
  }

  .carousel__track {
    display: flex;
    gap: 1rem;
    margin: 0;
    padding: 0;
    list-style: none;
    overflow-x: auto;
    scroll-snap-type: x mandatory;
    scrollbar-width: thin;
    flex: 1 1 auto;
  }

  .carousel__slide {
    flex: 0 0 calc((100% - 2rem) / v-bind(perPage));
    scroll-snap-align: start;
    margin: 0;
  }

  .carousel__thumb {
    display: block;
    width: 100%;
    padding: 0;
    border: none;
    background: none;
    cursor: zoom-in;

    &:focus-visible {
      outline: 3px solid var(--color-link);
      outline-offset: 2px;
    }
  }

  .carousel__image {
    display: block;
    width: 100%;
    height: auto;
  }

  .carousel__nav {
    flex: 0 0 auto;
    width: 3.2rem;
    height: 3.2rem;
    border: none;
    border-radius: 50%;
    background: var(--color-link);
    color: #fff;
    font-size: 2.4rem;
    line-height: 1;
    cursor: pointer;

    &:disabled {
      opacity: 0.3;
      cursor: default;
    }

    &:focus-visible {
      outline: 3px solid var(--color-text);
      outline-offset: 2px;
    }
  }

  /*##### CENTERED LAYOUT #####*/
  .coverflow {
    // every image shares this height, whatever its aspect ratio
    --coverflow-height: clamp(22rem, 32vw, 44rem);
    position: relative;
    width: 100%;
    max-width: 120rem;
    margin: 0 auto;
  }

  .coverflow__stage {
    display: grid;
    grid-template-columns: minmax(0, 1fr) auto minmax(0, 1fr);
    align-items: center;
    gap: 1.5rem;
  }

  .coverflow__slot {
    display: flex;
    min-width: 0;
    overflow: hidden;
  }

  // previews hug the centre image and are cropped at the outer edge
  .coverflow__slot--prev {
    justify-content: flex-end;
  }

  .coverflow__slot--next {
    justify-content: flex-start;
  }

  .coverflow__peek {
    flex: 0 0 auto;
    padding: 0;
    border: none;
    background: none;
    cursor: pointer;
    opacity: 0.45;
    transition: opacity 0.2s;

    &:hover {
      opacity: 0.7;
    }
  }

  .coverflow__image {
    display: block;
    width: auto;
    max-width: none;
    height: var(--coverflow-height);
  }

  .coverflow__peek .coverflow__image {
    height: calc(var(--coverflow-height) * 0.75);
  }

  .coverflow__slot--center .coverflow__image {
    // keep very wide photos from crowding out the previews
    max-width: min(60vw, 90rem);
    object-fit: contain;
  }

  .coverflow__nav {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    // sit above the (translucent) side previews, and above the status line
    margin-top: -1.2rem;

    &--prev {
      left: 0;
    }

    &--next {
      right: 0;
    }
  }

  .coverflow__status {
    margin: 1rem 0 0;
    text-align: center;
    font-size: 0.85em;
    color: var(--medium-grey-dark);
  }

  .coverflow-fade-enter-active,
  .coverflow-fade-leave-active {
    transition: opacity 0.2s ease;
  }

  .coverflow-fade-enter-from,
  .coverflow-fade-leave-to {
    opacity: 0;
  }

  @media (prefers-reduced-motion: reduce) {
    .coverflow-fade-enter-active,
    .coverflow-fade-leave-active {
      transition: none;
    }
  }

  .lightbox {
    width: min(92vw, 110rem);
    max-height: 92vh;
    padding: 0;
    border: none;
    border-radius: 4px;
    background: #fff;

    &::backdrop {
      background: rgba(0, 0, 0, 0.75);
    }
  }

  .lightbox__inner {
    position: relative;
    padding: 1.5rem;
  }

  .lightbox__close {
    position: absolute;
    top: 0.5rem;
    right: 0.8rem;
    border: none;
    background: none;
    font-size: 3rem;
    line-height: 1;
    cursor: pointer;
    color: var(--color-text);
  }

  .lightbox__figure {
    margin: 0;
  }

  .lightbox__image {
    display: block;
    width: 100%;
    height: auto;
    max-height: 65vh;
    object-fit: contain;
  }

  .lightbox__caption {
    max-width: 70rem;
    margin: 1.5rem auto 0;
    font-size: 1.6rem;
    line-height: 1.5;
    text-align: left;
  }

  .lightbox__controls {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 1.5rem;
    margin-top: 1.5rem;
    font-size: 1.5rem;

    button {
      border: none;
      background: none;
      font-size: inherit;
      color: var(--color-link);
      cursor: pointer;
    }
  }

  .lightbox__count {
    color: var(--color-text);
  }

  /* One slide at a time on small screens, whatever perPage says. */
  @media screen and (max-width: 700px) {
    .carousel__slide {
      flex-basis: 100%;
    }
    .lightbox__caption {
      font-size: 1.4rem;
    }
    .coverflow {
      --coverflow-height: 24rem;
    }
    .coverflow__stage {
      gap: 0.75rem;
    }
    .coverflow__slot--center .coverflow__image {
      max-width: 72vw;
    }
  }
</style>
