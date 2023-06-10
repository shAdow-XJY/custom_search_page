// service_worker.js

// 定义需要缓存的网页内容
const cacheName = 'custom_search_page_cache';
const cacheItems = [
  '/',
  '/index.html',
  '/flutter.js',
  '/favicon.png',
  '/manifest.json',
  '/main.dart.js',
  '/icons/Icon-192.png',
  '/assets/FontManifest.json',
  '/assets/fonts/MaterialIcons-Regular.otf',
  '/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf',
  '/js/service_worker.js',
  '/js/service_worker_register.js',
  '/js/service_worker_clear.js',
];

// 监听安装事件
self.addEventListener('install', function(event) {
  // 执行安装逻辑，缓存网页内容
  event.waitUntil(
    caches.open(cacheName).then(function(cache) {
      return cache.addAll(cacheItems);
    })
  );
});

// 监听请求事件
self.addEventListener('fetch', function(event) {
  // 从缓存中提供已缓存的内容，如果缓存中不存在，则向服务器请求内容
  event.respondWith(
    caches.match(event.request).then(function(response) {
      return response || fetch(event.request);
    })
  );
});
