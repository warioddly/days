'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"site.webmanifest": "053100cb84a50d2ae7f5492f7dd7f25e",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/logo.png": "eb044b63dd44c5885e791645d56f552e",
"manifest.json": "98a27eeb8c1c5a35710a2dc8f8b7ea32",
"main.dart.mjs": "1aff98d3303074737fbaded9749996b1",
"index.html": "7dfa7e6d37538a257cc01828017245a3",
"/": "7dfa7e6d37538a257cc01828017245a3",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "84fd09e184fbeaa68da350d33a94eb76",
"assets/assets/images/icons/illustrations/10.png": "c4424be861df5e3c1d48655ef92d3a75",
"assets/assets/images/icons/illustrations/Heart-1.png": "efa65407b3d8795515f23564f39518eb",
"assets/assets/images/icons/illustrations/Bubble-2.png": "899f01837cb821208e162857e3453b92",
"assets/assets/images/icons/illustrations/8.png": "ca8b1319beaeed2f814bdef3ed693318",
"assets/assets/images/icons/illustrations/Spark.png": "a08262bcca65ed22959ab81385cd78ea",
"assets/assets/images/icons/illustrations/3.png": "4252d02041cdb1655dfc1b1d4d999ae2",
"assets/assets/images/icons/illustrations/Heart-4.png": "71eab38837a9121824179a2781b88196",
"assets/assets/images/icons/illustrations/Stripe.png": "51368814d9216cbee2e116d7f641c6f4",
"assets/assets/images/icons/illustrations/Flower%2520Pot-2.png": "1060f74426f835f81bbe9c36ddb2aafe",
"assets/assets/images/icons/illustrations/Flower-5.png": "94b909413f62f4644e6e67ded97f25af",
"assets/assets/images/icons/illustrations/Cloud%2520Bubble-3.png": "92696181873ba862c18a80b73b4dc5c6",
"assets/assets/images/icons/illustrations/Star.png": "f1a1a8b32e72fa6f8108d5f7e3474665",
"assets/assets/images/icons/illustrations/Bubble-7.png": "d6a9d4277c320c201427858258152e41",
"assets/assets/images/icons/illustrations/Likes.png": "3561a729852456998166b6f6e563b424",
"assets/assets/images/icons/illustrations/Dizziness-1.png": "5fb6126ca30ce7866015dfbb9eec8496",
"assets/assets/images/icons/illustrations/Exclamation%2520Bubble.png": "b8d4f03928c0c2bb67bdb98edc19f0a1",
"assets/assets/images/icons/illustrations/Cloud%2520Bubble-2.png": "161f67436f81ac363e1c32be9f2350df",
"assets/assets/images/icons/illustrations/Search.png": "99800a8e27639d8a604c982ecc43e4d0",
"assets/assets/images/icons/illustrations/Heart-11.png": "d17328a6c9e03208173593b7a7606642",
"assets/assets/images/icons/illustrations/Shield.png": "a7a591745d20d80ba0120cec0dce9350",
"assets/assets/images/icons/illustrations/Hi%2520Bubble.png": "1d0cf0a1091487febcd6f79b187824d8",
"assets/assets/images/icons/illustrations/Floral-1.png": "7c3af1931719716ea62bd1bc06e3bcfc",
"assets/assets/images/icons/illustrations/Globe-2.png": "87d34abf60a86bb81662ecc3d015536d",
"assets/assets/images/icons/illustrations/Dandelion.png": "f02edbcb58a3b2d9c035798f1cbea6c8",
"assets/assets/images/icons/illustrations/Rss.png": "f6871ef3ed4e47306beb502e88a183ef",
"assets/assets/images/icons/illustrations/Cherries.png": "60d44a8af333cd15ce65f48c883dca76",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25205.png": "36fcbae29ada72653a80a8f6800602fa",
"assets/assets/images/icons/illustrations/Rain-1.png": "7af529272195e795548aee8127442f20",
"assets/assets/images/icons/illustrations/Star-1.png": "85d5a69a22150f21d7bbdcec0200590b",
"assets/assets/images/icons/illustrations/Like-1.png": "0bb38d0b5af1e9145377c603d9987cfa",
"assets/assets/images/icons/illustrations/Exclamation%2520Questions%2520Bubble.png": "978e1ce1a278a2b8a2eb575d81dcfdee",
"assets/assets/images/icons/illustrations/Heart%2520Bubble.png": "0f447d1bd859c8027938d5fcef1dcf51",
"assets/assets/images/icons/illustrations/Star%2520Dots.png": "d1993109cc78e712eab8af3ad8f38aad",
"assets/assets/images/icons/illustrations/Dizziness.png": "05d021cc11ce1dd867c41b8b56f9b94f",
"assets/assets/images/icons/illustrations/2.png": "bf33582472b62a5a7934f9c4a900c171",
"assets/assets/images/icons/illustrations/Flower.png": "a30d1fb7d09d07d8c3187ef99a7a0dc5",
"assets/assets/images/icons/illustrations/Palm%2520Tree.png": "edd0a2e1130e3adede232ab1af503fd7",
"assets/assets/images/icons/illustrations/Floral-3.png": "73b71ed79917ae1e5a47b98ca82cde17",
"assets/assets/images/icons/illustrations/Moon-1.png": "00efa7bd6af4aea55b641e619f096924",
"assets/assets/images/icons/illustrations/Globe.png": "5fd8b38f6042af320cfad0b983a31020",
"assets/assets/images/icons/illustrations/Bubble-3.png": "488afe25d8b4320d06abc10ac24c19b3",
"assets/assets/images/icons/illustrations/Heart%2520Bubble-1.png": "809bd4cab5a669c390e635993e958331",
"assets/assets/images/icons/illustrations/Feather-3.png": "0b6028565742711f7e2222b1d23a2f81",
"assets/assets/images/icons/illustrations/Floral-2.png": "2444e76e81184a2dcb9566ec4df194d6",
"assets/assets/images/icons/illustrations/Flower-1.png": "f93e2c2f8861004200f59e8220912143",
"assets/assets/images/icons/illustrations/Happy%2520Sun.png": "dc9a29eef78025b1e7af977d038007ec",
"assets/assets/images/icons/illustrations/Flower%2520Pot-3.png": "89f27d76c5aaaab14db2e9aea73c0a6b",
"assets/assets/images/icons/illustrations/Heart-6.png": "d3e14779065ad2515ef5bc5fbc4dcd42",
"assets/assets/images/icons/illustrations/Indian.png": "6d90f9c734b7c8efd2114611d5e231b0",
"assets/assets/images/icons/illustrations/Heart-2.png": "ef73f2cc4ec7e747aa4cde674a61e79e",
"assets/assets/images/icons/illustrations/Heart-9.png": "efed40597598da6ff6bad22fc87baac4",
"assets/assets/images/icons/illustrations/15.png": "ca705985170e1ccf6693a5a45ebab836",
"assets/assets/images/icons/illustrations/Cloud-3.png": "6b4a231d591ac6ca840cfc1379ffaa94",
"assets/assets/images/icons/illustrations/Feather-4.png": "12e66fe64551de281fdf0c9bd06487af",
"assets/assets/images/icons/illustrations/Sun.png": "afbf9ab141ed439a187122160a6c19bb",
"assets/assets/images/icons/illustrations/Star-2.png": "2aa29f10be763fccc287002eaedc5db0",
"assets/assets/images/icons/illustrations/Floral.png": "ffbfa37f650f3d55bea862e72a05d998",
"assets/assets/images/icons/illustrations/Sun-1.png": "d4ec9c96fdbfb4874fe7c3b526009f8b",
"assets/assets/images/icons/illustrations/Comment%2520Question.png": "2f6c98148ab2483ec6c0663bcc078655",
"assets/assets/images/icons/illustrations/Heart%2520Bubble-3.png": "888b85271388dc7555ab5a0cd8df6e38",
"assets/assets/images/icons/illustrations/Sun-4.png": "c806b1b76304661eb2730cf62785cef4",
"assets/assets/images/icons/illustrations/Flower-6.png": "084748736d898f1e2986cbacbdecac45",
"assets/assets/images/icons/illustrations/Cloud.png": "a5c5c976588a959427956a86c47ce588",
"assets/assets/images/icons/illustrations/Water%2520Drop.png": "4e9fa2e0e6ee02e009804223564001b6",
"assets/assets/images/icons/illustrations/Cloud%2520Rainbow.png": "ebb0e568c03491072570429a03f55603",
"assets/assets/images/icons/illustrations/Ship.png": "519f0439d5b7665a352322208ebf4a51",
"assets/assets/images/icons/illustrations/Globe%2520Banner.png": "c4820a14233c58315986f9cf732b7a25",
"assets/assets/images/icons/illustrations/Pyramid-2.png": "ebb3d03763ed4094e46e1dc66f6a2858",
"assets/assets/images/icons/illustrations/Strawberry.png": "449bbf2c9a331ff3bc432aa8ed512102",
"assets/assets/images/icons/illustrations/Bubble.png": "5525192675142eb8066dc2273c29be9e",
"assets/assets/images/icons/illustrations/Sun-7.png": "f651edea9ceb50a13de9f59c49819631",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25201.png": "d600b71c119efe56542152a7bc0274d3",
"assets/assets/images/icons/illustrations/Stripe-1.png": "73ec099ff632f93fff801c8ac33ebaf6",
"assets/assets/images/icons/illustrations/Leaf-3.png": "d13418aa127b2b5156af58971621bfa0",
"assets/assets/images/icons/illustrations/Floral%2520Banner.png": "4a83c2ec7802047a6d9191412e216970",
"assets/assets/images/icons/illustrations/4.png": "0af30cb23b3758bb1d070959f335569d",
"assets/assets/images/icons/illustrations/Sun-8.png": "c4c0fdd08e2188bdb34bcd4c4650c483",
"assets/assets/images/icons/illustrations/Signal%2520Stream.png": "c059d2dc7f0144541a72c12a65cbada0",
"assets/assets/images/icons/illustrations/Wind.png": "67c3163a5eff44b0e487d642f41ce7ca",
"assets/assets/images/icons/illustrations/Pizza-1.png": "dc9bb5e2a10a874badc5e5033b38e342",
"assets/assets/images/icons/illustrations/Heart%2520Bubble-2.png": "041dddb2cd018b3986d6cc13aed3ce88",
"assets/assets/images/icons/illustrations/Union.png": "3624771fe5ea6f3368629fe39261349d",
"assets/assets/images/icons/illustrations/Cloud%2520Sun.png": "d6ec84cdffd71544644886255249cefe",
"assets/assets/images/icons/illustrations/Rain.png": "85718de052b52eedba689a6941cce3ad",
"assets/assets/images/icons/illustrations/Boot.png": "abce0d64fcf180c946359cbe03ffcd1b",
"assets/assets/images/icons/illustrations/Sphere.png": "bdb230c004a803fa3337967246060a73",
"assets/assets/images/icons/illustrations/Heart-7.png": "3bdde0cff2786d55f1b788fb4caf8e76",
"assets/assets/images/icons/illustrations/Sphere-1.png": "07bcb1f3f4e24e20629765e3cc4ce7e9",
"assets/assets/images/icons/illustrations/14.png": "0876837ad8a8f2d716a612a770554349",
"assets/assets/images/icons/illustrations/11.png": "8b4dff8450a07cb89e2fb12ffa80ca82",
"assets/assets/images/icons/illustrations/Flower%2520Cup.png": "08093f19e6c1d7ed56c55e0d93ad4a62",
"assets/assets/images/icons/illustrations/Like.png": "8fc6e355ad8594688c9e4d863e474cb6",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25206.png": "0079e5e3b45af6dc3b02250e17b1dad2",
"assets/assets/images/icons/illustrations/Flower%2520Pot.png": "817dcda02f5a368e0809015cb75170fe",
"assets/assets/images/icons/illustrations/Heart-8.png": "968751d6b6c07a44bf9ad97493c5be01",
"assets/assets/images/icons/illustrations/Cloud%2520Rainbow-1.png": "6f974ec86b7bfe7e19714878a86cf828",
"assets/assets/images/icons/illustrations/Leaf-2.png": "6047c1da9f10d8364a39986285e6aced",
"assets/assets/images/icons/illustrations/Cloud%2520Bubble-1.png": "84cd3ef7df6c6c8532e239e8a3bf5356",
"assets/assets/images/icons/illustrations/Heart.png": "0cf4b5d601279a1008a8bcbccb513630",
"assets/assets/images/icons/illustrations/Apple.png": "4aa8d778143f9806d64c4e6e93b44772",
"assets/assets/images/icons/illustrations/Wifi.png": "ed845bcb64707aec5f199b85483830a5",
"assets/assets/images/icons/illustrations/Swamp.png": "0ed8f14febd992ef83dcc023c92aa5cb",
"assets/assets/images/icons/illustrations/Leaf-5.png": "a9fdb815afa3e065a001e7ea107d3e23",
"assets/assets/images/icons/illustrations/Bubble-6.png": "28555020297da12a2495c678baf853f6",
"assets/assets/images/icons/illustrations/Cloud-2.png": "84c16f5d96711153a778923c8b6f1298",
"assets/assets/images/icons/illustrations/Balloon.png": "816a8da4509589276d3b0160b61580cb",
"assets/assets/images/icons/illustrations/Flower-2.png": "941e7a2a8cbda5aca38de1575389c7c0",
"assets/assets/images/icons/illustrations/Box.png": "f6893a2493e195608709f80c7deddbb7",
"assets/assets/images/icons/illustrations/Tree.png": "6c00881f3c71a38a5200073729079702",
"assets/assets/images/icons/illustrations/Lightbulb.png": "c9d6efdf0854f1f1e4077525176248f0",
"assets/assets/images/icons/illustrations/Socks.png": "f47e5a74c9fd9c3b107a9a49c742954a",
"assets/assets/images/icons/illustrations/Bubble-5.png": "06c83c36a33da54a4acc4ae26b397b41",
"assets/assets/images/icons/illustrations/20.png": "ccc86642d0526b53d0dbe839ec4fec9d",
"assets/assets/images/icons/illustrations/Crown.png": "ca0c3816c587ff0f71c35730f68a5b24",
"assets/assets/images/icons/illustrations/7.png": "c97fffe29a597ecd30a8b57deeb25014",
"assets/assets/images/icons/illustrations/leaf.png": "a966ba38d88eeec42ed8223ebcebd07f",
"assets/assets/images/icons/illustrations/6.png": "2f2e3daa801f9f3515d4f7b82fd52556",
"assets/assets/images/icons/illustrations/Cloud-1.png": "bdeed1832403528d229c95f34d1757de",
"assets/assets/images/icons/illustrations/Circle-1.png": "da68a6ef1c1becc83a5cb49a5b50c27a",
"assets/assets/images/icons/illustrations/Leaf-4.png": "75505c63fd6aa650f33433fddb669892",
"assets/assets/images/icons/illustrations/Menu%2520Bars.png": "4a742be3e3f64167db2cd63d5c61ea24",
"assets/assets/images/icons/illustrations/French%2520Fries.png": "abc169e7c8cf1ec22088ba2f165cf802",
"assets/assets/images/icons/illustrations/Clock.png": "f5562bfe8104b590921e6ac28d088e69",
"assets/assets/images/icons/illustrations/Moon.png": "78deb131b4fe6bd25717dc6bb3867d59",
"assets/assets/images/icons/illustrations/Heart-10.png": "f49dabf22e983760d42834082d59a19e",
"assets/assets/images/icons/illustrations/Sphere-2.png": "6d53aa7a4ff3a7963076d12e772094b7",
"assets/assets/images/icons/illustrations/Planet.png": "ae74e9864fc03a08b9f079a09eb51b3d",
"assets/assets/images/icons/illustrations/Flower-3.png": "b6888fdd3c53816e43fd2ed05c962578",
"assets/assets/images/icons/illustrations/Cloud%2520Sun-1.png": "a2973a24b8cb45bc13baa50a782353fa",
"assets/assets/images/icons/illustrations/Cactus.png": "18697ad386691a62a120ad9d396e486f",
"assets/assets/images/icons/illustrations/Perfume.png": "e0d2cb7d0aba4a617d4ac3702476a638",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25207.png": "0e8886f3595d835ade2b059a36874898",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25204.png": "ecf91fe1d2f5cfa9900daa419cdd5bc6",
"assets/assets/images/icons/illustrations/Flower-4.png": "85e506b61562d4869cb376c700df541b",
"assets/assets/images/icons/illustrations/Flower%2520Pot-1.png": "8da5e1c734595d2a0f2f331f63a4b124",
"assets/assets/images/icons/illustrations/Heart-3.png": "787a7903e8f5844abe28b1b8b93184e0",
"assets/assets/images/icons/illustrations/leaf-1.png": "348832dcc801f84ac7d225ca2ae1ccc1",
"assets/assets/images/icons/illustrations/Cupcake.png": "20426bb5f7cb482811fdca201883f90f",
"assets/assets/images/icons/illustrations/Sun-2.png": "9b8a30af3fe4d65cc4ff1e35662235a9",
"assets/assets/images/icons/illustrations/Sun-3.png": "d178fc1a6a88546aca7e2c59b7eb78b6",
"assets/assets/images/icons/illustrations/Pyramid-1.png": "13ce840ba9957270e9e2cdbd9bd11f36",
"assets/assets/images/icons/illustrations/Bolt.png": "ff5af55ac17dc091e0018650aa917610",
"assets/assets/images/icons/illustrations/Cloud%2520Bubble.png": "2c4d73b00ad25397baefa332fdaddd54",
"assets/assets/images/icons/illustrations/13.png": "e12f3fc5fa3565b2addfd669fdfa06de",
"assets/assets/images/icons/illustrations/Pizza.png": "9a081dc7331e4e8f2268612e9dcd51b7",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25203.png": "3c67945fbd28e994a3f296c9da8b3894",
"assets/assets/images/icons/illustrations/Cloud-4.png": "ce85fc7b283a2fe404a5fd2cfd9d2bac",
"assets/assets/images/icons/illustrations/Pyramid.png": "01d3f2eecd0cb4b1c858b73e650ae1f5",
"assets/assets/images/icons/illustrations/Bubble-4.png": "9b82f1c5c28ed98361909e26fce1ac58",
"assets/assets/images/icons/illustrations/Sun-6.png": "b253fd45e04a0aa1755ca4296c4295e4",
"assets/assets/images/icons/illustrations/Sun-5.png": "14e961c2eff4e710c0863d12db7aa2c1",
"assets/assets/images/icons/illustrations/Heart%2520Bubble-4.png": "ee41ed0c02b29bb6d81c4183f018bb63",
"assets/assets/images/icons/illustrations/Circle.png": "cd6038350038394d0353dbb98982760b",
"assets/assets/images/icons/illustrations/Heart-5.png": "f5c05d30993c230742f7c3571cde779f",
"assets/assets/images/icons/illustrations/Globe-1.png": "d0664afbd5d47a5d1eed8260491c4968",
"assets/assets/images/icons/illustrations/Feather-1.png": "b0fd18a67a071bbaee8321c9097452dd",
"assets/assets/images/icons/illustrations/5.png": "f6debb08da3c6919dd4cbd79ff9e4755",
"assets/assets/images/icons/illustrations/Cupcake-1.png": "9d9fa13843a30d8960f4f5ed20f61cf7",
"assets/assets/images/icons/illustrations/Feather-2.png": "642f3d798600860361f05af77de0c19a",
"assets/assets/images/icons/illustrations/Box-1.png": "76d4a44754b7e845257aafaf8bfa207a",
"assets/assets/images/icons/illustrations/Bubble-1.png": "0e700e9f8b05274f35c9cbbb7d0f419d",
"assets/assets/images/icons/illustrations/Feather.png": "f95fb21021a9974e284403016dfcb492",
"assets/assets/images/icons/illustrations/12.png": "6e4be3e203a6ec37e89199dae5fce338",
"assets/assets/images/warioddly.png": "94fb9557aa7eea153d47426bd90be576",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-Medium.ttf": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-Bold.ttf": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-Regular.ttf": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-SemiBold.ttf": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-Light.ttf": "d41d8cd98f00b204e9800998ecf8427e",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/NOTICES": "f1211f3c8f2441d49d74af294eb9597a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e5b054e1607ecbc36a9e9a5278df4df3",
"assets/FontManifest.json": "8c9575393afbec7554c0f3b37cf8319d",
"assets/AssetManifest.bin": "029350c8e9d6efb3d9ccf58934c70b56",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"main.dart.wasm": "3870178c285748157bbe1ba1a1aac054",
"favicon.ico": "4a907c3a3227b2c13a7826582d7c47c8",
"flutter_bootstrap.js": "37a72e883093a953dcca029fd9049d99",
"version.json": "47a7f5cecb498f682d9fb6c0b2135fe9",
"main.dart.js": "1d5bcf4f253e3ee342d9230a7e3e4aa3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
