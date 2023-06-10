// service_worker_clear_cache.js

function clearServiceWorkerCache() {
  if ('caches' in window) {
//    console.log('clear service worker cache');
    caches.keys().then((cacheNames) => {
      cacheNames.forEach((cacheName) => {
        caches.delete(cacheName);
      });
    });
  }
}

// 在需要清除缓存的地方调用该函数
// 例如：js.context.callMethod('eval', ['clearCache()']);
// 或者：js.context.callMethod('clearServiceWorkerCache')
