const CACHE_NAME = "swimming-school-cache-v2";

// インストールイベント
self.addEventListener("install", (event) => {
  console.log("Service Worker: Install event started.");
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log("Opened cache");
      return cache.addAll([
        "/", // ホームページ
        "/manifest.json", // PWA マニフェスト
        "/offline.html", // オフラインページ
        "/packs/css/application-3c4d8577.css", // CSSファイル（正確なパスを記述）
        "/packs/js/application-9315cc934ab7b1f3bbe3.js", // JSファイル（正確なパスを記述）
        "/assets/icon-192x192.png", // アプリアイコン（小）
        "/assets/icon-512x512.png" // アプリアイコン（大）
      ]).catch((error) => {
        console.error("Failed to cache resources:", error);
      });
    })
  );
});

// フェッチイベント
self.addEventListener("fetch", (event) => {
  console.log("Service Worker: Fetching", event.request.url);
  event.respondWith(
    caches.match(event.request).then((response) => {
      if (response) {
        console.log("Found in cache:", event.request.url);
        return response;
      }
      console.log("Not found in cache. Fetching from network:", event.request.url);
      return fetch(event.request)
        .then((networkResponse) => {
          console.log("Network request successful:", event.request.url);
          return networkResponse;
        })
        .catch((error) => {
          console.error("Network request failed. Falling back to offline page:", event.request.url, error);
          if (event.request.mode === "navigate") {
            return caches.match("/offline.html");
          }
        });
    }).catch((error) => {
      console.error("Error in fetch handler:", error);
    })
  );
});

// キャッシュのクリーンアップ
self.addEventListener("activate", (event) => {
  console.log("Service Worker: Activate event started.");
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (!cacheWhitelist.includes(cacheName)) {
            console.log("Deleting old cache:", cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
