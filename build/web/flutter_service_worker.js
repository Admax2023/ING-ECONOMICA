'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "c99ce376d4eb7a61e6cef2f2dba3edfa",
"assets/AssetManifest.bin.json": "c81677d10de1f4ba7aebbf26a8d8662e",
"assets/AssetManifest.json": "ecbab23e4f9a898f616ffa281429d8c7",
"assets/assets/1.png": "2ebb7483ab3a918f41dba5e38b219223",
"assets/assets/2.png": "9f5b02b2e8550932f8908d63f7f32c2a",
"assets/assets/3.png": "0855e3424f0258b5da07ae36b05369cc",
"assets/assets/4.png": "0f2bcd5643d28d655ee50fca45f69222",
"assets/assets/5.png": "fe6dcf70be72194d7be99fddd2043b24",
"assets/assets/6.png": "788d57ec1a46f644dfd2b28f3f78c5f1",
"assets/assets/Amortizacion.png": "55c3a8f5b5d6ab53f24360638313c4db",
"assets/assets/anualidades.png": "3d4be1a22cd3ab3dddd1dca729a53470",
"assets/assets/Capital.png": "b83ab9db7be4e563caa7403e3e81ec63",
"assets/assets/Capitalizacion.png": "358dfa5432a45818d3805a2ef946172e",
"assets/assets/interes.png": "977e23452c634c1dd162504e6363846b",
"assets/assets/itcompuesto.png": "ab252d5eb1dfe6fe1ed007c383c4facd",
"assets/assets/monto.png": "4777c1a3baed44d6f88267f4cfe93329",
"assets/assets/Tasa%2520de%2520interes%2520de%2520retorno.png": "ccdb266e365d7da3fe86bcaad2a5841a",
"assets/assets/Tasa%2520interes.png": "7ff90d0b54531885504e0214bb96e40f",
"assets/assets/tiempo.png": "99e11ccc47487ec5c06ee7e3824e320b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "f10263b20d598a5567a63b4783659802",
"assets/NOTICES": "5c4fc71ad2e7f0a2867197050195908b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "7737f5fc722b6a040ac15271ea8d92fb",
"canvaskit/canvaskit.js.symbols": "8fa5e10d3db4295440a1cd175fcbc996",
"canvaskit/canvaskit.wasm": "35d8bc64864dc53a8ba474636f313b23",
"canvaskit/chromium/canvaskit.js": "2f82009588e8a72043db753d360d488f",
"canvaskit/chromium/canvaskit.js.symbols": "98d498798652af403238ec4ec99c974f",
"canvaskit/chromium/canvaskit.wasm": "7989c5dd662b4fccf10389ff3f091002",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "21cd8369f306d2b764da972d2cc35021",
"canvaskit/skwasm.wasm": "e74b0f9b618bd43d7da1d5eb6e87ac70",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "4af2b91eb221b73845365e1302528f07",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f898084f2e549560e93dcb61871f1cb8",
"/": "f898084f2e549560e93dcb61871f1cb8",
"main.dart.js": "a040e27876955c486acecab7f94932de",
"manifest.json": "bd868d2281c1799ad708cae53631e1f5",
"version.json": "a3b547373a0a99cae5dce2a565b1dafc"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
