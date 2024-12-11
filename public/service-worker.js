const CACHE_NAME = "swimming-school-cache-v1";
const urlsToCache = [
    "/",
    "/manifest.json",
    "/assets/stylesheets/application.css",
    "/assets/javascripts/application.js",
    "/assets/icon-192x192.png",
    "/assets/icon-512x512.png"
];

// インストールイベント{}
self.addEventListener("install", event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      console.log("Opened cache");
      return cache.addAll(urlsToCache);
    })
  );
});

// フェッチイベント
self.addEventListener("fetch", event => {
  event.respondWith(
    caches.match(event.request).then(response => {
      return response || fetch(event.request);
    })
  );
});

// キャッシュのクリーンアップ
self.addEventListener("activate", event => {
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (!cacheWhitelist.includes(cacheName)) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
