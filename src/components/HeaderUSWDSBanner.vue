<template>
  <section
    class="usa-banner"
    aria-label="Official website of the United States government"
  >
    <div class="usa-accordion">
      <header class="usa-banner__header">
        <div class="usa-banner__inner">
          <div class="grid-col-auto">
            <img
              aria-hidden="true"
              class="usa-banner__header-flag"
              src="../../node_modules/@uswds/uswds/dist/img/us_flag_small.png"
              alt=""
            >
          </div>
          <div
            class="grid-col-fill tablet:grid-col-auto"
            aria-hidden="true"
          >
            <p class="usa-banner__header-text">
              An official website of the United States government
            </p>
            <p class="usa-banner__header-action">
              Here’s how you know
            </p>
          </div>
          <button
            type="button"
            class="usa-accordion__button usa-banner__button"
            aria-expanded="false"
            aria-controls="gov-banner-default"
          >
            <span class="usa-banner__button-text">Here’s how you know</span>
          </button>
        </div>
      </header>
      <div
        id="gov-banner-default"
        class="usa-banner__content usa-accordion__content"
      >
        <div class="grid-row grid-gap-lg">
          <div class="usa-banner__guidance tablet:grid-col-6">
            <img
              class="usa-banner__icon usa-media-block__img"
              src="../../node_modules/@uswds/uswds/dist/img/icon-dot-gov.svg?url"
              role="img"
              alt=""
              aria-hidden="true"
            >
            <div class="usa-media-block__body">
              <p>
                <strong>Official websites use .gov</strong><br>A
                <strong>.gov</strong> website belongs to an official government
                organization in the United States.
              </p>
            </div>
          </div>
          <div class="usa-banner__guidance tablet:grid-col-6">
            <img
              class="usa-banner__icon usa-media-block__img"
              src="../../node_modules/@uswds/uswds/dist/img/icon-https.svg?url"
              role="img"
              alt=""
              aria-hidden="true"
            >
            <div class="usa-media-block__body">
              <p>
                <strong>Secure .gov websites use HTTPS</strong><br>A
                <strong>lock</strong> (
                <span class="icon-lock">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="52"
                    height="64"
                    viewBox="0 0 52 64"
                    class="usa-banner__lock-image"
                    role="img"
                    aria-labelledby="banner-lock-description-default"
                    focusable="false"
                  >
                    <title id="banner-lock-title-default">Lock</title>
                    <desc id="banner-lock-description-default">Locked padlock icon</desc>
                    <path
                      fill="#000000"
                      fill-rule="evenodd"
                      d="M26 0c10.493 0 19 8.507 19 19v9h3a4 4 0 0 1 4 4v28a4 4 0 0 1-4 4H4a4 4 0 0 1-4-4V32a4 4 0 0 1 4-4h3v-9C7 8.507 15.507 0 26 0zm0 8c-5.979 0-10.843 4.77-10.996 10.712L15 19v9h22v-9c0-6.075-4.925-11-11-11z"
                    />
                  </svg> </span>) or <strong>https://</strong> means you’ve safely connected to
                the .gov website. Share sensitive information only on official,
                secure websites.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
</script>

<style scoped lang="scss">
  @import '../../node_modules/@uswds/uswds/dist/css/uswds.css';
  .usa-banner {
    background-color: #00264c;
  }
  .usa-banner p, text {
    color: #F0F0F0;
    padding: 0;
  }
  .usa-banner__inner {
    margin-left: 1rem;
    padding-left: 0.5rem;
  }
  .usa-banner__header--expanded .usa-banner__inner {
    margin-left: 1rem;
    padding-left: 0.5rem;
  }
  .usa-banner__header-flag {
    width: 1.6rem;
    margin-right: 0.75rem;
  }
  .usa-banner__button {
    color: #78B4E8;
  }
  .usa-accordion__button[aria-expanded=false] {
    background-size: 2.4rem;
  }
  @media (min-width: 600px) {
    .usa-banner__header {
      padding-top: 0.4rem;
      padding-bottom: 0.4rem;
    }
    .usa-banner__header-text {
      font-size: 1.4rem;
    }
    .usa-banner__button {
      font-size: 1.4rem;
    }
    .usa-banner__button::after {
      background-size:1.6rem 1.6rem;
      height: 1.6rem;
      width: 1.6rem;
    }
    .usa-banner__button[aria-expanded=true]::after {
      height: 1.6rem;
      width: 1.6rem;
    }
    @supports ((-webkit-mask: url("")) or (mask: url(""))) {
      .usa-banner__button::after {
        -webkit-mask-size: 1.6rem 1.6rem;
        mask-size: 1.6rem 1.6rem;
      }
      .usa-banner__button[aria-expanded=true]::after {
        -webkit-mask-size: 1.6rem 1.6rem;
        mask-size: 1.6rem 1.6rem;
      }
    }
  }
  .usa-banner__header-action::after{
    background-size:1.6rem 1.6rem;
    height: 1.6rem;
    width: 1.6rem;
  }
  @supports ((-webkit-mask: url("")) or (mask: url(""))){
    .usa-banner__header-action::after{
      -webkit-mask-size:1.6rem 1.6rem;
              mask-size:1.6rem 1.6rem;
      background-color:#78B4E8;
    }
  }
  @media screen and (max-width: 600px) {
    .usa-banner__header {
      padding-top: 0.8rem;
      padding-bottom: 0.8rem;
    }
    .usa-banner__header-text {
      font-size: 1.35rem;
    }
    .usa-banner__header-action {
      font-size: 1.35rem;
    }
    .usa-banner__button[aria-expanded=true]::before {
      background-color: #e6e6e6;
      height: 4.8rem;
      width: 4.8rem;
    }
    .usa-banner__button[aria-expanded=true]::after {
      height: 4.8rem;
      width: 4.8rem;
    }
    @supports ((-webkit-mask: url("")) or (mask: url(""))) {
      .usa-banner__button::after {
        -webkit-mask-size: 2.4rem 2.4rem;
        mask-size: 2.4rem 2.4rem;
      }
      .usa-banner__button[aria-expanded=true]::after {
        -webkit-mask-size: 2.4rem 2.4rem;
        mask-size: 2.4rem 2.4em;
      }
    }
  }
  .usa-banner__button::after {
    background-color: #78B4E8;
  }
  .usa-banner__button[aria-expanded=true]::before {
    background-color: transparent; /* #00264C;*/
  }
  .usa-banner__button[aria-expanded=true]::after {
    background-color: #78B4E8;
  }
  .usa-banner__button:hover {
    color: #A2CCF1;
  }
  .usa-banner__button:hover::after {
    background-color: #A2CCF1;
  }
  .usa-banner__button[aria-expanded=true]:hover::after {
    background-color: #A2CCF1;
  }
  .usa-banner .grid-row.grid-gap-lg {
    padding-left: 2rem;
    padding-right: 2rem;
  }
  .usa-media-block__img {
    margin-right: 0.75rem;
  }
  .usa-banner__content {
    font-size: 1.6rem;
    max-width: 100rem;
  }
  .usa-banner__content p {
    font-size: 1.6rem;
  }
  .usa-banner__icon {
    width: 4rem;
  }
</style>
