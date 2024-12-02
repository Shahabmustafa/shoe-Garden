'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "e7475493ff9c68add4c13ede97444d49",
"version.json": "0fdec62a50d3415ad47345fb5926d309",
"index.html": "b8357c55aab2894f214203edeac24ecf",
"/": "b8357c55aab2894f214203edeac24ecf",
"main.dart.js": "07924b3f0c4fc32c3b2a0842a30179ae",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "8388851899c38d2662ec6225f4dd8ab4",
"icons/Icon-192.png": "61bf2ca379933a75a70ed33461c94bd5",
"icons/Icon-maskable-192.png": "61bf2ca379933a75a70ed33461c94bd5",
"icons/Icon-maskable-512.png": "f2e64de26dd76eb1b4680a50c78595d1",
"icons/Icon-512.png": "f2e64de26dd76eb1b4680a50c78595d1",
"manifest.json": "e71b8fc00766da979071c9da246e0617",
"assets/AssetManifest.json": "1d822b6120fef02a3d0d76d3dc6a185e",
"assets/NOTICES": "bd16ea46951bf548c3889a87441f2032",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "27398b0bc810c51374418d4762f1dcf0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b33590075dcb846ada654ffb5491fbc8",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/flutter_esc_pos_utils/resources/capabilities.json": "2756571bbd7dee9a37c7a9648937fcee",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "07537818ca109aa9505bab2e1a0720cc",
"assets/fonts/MaterialIcons-Regular.otf": "9ae6bcf613bf8ebe100666964ee87187",
"assets/assets/images/target.svg": "83ecf1138bdc72b56ad01f61ef190990",
"assets/assets/images/icon_stock_position.svg": "b1d3c7718a7b4f6474fd660635548c71",
"assets/assets/images/user.svg": "0b7cc0ec74ea81ca9134bf5aaa2e1b90",
"assets/assets/images/sale.png": "b6638c74649a316de62be3db545243fc",
"assets/assets/images/total_product.png": "8061ecabcfb5e692f67e5fab0ef21105",
"assets/assets/images/purchase_invoice.png": "03937b04f5120c812f2152737936ba89",
"assets/assets/images/sale_invice.png": "47b8e4a36310168972aecc3a84f3feaa",
"assets/assets/images/today_sale.png": "c8a48401a67b27e1e04126b6cafbad62",
"assets/assets/images/purchase.svg": "42056e5f295f8a7655b1aff9cbff6c2e",
"assets/assets/images/sale_invoice.svg": "14f77fe965e477585b9323f5a93f8c43",
"assets/assets/images/icon_discount.svg": "439ed2ca7a338fca05b7b9cf43c93c22",
"assets/assets/images/person.png": "288ba4757aefa21aee328f57ab799fc3",
"assets/assets/images/dashboard.svg": "5f5402b6f9f4f4c4dd93d28c23e52b9c",
"assets/assets/images/target.png": "386abb15b15ad6b24c2bcc8b29c522d9",
"assets/assets/images/icon_voucher.svg": "3a692648b148cc4cee84ba2a0edcb3e7",
"assets/assets/images/total_warhouse.png": "a49d744b32abb2c3ed828e5d071c6089",
"assets/assets/images/copy.svg": "f9ebf13c77fc5ebf50bb02a19db48b50",
"assets/assets/images/shop_logo.png": "7844ff4ef7eec00002a83d354a68db0c",
"assets/assets/images/salemen.png": "577b154347894ba7b019f0bee3fab8ba",
"assets/assets/images/logo.jpg": "cd974f7a4a8af03f2a3e842f7669eec7",
"assets/assets/images/barcode_icon.svg": "2514e371ee49b661dcc5f439a2045639",
"assets/assets/images/icon_claim.svg": "311a29fa6a4c598ed1f62b4d78837bb2",
"assets/assets/images/salaries.svg": "7751b82e1ec1be3f476a9dcde6c69535",
"assets/assets/images/claims.png": "1fbceba686a13dca1009007d19536edc",
"assets/assets/images/icon_expense.svg": "fb9f5140b21d0660c26dcc3ad37a3af5",
"assets/assets/images/bank.svg": "f2196129e09d5ec7bee8fee2ffad2678",
"assets/assets/images/products.svg": "338a4cd57fa8b9ee94917a5ae4ce57b8",
"assets/assets/images/icon_report.svg": "e4b225a12af14dd7ccb464f8a94d4cd0",
"assets/assets/images/branches.png": "e556ec034971819d1b166a818d1f41df",
"assets/assets/images/salemen.svg": "c123ebaf8741bc3f99d973d293efbd02",
"assets/assets/images/barcode.png": "bc57d124879acc8ee799b593d655f414",
"assets/assets/images/company.svg": "5a39756cc8e792b355a10fa84671cefd",
"assets/assets/images/assign.svg": "35c669ff0ce0d3c6d17560988be7c1e6",
"assets/assets/images/customer.svg": "d77d474b451b56ead2579eca485b7336",
"assets/assets/invoice.json": "d5be9b7552ef6a606c3992e86c200873",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
