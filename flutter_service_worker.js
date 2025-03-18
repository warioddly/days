'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"main.dart.mjs": "e4164bbfcef411a01f30e437e0c3d21a",
"index.html": "56257ca0abd19111002afd0c75af5ec8",
"/": "56257ca0abd19111002afd0c75af5ec8",
"assets/NOTICES": "5973e9692f4353abb8b38c9027a748b1",
"assets/assets/images/warioddly.png": "94fb9557aa7eea153d47426bd90be576",
"assets/assets/images/icons/illustrations/Hi%2520Bubble.png": "1d0cf0a1091487febcd6f79b187824d8",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25203.png": "3c67945fbd28e994a3f296c9da8b3894",
"assets/assets/images/icons/illustrations/Globe%2520Banner.png": "c4820a14233c58315986f9cf732b7a25",
"assets/assets/images/icons/illustrations/Heart-8.png": "968751d6b6c07a44bf9ad97493c5be01",
"assets/assets/images/icons/illustrations/Heart%2520Bubble.png": "0f447d1bd859c8027938d5fcef1dcf51",
"assets/assets/images/icons/illustrations/Circle-1.png": "da68a6ef1c1becc83a5cb49a5b50c27a",
"assets/assets/images/icons/illustrations/Bubble-3.png": "488afe25d8b4320d06abc10ac24c19b3",
"assets/assets/images/icons/illustrations/Palm%2520Tree.png": "edd0a2e1130e3adede232ab1af503fd7",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25201.png": "d600b71c119efe56542152a7bc0274d3",
"assets/assets/images/icons/illustrations/Feather-3.png": "0b6028565742711f7e2222b1d23a2f81",
"assets/assets/images/icons/illustrations/Floral-2.png": "2444e76e81184a2dcb9566ec4df194d6",
"assets/assets/images/icons/illustrations/Flower%2520Pot-2.png": "1060f74426f835f81bbe9c36ddb2aafe",
"assets/assets/images/icons/illustrations/Signal%2520Stream.png": "c059d2dc7f0144541a72c12a65cbada0",
"assets/assets/images/icons/illustrations/Pyramid.png": "01d3f2eecd0cb4b1c858b73e650ae1f5",
"assets/assets/images/icons/illustrations/Cloud%2520Sun.png": "d6ec84cdffd71544644886255249cefe",
"assets/assets/images/icons/illustrations/Sphere-1.png": "07bcb1f3f4e24e20629765e3cc4ce7e9",
"assets/assets/images/icons/illustrations/Feather-4.png": "12e66fe64551de281fdf0c9bd06487af",
"assets/assets/images/icons/illustrations/leaf-1.png": "348832dcc801f84ac7d225ca2ae1ccc1",
"assets/assets/images/icons/illustrations/Crown.png": "ca0c3816c587ff0f71c35730f68a5b24",
"assets/assets/images/icons/illustrations/15.png": "ca705985170e1ccf6693a5a45ebab836",
"assets/assets/images/icons/illustrations/Star%2520Dots.png": "d1993109cc78e712eab8af3ad8f38aad",
"assets/assets/images/icons/illustrations/Clock.png": "f5562bfe8104b590921e6ac28d088e69",
"assets/assets/images/icons/illustrations/Floral%2520Banner.png": "4a83c2ec7802047a6d9191412e216970",
"assets/assets/images/icons/illustrations/Moon.png": "78deb131b4fe6bd25717dc6bb3867d59",
"assets/assets/images/icons/illustrations/Strawberry.png": "449bbf2c9a331ff3bc432aa8ed512102",
"assets/assets/images/icons/illustrations/Feather-2.png": "642f3d798600860361f05af77de0c19a",
"assets/assets/images/icons/illustrations/Floral-3.png": "73b71ed79917ae1e5a47b98ca82cde17",
"assets/assets/images/icons/illustrations/Sun.png": "afbf9ab141ed439a187122160a6c19bb",
"assets/assets/images/icons/illustrations/Sphere.png": "bdb230c004a803fa3337967246060a73",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25205.png": "36fcbae29ada72653a80a8f6800602fa",
"assets/assets/images/icons/illustrations/Bubble-4.png": "9b82f1c5c28ed98361909e26fce1ac58",
"assets/assets/images/icons/illustrations/Cloud-4.png": "ce85fc7b283a2fe404a5fd2cfd9d2bac",
"assets/assets/images/icons/illustrations/Stripe-1.png": "73ec099ff632f93fff801c8ac33ebaf6",
"assets/assets/images/icons/illustrations/Floral.png": "ffbfa37f650f3d55bea862e72a05d998",
"assets/assets/images/icons/illustrations/Cloud%2520Bubble-3.png": "92696181873ba862c18a80b73b4dc5c6",
"assets/assets/images/icons/illustrations/Heart-2.png": "ef73f2cc4ec7e747aa4cde674a61e79e",
"assets/assets/images/icons/illustrations/Swamp.png": "0ed8f14febd992ef83dcc023c92aa5cb",
"assets/assets/images/icons/illustrations/20.png": "ccc86642d0526b53d0dbe839ec4fec9d",
"assets/assets/images/icons/illustrations/11.png": "8b4dff8450a07cb89e2fb12ffa80ca82",
"assets/assets/images/icons/illustrations/Sun-3.png": "d178fc1a6a88546aca7e2c59b7eb78b6",
"assets/assets/images/icons/illustrations/Union.png": "3624771fe5ea6f3368629fe39261349d",
"assets/assets/images/icons/illustrations/Socks.png": "f47e5a74c9fd9c3b107a9a49c742954a",
"assets/assets/images/icons/illustrations/Cloud-1.png": "bdeed1832403528d229c95f34d1757de",
"assets/assets/images/icons/illustrations/Sun-6.png": "b253fd45e04a0aa1755ca4296c4295e4",
"assets/assets/images/icons/illustrations/Heart-4.png": "71eab38837a9121824179a2781b88196",
"assets/assets/images/icons/illustrations/Moon-1.png": "00efa7bd6af4aea55b641e619f096924",
"assets/assets/images/icons/illustrations/Tree.png": "6c00881f3c71a38a5200073729079702",
"assets/assets/images/icons/illustrations/Pyramid-1.png": "13ce840ba9957270e9e2cdbd9bd11f36",
"assets/assets/images/icons/illustrations/Flower%2520Cup.png": "08093f19e6c1d7ed56c55e0d93ad4a62",
"assets/assets/images/icons/illustrations/Bubble-6.png": "28555020297da12a2495c678baf853f6",
"assets/assets/images/icons/illustrations/Cupcake-1.png": "9d9fa13843a30d8960f4f5ed20f61cf7",
"assets/assets/images/icons/illustrations/Circle.png": "cd6038350038394d0353dbb98982760b",
"assets/assets/images/icons/illustrations/Water%2520Drop.png": "4e9fa2e0e6ee02e009804223564001b6",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25204.png": "ecf91fe1d2f5cfa9900daa419cdd5bc6",
"assets/assets/images/icons/illustrations/Cactus.png": "18697ad386691a62a120ad9d396e486f",
"assets/assets/images/icons/illustrations/Menu%2520Bars.png": "4a742be3e3f64167db2cd63d5c61ea24",
"assets/assets/images/icons/illustrations/Heart-3.png": "787a7903e8f5844abe28b1b8b93184e0",
"assets/assets/images/icons/illustrations/Cloud-3.png": "6b4a231d591ac6ca840cfc1379ffaa94",
"assets/assets/images/icons/illustrations/Spark.png": "a08262bcca65ed22959ab81385cd78ea",
"assets/assets/images/icons/illustrations/Likes.png": "3561a729852456998166b6f6e563b424",
"assets/assets/images/icons/illustrations/Stripe.png": "51368814d9216cbee2e116d7f641c6f4",
"assets/assets/images/icons/illustrations/Pyramid-2.png": "ebb3d03763ed4094e46e1dc66f6a2858",
"assets/assets/images/icons/illustrations/Wind.png": "67c3163a5eff44b0e487d642f41ce7ca",
"assets/assets/images/icons/illustrations/Cloud%2520Sun-1.png": "a2973a24b8cb45bc13baa50a782353fa",
"assets/assets/images/icons/illustrations/Globe-2.png": "87d34abf60a86bb81662ecc3d015536d",
"assets/assets/images/icons/illustrations/Dizziness-1.png": "5fb6126ca30ce7866015dfbb9eec8496",
"assets/assets/images/icons/illustrations/Sun-1.png": "d4ec9c96fdbfb4874fe7c3b526009f8b",
"assets/assets/images/icons/illustrations/Cupcake.png": "20426bb5f7cb482811fdca201883f90f",
"assets/assets/images/icons/illustrations/6.png": "2f2e3daa801f9f3515d4f7b82fd52556",
"assets/assets/images/icons/illustrations/Boot.png": "abce0d64fcf180c946359cbe03ffcd1b",
"assets/assets/images/icons/illustrations/10.png": "c4424be861df5e3c1d48655ef92d3a75",
"assets/assets/images/icons/illustrations/Heart%2520Bubble-4.png": "ee41ed0c02b29bb6d81c4183f018bb63",
"assets/assets/images/icons/illustrations/13.png": "e12f3fc5fa3565b2addfd669fdfa06de",
"assets/assets/images/icons/illustrations/Cloud-2.png": "84c16f5d96711153a778923c8b6f1298",
"assets/assets/images/icons/illustrations/Rain-1.png": "7af529272195e795548aee8127442f20",
"assets/assets/images/icons/illustrations/7.png": "c97fffe29a597ecd30a8b57deeb25014",
"assets/assets/images/icons/illustrations/Sun-2.png": "9b8a30af3fe4d65cc4ff1e35662235a9",
"assets/assets/images/icons/illustrations/Heart.png": "0cf4b5d601279a1008a8bcbccb513630",
"assets/assets/images/icons/illustrations/Feather-1.png": "b0fd18a67a071bbaee8321c9097452dd",
"assets/assets/images/icons/illustrations/Cloud%2520Bubble-1.png": "84cd3ef7df6c6c8532e239e8a3bf5356",
"assets/assets/images/icons/illustrations/Leaf-2.png": "6047c1da9f10d8364a39986285e6aced",
"assets/assets/images/icons/illustrations/5.png": "f6debb08da3c6919dd4cbd79ff9e4755",
"assets/assets/images/icons/illustrations/Flower%2520Pot.png": "817dcda02f5a368e0809015cb75170fe",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25206.png": "0079e5e3b45af6dc3b02250e17b1dad2",
"assets/assets/images/icons/illustrations/Bubble-2.png": "899f01837cb821208e162857e3453b92",
"assets/assets/images/icons/illustrations/Ship.png": "519f0439d5b7665a352322208ebf4a51",
"assets/assets/images/icons/illustrations/Like.png": "8fc6e355ad8594688c9e4d863e474cb6",
"assets/assets/images/icons/illustrations/Flower-2.png": "941e7a2a8cbda5aca38de1575389c7c0",
"assets/assets/images/icons/illustrations/Rss.png": "f6871ef3ed4e47306beb502e88a183ef",
"assets/assets/images/icons/illustrations/Flower.png": "a30d1fb7d09d07d8c3187ef99a7a0dc5",
"assets/assets/images/icons/illustrations/Heart-9.png": "efed40597598da6ff6bad22fc87baac4",
"assets/assets/images/icons/illustrations/Bubble-5.png": "06c83c36a33da54a4acc4ae26b397b41",
"assets/assets/images/icons/illustrations/Leaf-3.png": "d13418aa127b2b5156af58971621bfa0",
"assets/assets/images/icons/illustrations/Heart-5.png": "f5c05d30993c230742f7c3571cde779f",
"assets/assets/images/icons/illustrations/Sun-5.png": "14e961c2eff4e710c0863d12db7aa2c1",
"assets/assets/images/icons/illustrations/People.png": "50b5bae1cc2cc8514b0a770a5081c97d",
"assets/assets/images/icons/illustrations/Apple.png": "4aa8d778143f9806d64c4e6e93b44772",
"assets/assets/images/icons/illustrations/Heart%2520Bubble-3.png": "888b85271388dc7555ab5a0cd8df6e38",
"assets/assets/images/icons/illustrations/Heart-1.png": "efa65407b3d8795515f23564f39518eb",
"assets/assets/images/icons/illustrations/Heart-11.png": "d17328a6c9e03208173593b7a7606642",
"assets/assets/images/icons/illustrations/Leaf-4.png": "75505c63fd6aa650f33433fddb669892",
"assets/assets/images/icons/illustrations/Floral-1.png": "7c3af1931719716ea62bd1bc06e3bcfc",
"assets/assets/images/icons/illustrations/Wifi.png": "ed845bcb64707aec5f199b85483830a5",
"assets/assets/images/icons/illustrations/Bubble-1.png": "0e700e9f8b05274f35c9cbbb7d0f419d",
"assets/assets/images/icons/illustrations/Happy%2520Sun.png": "dc9a29eef78025b1e7af977d038007ec",
"assets/assets/images/icons/illustrations/Flower-3.png": "b6888fdd3c53816e43fd2ed05c962578",
"assets/assets/images/icons/illustrations/Flower%2520Pot-1.png": "8da5e1c734595d2a0f2f331f63a4b124",
"assets/assets/images/icons/illustrations/Flower-1.png": "f93e2c2f8861004200f59e8220912143",
"assets/assets/images/icons/illustrations/Comment%2520Question.png": "2f6c98148ab2483ec6c0663bcc078655",
"assets/assets/images/icons/illustrations/3.png": "4252d02041cdb1655dfc1b1d4d999ae2",
"assets/assets/images/icons/illustrations/Flower%2520-%2520Outline%2520-%25207.png": "0e8886f3595d835ade2b059a36874898",
"assets/assets/images/icons/illustrations/Indian.png": "6d90f9c734b7c8efd2114611d5e231b0",
"assets/assets/images/icons/illustrations/Weather%2520Report.png": "170126642a665f64d82f62514e552949",
"assets/assets/images/icons/illustrations/4.png": "0af30cb23b3758bb1d070959f335569d",
"assets/assets/images/icons/illustrations/Perfume.png": "e0d2cb7d0aba4a617d4ac3702476a638",
"assets/assets/images/icons/illustrations/Star.png": "f1a1a8b32e72fa6f8108d5f7e3474665",
"assets/assets/images/icons/illustrations/Sun-4.png": "c806b1b76304661eb2730cf62785cef4",
"assets/assets/images/icons/illustrations/Heart-6.png": "d3e14779065ad2515ef5bc5fbc4dcd42",
"assets/assets/images/icons/illustrations/Globe.png": "5fd8b38f6042af320cfad0b983a31020",
"assets/assets/images/icons/illustrations/Cherries.png": "60d44a8af333cd15ce65f48c883dca76",
"assets/assets/images/icons/illustrations/Heart-10.png": "f49dabf22e983760d42834082d59a19e",
"assets/assets/images/icons/illustrations/12.png": "6e4be3e203a6ec37e89199dae5fce338",
"assets/assets/images/icons/illustrations/leaf.png": "a966ba38d88eeec42ed8223ebcebd07f",
"assets/assets/images/icons/illustrations/French%2520Fries.png": "abc169e7c8cf1ec22088ba2f165cf802",
"assets/assets/images/icons/illustrations/Sun-7.png": "f651edea9ceb50a13de9f59c49819631",
"assets/assets/images/icons/illustrations/Planet.png": "ae74e9864fc03a08b9f079a09eb51b3d",
"assets/assets/images/icons/illustrations/svg/Star-2.svg": "0fddd9f603ee8e51a93ef3ddecd53826",
"assets/assets/images/icons/illustrations/svg/Exclamation%2520Questions%2520Bubble.svg": "84be7bd7daf294a3ba7d011ccd91ecd3",
"assets/assets/images/icons/illustrations/svg/Ship.svg": "a2d2101a32df86035753706303bb8561",
"assets/assets/images/icons/illustrations/svg/Sun-5.svg": "abc6818dd04d01b701a90697193263ea",
"assets/assets/images/icons/illustrations/svg/Flower%2520-%2520Outline%2520-%25205.svg": "01e78c577f094f384633c62ce1b3dc9f",
"assets/assets/images/icons/illustrations/svg/Heart-5.svg": "8259084146375b24720fd376fe0e9b36",
"assets/assets/images/icons/illustrations/svg/Cupcake-1.svg": "2fdab2f0fcf2fb11d36e07e645d7d59c",
"assets/assets/images/icons/illustrations/svg/Flower%2520Pot.svg": "90432d2ed4c5486655f3440d6e0ac0c3",
"assets/assets/images/icons/illustrations/svg/Flower%2520-%2520Outline%2520-%25203.svg": "ec570cb60fc7323d27c91efcc4fe40bc",
"assets/assets/images/icons/illustrations/svg/Comment%2520Question.svg": "ff0a4b7d026c094d21f7c3a9be44aa2d",
"assets/assets/images/icons/illustrations/svg/Globe%2520Banner.svg": "f79b75dae7d43c0cd1f49774a4131033",
"assets/assets/images/icons/illustrations/svg/Planet.svg": "e541513f72157ad305b4bcc97709b68e",
"assets/assets/images/icons/illustrations/svg/Flower-5.svg": "ab0e437e76506b5e46218f67e17a9e69",
"assets/assets/images/icons/illustrations/svg/Like-1.svg": "8a1984ecb04c8a8efbaf80b2ccf27485",
"assets/assets/images/icons/illustrations/svg/Flower-2.svg": "af5b9cb51cb8c56c4629ef4cb017b708",
"assets/assets/images/icons/illustrations/svg/Heart-7.svg": "7df117cdf924b04879eaa61113f13d89",
"assets/assets/images/icons/illustrations/svg/Flower%2520Cup.svg": "bfe18236eae20fd2f91dedc0f7c3f71d",
"assets/assets/images/icons/illustrations/svg/leaf.svg": "1b38864f27007ec235128d015370e6a3",
"assets/assets/images/icons/illustrations/svg/Leaf-5.svg": "58ae36370bbe922801e2ab6f200617d0",
"assets/assets/images/icons/illustrations/svg/Heart%2520Bubble-1.svg": "dbc6da8155685b44fb1de916c145dcf7",
"assets/assets/images/icons/illustrations/svg/Star.svg": "bd489683169d2e33958c4fdbe3f8d609",
"assets/assets/images/icons/illustrations/svg/Feather.svg": "37d887531fb408a0b3e0e18bdd438241",
"assets/assets/images/icons/illustrations/svg/Pizza-1.svg": "7f8108bf33731f477181cc9a3afa3e93",
"assets/assets/images/icons/illustrations/svg/French%2520Fries.svg": "2738105bcb3df852d65ff212abf716ce",
"assets/assets/images/icons/illustrations/svg/Cloud%2520Bubble-2.svg": "69d1841f8ce811d664a9b1a2b2fbcea7",
"assets/assets/images/icons/illustrations/svg/Bubble-4.svg": "d4f4f1cc1d13d1f47db3efe8273da18e",
"assets/assets/images/icons/illustrations/svg/Cloud%2520Bubble-3.svg": "cbf13f4b1a68c084ac0cfcbf16ac320a",
"assets/assets/images/icons/illustrations/svg/Cloud%2520Rainbow-1.svg": "58f3036f9ed8ee639cd050679eec36c0",
"assets/assets/images/icons/illustrations/svg/Socks.svg": "90a01fa40aeef4d700e2553232bd376c",
"assets/assets/images/icons/illustrations/svg/People.svg": "e7387fb4836a26364deb9b34b9c90959",
"assets/assets/images/icons/illustrations/svg/Heart%2520Bubble-3.svg": "52085ba2f9ed27f1a4fb9ce81f10fd08",
"assets/assets/images/icons/illustrations/svg/Globe-1.svg": "775ce60ad1410e42f92b6494eff1bd1f",
"assets/assets/images/icons/illustrations/svg/Dandelion.svg": "45b17a120267d4845010dedf4cafb112",
"assets/assets/images/icons/illustrations/svg/Stripe.svg": "5deca8703f07bba455f54c80a963b080",
"assets/assets/images/icons/illustrations/svg/Flower%2520-%2520Outline%2520-%25206.svg": "b3e76ac61fe9367e1ef3f030ec34715d",
"assets/assets/images/icons/illustrations/svg/Palm%2520Tree.svg": "fb0e8c14496f2a9ea23cfa59db39a536",
"assets/assets/images/icons/illustrations/svg/Happy%2520Sun.svg": "81b18e77a8302bb9f437f63e61753c56",
"assets/assets/images/icons/illustrations/svg/Leaf-4.svg": "d20c425c4e36a263a29744a426e4c38a",
"assets/assets/images/icons/illustrations/svg/Weather%2520Report.svg": "afdb113f70b9f56020910d52e07d19f0",
"assets/assets/images/icons/illustrations/svg/Bubble-2.svg": "b9aa75a4f9001f735064dd0fe90e94d0",
"assets/assets/images/icons/illustrations/svg/Sun-3.svg": "7ff34bd936fbdcb5b622f831cecd8b78",
"assets/assets/images/icons/illustrations/svg/Perfume.svg": "128b892465f505887570ea0b46b8aba8",
"assets/assets/images/icons/illustrations/svg/Globe-2.svg": "b7d0729d9525d3d79a5fa19da68931cb",
"assets/assets/images/icons/illustrations/svg/Sun-7.svg": "b3d34a0c151f5c6cf97447ee91474fe0",
"assets/assets/images/icons/illustrations/svg/Sphere-1.svg": "0257eb16e35bbbe393a76aa7586a37cd",
"assets/assets/images/icons/illustrations/svg/Sun-6.svg": "c2ba95ca8f49c4f920511fe31651b088",
"assets/assets/images/icons/illustrations/svg/20.svg": "17d0741ad6277f6a5c9f8a8b4453e737",
"assets/assets/images/icons/illustrations/svg/Flower.svg": "4ab065168b2c9468b7db9a85dd5e0d84",
"assets/assets/images/icons/illustrations/svg/Cactus.svg": "fc6500054e7057aada67f14ec60ada31",
"assets/assets/images/icons/illustrations/svg/Cloud%2520Bubble-1.svg": "9b590550373cd887853e2d9c6970b091",
"assets/assets/images/icons/illustrations/svg/Heart-3.svg": "f5de7d273411fd5218231b937af3be6d",
"assets/assets/images/icons/illustrations/svg/Cloud%2520Sun.svg": "ce9c58eea8f6940bc5a65300cd2c3355",
"assets/assets/images/icons/illustrations/svg/Exclamation%2520Bubble.svg": "7197ab0ee31175059047bb64f1a7a6a1",
"assets/assets/images/icons/illustrations/svg/Floral-2.svg": "d4f1c53f69dc7ee1c15c1d0ee1ce5c04",
"assets/assets/images/icons/illustrations/svg/Heart-10.svg": "323050295d913161ad8cff30a8bbc235",
"assets/assets/images/icons/illustrations/svg/Heart-4.svg": "28339c7b428f988d5be5e7ca2c00069c",
"assets/assets/images/icons/illustrations/svg/Cloud-4.svg": "43cdd8f0ea2c3b67deb5f1dcf592fcd7",
"assets/assets/images/icons/illustrations/svg/Feather-1.svg": "2931f356cfce2ef2c4da172a8562d45d",
"assets/assets/images/icons/illustrations/svg/Boot.svg": "538c7af46f830f044a274cc43c28778d",
"assets/assets/images/icons/illustrations/svg/Heart-11.svg": "06c5409a076412c4189f427a4ae161e0",
"assets/assets/images/icons/illustrations/svg/Clock.svg": "e5485353915885d9931c5f92ca753a07",
"assets/assets/images/icons/illustrations/svg/leaf-1.svg": "3613002a8c3911575dfc30e2cbd34814",
"assets/assets/images/icons/illustrations/svg/Sphere-2.svg": "0852aca752465e14d32cacb733fd3542",
"assets/assets/images/icons/illustrations/svg/Star%2520Dots.svg": "bb44496f4040b7da1d1a5903ad0fc057",
"assets/assets/images/icons/illustrations/svg/Heart.svg": "bd008e965cdc7a4018eb05c679ab6d05",
"assets/assets/images/icons/illustrations/svg/Cloud%2520Bubble.svg": "86a01f4edb3c015af16df367e69380fc",
"assets/assets/images/icons/illustrations/svg/Leaf-3.svg": "917c8f8ce8321ddf6af07c18a4115894",
"assets/assets/images/icons/illustrations/svg/Heart%2520Bubble.svg": "a59d8424a185b8b22b71f3a7a61a96a0",
"assets/assets/images/icons/illustrations/svg/Flower-3.svg": "249c4794216fbbcdf590b06675764c92",
"assets/assets/images/icons/illustrations/svg/Circle-1.svg": "fb4c1328887ffb684a080372f091f90c",
"assets/assets/images/icons/illustrations/svg/Sun-8.svg": "4cb9cdba8bdbdd21bbbb84a4a0e31c8b",
"assets/assets/images/icons/illustrations/svg/Floral%2520Banner.svg": "a852113350a3036a9da3f86b85ee1d53",
"assets/assets/images/icons/illustrations/svg/Cloud-2.svg": "abd7bf2dd79bcead262b7183cec3830e",
"assets/assets/images/icons/illustrations/svg/Apple.svg": "3b3439002f5fa12719bfa7df7f70fb4b",
"assets/assets/images/icons/illustrations/svg/Heart%2520Bubble-4.svg": "b73cfb4b81aa6b4d59945f28c0ee45cd",
"assets/assets/images/icons/illustrations/svg/Heart-1.svg": "88c32bc38ce682d8faf719ebac143368",
"assets/assets/images/icons/illustrations/svg/10.svg": "28044362f65ec346b2aeca158e739616",
"assets/assets/images/icons/illustrations/svg/Heart-2.svg": "df9e091bdb53be8e138ffaa2d87eadd7",
"assets/assets/images/icons/illustrations/svg/Sun-2.svg": "f831969b84c53fc87573e8b5eb3b4ff9",
"assets/assets/images/icons/illustrations/svg/Swamp.svg": "6545ea4501d32cc8041356d350311951",
"assets/assets/images/icons/illustrations/svg/Cloud%2520Sun-1.svg": "cf1f50b282273ade283ebd76d7f120c7",
"assets/assets/images/icons/illustrations/svg/Circle.svg": "fb0227db0b8571c83a9601c2be83fc64",
"assets/assets/images/icons/illustrations/svg/14.svg": "a114a63c0869957d108eab0f069c8dd7",
"assets/assets/images/icons/illustrations/svg/Bubble-3.svg": "b7ef5d4530f2f02228d330a0e9e27626",
"assets/assets/images/icons/illustrations/svg/Pyramid.svg": "4385e6678401759f363d5d0c826c2d4b",
"assets/assets/images/icons/illustrations/svg/Heart-9.svg": "e0ce402f83df24f5cb298c0b7ea754a5",
"assets/assets/images/icons/illustrations/svg/Bolt.svg": "75abc32e00095fc335479d36503bbfec",
"assets/assets/images/icons/illustrations/svg/Cloud%2520Rainbow.svg": "99631cd4f1e1f611a941b9cbf3e90753",
"assets/assets/images/icons/illustrations/svg/Pizza.svg": "75496a09cbbf6874a9521cc44f63da66",
"assets/assets/images/icons/illustrations/svg/Pyramid-2.svg": "32e8c6f6c1bb96a8f3df93c871e07213",
"assets/assets/images/icons/illustrations/svg/Strawberry.svg": "af110eddc81f45a603c1190d87455ee8",
"assets/assets/images/icons/illustrations/svg/5.svg": "905304d8d302bb4d740781bcaba1e361",
"assets/assets/images/icons/illustrations/svg/4.svg": "c4190dfe6f2729f0b9092d209f96fac2",
"assets/assets/images/icons/illustrations/svg/Like.svg": "99ac71e386070dbeb2909018177e7f54",
"assets/assets/images/icons/illustrations/svg/Flower-1.svg": "e846870d0bd479dd55070d3ab0983195",
"assets/assets/images/icons/illustrations/svg/Cloud-1.svg": "9fcf188d3d321ea7c8eb0f2c0f3577ef",
"assets/assets/images/icons/illustrations/svg/Moon-1.svg": "840b0f22112edc00b72583f3cf1f60f4",
"assets/assets/images/icons/illustrations/svg/Wifi.svg": "40b5be998102835b3fb23909dcd135b0",
"assets/assets/images/icons/illustrations/svg/Bubble-5.svg": "812bebb6877a07b08223455577ea3612",
"assets/assets/images/icons/illustrations/svg/Cloud.svg": "b7288da702f036c490e8d2ced919b0a1",
"assets/assets/images/icons/illustrations/svg/Floral-3.svg": "4c1e2f07acd050b021311700e0ea80fb",
"assets/assets/images/icons/illustrations/svg/2.svg": "634879de380ee2a9cde145ecf49fe850",
"assets/assets/images/icons/illustrations/svg/Union.svg": "c2cf528608435e155e96c68eed4c4d52",
"assets/assets/images/icons/illustrations/svg/Sun.svg": "25dfc174dd22729695d38a5e92cd9ed4",
"assets/assets/images/icons/illustrations/svg/Moon.svg": "6dce5732cb3431916e24dc7d1fc85db0",
"assets/assets/images/icons/illustrations/svg/Cherries.svg": "299d3183b54604e508d9637f75cde321",
"assets/assets/images/icons/illustrations/svg/Heart%2520Bubble-2.svg": "0e16133ce6dcd08e00685cf77b19b715",
"assets/assets/images/icons/illustrations/svg/Feather-3.svg": "68fcb06a21a41132fc2310238134c76d",
"assets/assets/images/icons/illustrations/svg/Cloud-3.svg": "fcacd9da3fc74ec76ca77377c2b4bfe8",
"assets/assets/images/icons/illustrations/svg/Shield.svg": "716b79a4d6279a444ec010b369b0e045",
"assets/assets/images/icons/illustrations/svg/Box-1.svg": "8bb20b17c065f821ec116a8d44909807",
"assets/assets/images/icons/illustrations/svg/Flower%2520-%2520Outline%2520-%25204.svg": "35784d7e4eefe269ceacd806b091fd1b",
"assets/assets/images/icons/illustrations/svg/3.svg": "ce0b743ea0e4c644da034603891be6b6",
"assets/assets/images/icons/illustrations/svg/Spark.svg": "9a301c1493c861ea9293e26f928887bf",
"assets/assets/images/icons/illustrations/svg/6.svg": "b2209cb8af0abc83e4956cb5ef9f5987",
"assets/assets/images/icons/illustrations/svg/Box.svg": "2496dad095dd23ffb0682a0e67920691",
"assets/assets/images/icons/illustrations/svg/Signal%2520Stream.svg": "b54e657eea752678b33db713a3b5127d",
"assets/assets/images/icons/illustrations/svg/Globe.svg": "278122180b422dc9dc7ca9a8e2ef1392",
"assets/assets/images/icons/illustrations/svg/Cupcake.svg": "f827c408c14be5a21694dd5918ec6c8b",
"assets/assets/images/icons/illustrations/svg/Flower-6.svg": "7a79169c1ccca12ce4a1c24d692571ad",
"assets/assets/images/icons/illustrations/svg/Feather-2.svg": "0cc181f8230942a4f83931b44eed8711",
"assets/assets/images/icons/illustrations/svg/Heart-6.svg": "ec781d6bc28532bbfad38135c7d40310",
"assets/assets/images/icons/illustrations/svg/13.svg": "5334cd630be09f32379baf25aa4d5abb",
"assets/assets/images/icons/illustrations/svg/8.svg": "03f4ed75c647750a6a6d7f507f793d62",
"assets/assets/images/icons/illustrations/svg/Flower%2520-%2520Outline%2520-%25201.svg": "6ccf290dd4e0a341cd515565a79c7f10",
"assets/assets/images/icons/illustrations/svg/Sun-4.svg": "4d4a7e6119f31447216b93d07e6cf7c5",
"assets/assets/images/icons/illustrations/svg/Search.svg": "de259497135869c1076aaf889c73653f",
"assets/assets/images/icons/illustrations/svg/Bubble-7.svg": "ecca3243bfa697db870c1f7c08e5e228",
"assets/assets/images/icons/illustrations/svg/Balloon.svg": "d924730cfbd3032aa915504d7d5ec62a",
"assets/assets/images/icons/illustrations/svg/Sun-1.svg": "f87fc7eed585ef5586df30e0488447ae",
"assets/assets/images/icons/illustrations/svg/7.svg": "683da03a47e9fe17c92d913445f885f4",
"assets/assets/images/icons/illustrations/svg/Likes.svg": "1ae1a90df91314bcabe46060028cddd1",
"assets/assets/images/icons/illustrations/svg/Water%2520Drop.svg": "d868d742da901e246dc514a280c8500c",
"assets/assets/images/icons/illustrations/svg/Floral-1.svg": "5127feb2eeeb5cd0e7ed21f6e49e999e",
"assets/assets/images/icons/illustrations/svg/Rain-1.svg": "3d3590b6b9ee4eeccdee048e1da56a0c",
"assets/assets/images/icons/illustrations/svg/12.svg": "0c3a38036d78b0071fa04ae593aa9e21",
"assets/assets/images/icons/illustrations/svg/Dizziness-1.svg": "862f3ecad1baf24ba40deff38d52df47",
"assets/assets/images/icons/illustrations/svg/Flower%2520Pot-1.svg": "6a1f977444c94e0b3fb68a2cc3f45fd7",
"assets/assets/images/icons/illustrations/svg/Leaf-2.svg": "ebc8bc27713580ebad2a037194f6e4c4",
"assets/assets/images/icons/illustrations/svg/Tree.svg": "4429b8d4506f567df695819b16de4d5d",
"assets/assets/images/icons/illustrations/svg/Feather-4.svg": "1b1752968dd1e126bba6d9ceb6987082",
"assets/assets/images/icons/illustrations/svg/Indian.svg": "01222384d08974a2951ceeaa483ac463",
"assets/assets/images/icons/illustrations/svg/Flower%2520Pot-2.svg": "6ce7b9772ec015857d192f469aae64f7",
"assets/assets/images/icons/illustrations/svg/Star-1.svg": "6211c3c1336467b14cfd444d75ebe588",
"assets/assets/images/icons/illustrations/svg/Dizziness.svg": "639b5dfe463ab789a27c4ca5bca46303",
"assets/assets/images/icons/illustrations/svg/15.svg": "d3c31e64612fb7a7cb5b464e1972444e",
"assets/assets/images/icons/illustrations/svg/Heart-8.svg": "615bb63cd53f414798e907521f61c8aa",
"assets/assets/images/icons/illustrations/svg/Bubble.svg": "1e11835e20c055f95ff97359c34c6ec1",
"assets/assets/images/icons/illustrations/svg/Stripe-1.svg": "6a9842eebcc73f73c48d8388dd3f0db8",
"assets/assets/images/icons/illustrations/svg/Floral.svg": "b3cb48f04c6da9d0c6ea700a77e8e732",
"assets/assets/images/icons/illustrations/svg/Pyramid-1.svg": "c798e48edd343a3cdd1aa5b42b40f38d",
"assets/assets/images/icons/illustrations/svg/Flower-4.svg": "7d869b2b1dbed27463b94e0ecaadfd11",
"assets/assets/images/icons/illustrations/svg/Hi%2520Bubble.svg": "ec625a0d3e8171e495114e6a7b9371af",
"assets/assets/images/icons/illustrations/svg/Lightbulb.svg": "93c1e6b2db544db8cad319d767b6f30a",
"assets/assets/images/icons/illustrations/svg/Bubble-6.svg": "5b3f2b87e6d24f037a36f213cae50312",
"assets/assets/images/icons/illustrations/svg/Flower%2520Pot-3.svg": "50987ac6964488487f6a844e0a7d9315",
"assets/assets/images/icons/illustrations/svg/Crown.svg": "93c91b10147f326957c0198288d880d9",
"assets/assets/images/icons/illustrations/svg/Bubble-1.svg": "82d46388dd1a9026c638ddb87b0ad3fc",
"assets/assets/images/icons/illustrations/svg/Wind.svg": "6fb8b6cd754ddafc3294c081a6beef2a",
"assets/assets/images/icons/illustrations/svg/Rain.svg": "0c89221d1e9b9117be8fc594b0938057",
"assets/assets/images/icons/illustrations/svg/Menu%2520Bars.svg": "ea8e5aed15cef4646144a641936a6000",
"assets/assets/images/icons/illustrations/svg/Sphere.svg": "f81f58acd089175584d1e6d98adec1b9",
"assets/assets/images/icons/illustrations/svg/11.svg": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/images/icons/illustrations/svg/Flower%2520-%2520Outline%2520-%25207.svg": "5a9d6615ea3ee73bc666fa0e2088f3e2",
"assets/assets/images/icons/illustrations/svg/Rss.svg": "410411b24723171bdea6abc7a6b96388",
"assets/assets/images/icons/illustrations/Heart%2520Bubble-2.png": "041dddb2cd018b3986d6cc13aed3ce88",
"assets/assets/images/icons/illustrations/Bubble.png": "5525192675142eb8066dc2273c29be9e",
"assets/assets/images/icons/illustrations/Cloud.png": "a5c5c976588a959427956a86c47ce588",
"assets/assets/images/icons/illustrations/Shield.png": "a7a591745d20d80ba0120cec0dce9350",
"assets/assets/images/icons/illustrations/8.png": "ca8b1319beaeed2f814bdef3ed693318",
"assets/assets/images/icons/illustrations/Feather.png": "f95fb21021a9974e284403016dfcb492",
"assets/assets/images/icons/illustrations/Lightbulb.png": "c9d6efdf0854f1f1e4077525176248f0",
"assets/assets/images/icons/illustrations/14.png": "0876837ad8a8f2d716a612a770554349",
"assets/assets/images/icons/illustrations/Cloud%2520Rainbow.png": "ebb0e568c03491072570429a03f55603",
"assets/assets/images/icons/illustrations/2.png": "bf33582472b62a5a7934f9c4a900c171",
"assets/assets/images/icons/illustrations/Exclamation%2520Bubble.png": "b8d4f03928c0c2bb67bdb98edc19f0a1",
"assets/assets/images/icons/illustrations/Heart-7.png": "3bdde0cff2786d55f1b788fb4caf8e76",
"assets/assets/images/icons/illustrations/Pizza-1.png": "dc9bb5e2a10a874badc5e5033b38e342",
"assets/assets/images/icons/illustrations/Flower-5.png": "94b909413f62f4644e6e67ded97f25af",
"assets/assets/images/icons/illustrations/Flower%2520Pot-3.png": "89f27d76c5aaaab14db2e9aea73c0a6b",
"assets/assets/images/icons/illustrations/Rain.png": "85718de052b52eedba689a6941cce3ad",
"assets/assets/images/icons/illustrations/Like-1.png": "0bb38d0b5af1e9145377c603d9987cfa",
"assets/assets/images/icons/illustrations/Star-2.png": "2aa29f10be763fccc287002eaedc5db0",
"assets/assets/images/icons/illustrations/Box-1.png": "76d4a44754b7e845257aafaf8bfa207a",
"assets/assets/images/icons/illustrations/Exclamation%2520Questions%2520Bubble.png": "978e1ce1a278a2b8a2eb575d81dcfdee",
"assets/assets/images/icons/illustrations/Sphere-2.png": "6d53aa7a4ff3a7963076d12e772094b7",
"assets/assets/images/icons/illustrations/Bolt.png": "ff5af55ac17dc091e0018650aa917610",
"assets/assets/images/icons/illustrations/Flower-6.png": "084748736d898f1e2986cbacbdecac45",
"assets/assets/images/icons/illustrations/Balloon.png": "816a8da4509589276d3b0160b61580cb",
"assets/assets/images/icons/illustrations/Search.png": "99800a8e27639d8a604c982ecc43e4d0",
"assets/assets/images/icons/illustrations/Cloud%2520Bubble-2.png": "161f67436f81ac363e1c32be9f2350df",
"assets/assets/images/icons/illustrations/Box.png": "f6893a2493e195608709f80c7deddbb7",
"assets/assets/images/icons/illustrations/Dandelion.png": "f02edbcb58a3b2d9c035798f1cbea6c8",
"assets/assets/images/icons/illustrations/Cloud%2520Bubble.png": "2c4d73b00ad25397baefa332fdaddd54",
"assets/assets/images/icons/illustrations/Star-1.png": "85d5a69a22150f21d7bbdcec0200590b",
"assets/assets/images/icons/illustrations/Sun-8.png": "c4c0fdd08e2188bdb34bcd4c4650c483",
"assets/assets/images/icons/illustrations/Bubble-7.png": "d6a9d4277c320c201427858258152e41",
"assets/assets/images/icons/illustrations/Pizza.png": "9a081dc7331e4e8f2268612e9dcd51b7",
"assets/assets/images/icons/illustrations/Heart%2520Bubble-1.png": "809bd4cab5a669c390e635993e958331",
"assets/assets/images/icons/illustrations/Flower-4.png": "85e506b61562d4869cb376c700df541b",
"assets/assets/images/icons/illustrations/Dizziness.png": "05d021cc11ce1dd867c41b8b56f9b94f",
"assets/assets/images/icons/illustrations/Leaf-5.png": "a9fdb815afa3e065a001e7ea107d3e23",
"assets/assets/images/icons/illustrations/Globe-1.png": "d0664afbd5d47a5d1eed8260491c4968",
"assets/assets/images/icons/illustrations/Cloud%2520Rainbow-1.png": "6f974ec86b7bfe7e19714878a86cf828",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-Bold.ttf": "905455c99ecaff560f87ca42f904c0a8",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-Medium.ttf": "4780773bba5e260130580694d237c910",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-Regular.ttf": "12c7b5f81aa7ab4781673a2a4cf69b5c",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-SemiBold.ttf": "2c5f0890be62b29479ab1453e038fbbf",
"assets/assets/fonts/Chakra_Petch/ChakraPetch-Light.ttf": "3f9c4b4859854edd76044d5fd59f1cd8",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "c00b24c530b2e018c25ae416003507e3",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/FontManifest.json": "5e151460acf73a8bc0f9c45199137d88",
"assets/AssetManifest.bin.json": "d218938ebdc973849497e859928dfce7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e706fddb139754d4c33087b9568f4bcd",
"assets/AssetManifest.json": "8eb790267e4b7f51955294918dbcf00a",
"version.json": "9578fa262c8641ec8d327fbd69516829",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.ico": "20d5d738899fc3fa8a1f055557bd215d",
"main.dart.js": "9c17d1e902fe5cac9ba447f292df1e4e",
"icons/web-app-manifest-512x512.png": "64727ca59bb1b82105f15ae33ea733cf",
"icons/web-app-manifest-192x192.png": "78269e6b980771c5e71a73e3af3f65c1",
"manifest.json": "35ea94ecfba3dca5c680db8d51c704b3",
"main.dart.wasm": "2dd4f1979ede76bc6108476fcd93e62f",
"flutter_bootstrap.js": "34299db347602effdcf57a10ecba83a7"};
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
