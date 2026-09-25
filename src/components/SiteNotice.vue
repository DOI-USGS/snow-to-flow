<template>
  <ShutdownBanner
    v-if="notice"
    :message="notice.message"
    :link-url="notice.linkUrl"
    :link-text="notice.linkText"
    :heading="notice.heading"
  />
</template>

<script setup>
  /*
   * Site-wide notice controller.
   *
   * Renders nothing unless a notice is active, so it is safe to leave mounted
   * permanently in App.vue - that is the point. To raise a banner across every
   * site you edit the shared status file; no rebuild or redeploy is needed.
   *
   * ShutdownBanner is loaded asynchronously on purpose. It imports the whole
   * USWDS stylesheet, so keeping it behind a dynamic import puts that CSS in a
   * lazy chunk that is only fetched when a notice is actually showing.
   */
  import { ref, onMounted, defineAsyncComponent } from 'vue';

  const ShutdownBanner = defineAsyncComponent(() => import('@/components/ShutdownBanner.vue'));

  const notice = ref(null);
  const siteTitle = import.meta.env.VITE_APP_TITLE;

  // Escape hatch: force the banner on at build time, for the case where the
  // status file is unreachable and a notice still has to go up.
  const forced = import.meta.env.VITE_APP_SHUTDOWN === 'true';

  function statusUrl() {
    // Explicit override, mainly for local development.
    if (import.meta.env.VITE_APP_STATUS_URL) return import.meta.env.VITE_APP_STATUS_URL;
    // BASE_URL is '/<asset-url>/<site>/', so '../status.json' resolves to the
    // shared '/<asset-url>/status.json'. Same origin, so no CORS involved.
    return new URL('../status.json', new URL(import.meta.env.BASE_URL, window.location.origin)).href;
  }

  function isActive(entry, now) {
    if (entry.startsAt && now < new Date(entry.startsAt)) return false;
    if (entry.endsAt && now > new Date(entry.endsAt)) return false;
    // An empty or absent `sites` list means the notice applies everywhere.
    if (Array.isArray(entry.sites) && entry.sites.length && !entry.sites.includes(siteTitle)) return false;
    return true;
  }

  onMounted(async () => {
    if (forced) {
      // Empty object - ShutdownBanner falls back to its own prop defaults.
      notice.value = {};
      return;
    }
    try {
      const res = await fetch(statusUrl(), {
        cache: 'no-cache', // revalidate, so a flipped flag is picked up promptly
        signal: AbortSignal.timeout ? AbortSignal.timeout(3000) : undefined
      });
      if (!res.ok) return;
      const data = await res.json();
      const now = new Date();
      notice.value = (data.notices || []).find((entry) => isActive(entry, now)) || null;
    } catch {
      // Fail quiet. A missing or malformed status file must never break the
      // page, so the banner simply does not appear.
    }
  });
</script>
