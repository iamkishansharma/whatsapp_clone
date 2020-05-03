'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "1cb14d0646f5a48b334f7129da781680",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/images/pro1.png": "0d0439df4fb5b869530c4649c2a07a5f",
"assets/images/pro2.png": "97f67c7dbc5d247a31af47372d4b002b",
"assets/images/pro3.png": "68a345a33a48e22a2633ed1142f7f87a",
"assets/images/pro4.png": "33f71dade9356b9187ec89a934bc5e6a",
"assets/images/splash.jpg": "db7e99ebd05d1b0ef7dbc0c722fd6632",
"assets/LICENSE": "7b3e7bd5058bcdb0452418fa8c9ac476",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "4e2273cf3e7334aaf9ef4f9bb7816526",
"icons/Icon-512.png": "4e2273cf3e7334aaf9ef4f9bb7816526",
"index.html": "f12b0f0db565ee62af925a166a27ee24",
"/": "f12b0f0db565ee62af925a166a27ee24",
"main.dart.js": "7bd2ad0e38ffd32b36cab7bb2179ca1f",
"manifest.json": "09d88e82096014eb1667e2e737be751f"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
