'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "2ac0fee6d53adaf135acd6973a45024e",
"/": "2ac0fee6d53adaf135acd6973a45024e",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.wasm": "b32a9969e65a7f573044b758f53ce3cf",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "85712bbf9dc9b01ec7be9a001e834c7c",
"canvaskit/chromium/canvaskit.js.symbols": "1a402b5f22e7bf3062421e850d025c3b",
"canvaskit/canvaskit.wasm": "59fddb8ae82f2156f987d6fce4584928",
"canvaskit/skwasm.js.symbols": "3f19809190a2866b6849ce17d97f26cc",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js.symbols": "4e057eda12866a5b55673b200c2ca372",
"favicon.png": "7851c9b40b3160b104193559acf5dc3f",
"assets/FontManifest.json": "1eb3ec7f4f2fbda10cadce0287ecf255",
"assets/fonts/MaterialIcons-Regular.otf": "64a18297ce8afcdce0b0d70e166c5f09",
"assets/AssetManifest.bin.json": "5d63509060f46c1764799bd8f5587284",
"assets/assets/Logo/Dino_Portal_Sakura_bg.png": "8cb1ca65deb1d29bb334733c83a5f8d7",
"assets/assets/Logo/dino_portal_color.png": "d78e6dfad9085679060cc975c2df40e7",
"assets/assets/Logo/DinoDengz%2520Logo%2520v1.svg": "fa69a2b21dc1ae037932532ddd6c9067",
"assets/assets/Logo/dinoLogo.png": "1664365f27cd28554d741308ae7026c0",
"assets/assets/Logo/dino_portal_colored_bg.png": "1664365f27cd28554d741308ae7026c0",
"assets/assets/Logo/dino_portal.png": "c2c757afa600d3c0588157feacfa23ed",
"assets/assets/Logo/dino_portal.svg": "4bf0a9c3135f1122e555bf39e573461e",
"assets/assets/images/Items/Fruits/kuayteaw.png": "0593e71055a1b9efaa35caa876023664",
"assets/assets/images/Items/Fruits/Apple.png": "de3dbfa7d33e6bb344d0560e36d8bf53",
"assets/assets/images/Items/Fruits/Collected.png": "0aa8cdedde5af58d5222c2db1e0a96de",
"assets/assets/images/Items/Fruits/Orange.png": "60e0f68620c442b9403a477bbe3588ed",
"assets/assets/images/Items/Fruits/Strawberry.png": "568a3f91b8f6102f1b518c1aba0e8e09",
"assets/assets/images/Items/Fruits/Pineapple.png": "0740bf84a38504383c80103d60582217",
"assets/assets/images/Items/Fruits/Bananas.png": "03466a1dbd95724e705efe17e72c1c4e",
"assets/assets/images/Items/Fruits/Cherries.png": "fc2a60aee885c33d0d10e643157213e4",
"assets/assets/images/Items/Fruits/Kiwi.png": "3d903dd9bf3421c31a5373b0920c876e",
"assets/assets/images/Items/Fruits/Melon.png": "eb6f978fbf95d76587bcf656c649540b",
"assets/assets/images/Items/Checkpoints/Checkpoint/Checkpoint%2520(Flag%2520Out)%2520(64x64).png": "c4730e5429a75691e2d2a9351c76738e",
"assets/assets/images/Items/Checkpoints/Checkpoint/Checkpoint%2520(No%2520Flag).png": "9126203dc833ec3b7dfb7a05e41910e5",
"assets/assets/images/Items/Checkpoints/Checkpoint/Checkpoint%2520(Flag%2520Idle)(64x64).png": "dd8752c20a0f69ab173f1ead16044462",
"assets/assets/images/Traps/Saw/Chain.png": "69669f8f421b508058cdf1232dc49e28",
"assets/assets/images/Traps/Saw/On%2520(38x38).png": "817477a39df8b330334e3866c1cb574b",
"assets/assets/images/Traps/Saw/Off.png": "66d27386fec46e0b052941957d9bdc22",
"assets/assets/images/Main%2520Characters/Patrick%2520(Boss)/Patrick%2520Hit%2520Next%2520Stage.png": "c8ab6fdc85b6a4618c814c9861987b1d",
"assets/assets/images/Main%2520Characters/Patrick%2520(Boss)/Patrick%2520Final%2520Form.png": "9e4a14188f7b4fa6fc13436e159a185a",
"assets/assets/images/Main%2520Characters/Patrick%2520(Boss)/Daddy%2520Patrick%2520Phase%25202.png": "32e2177226ea126153703ca7456f8aa9",
"assets/assets/images/Main%2520Characters/Patrick%2520(Boss)/Patrick%2520Hit%2520Damage.png": "bb15468e0619ffb05b9aef48c92f8cdf",
"assets/assets/images/Main%2520Characters/Patrick%2520(Boss)/Daddy%2520Patrick%2520Phase%25203.png": "296493437281cd50e0cf2adf29e2fe7d",
"assets/assets/images/Main%2520Characters/Patrick%2520(Boss)/Patrick%2520Final%2520Transforming%25202.png": "70dfb21d41c25b685f843aeb0f9c45bf",
"assets/assets/images/Main%2520Characters/Patrick%2520(Boss)/Daddy%2520Patrick%2520Phase%25201.png": "9686ca1dc47593c9636c2333c9353d13",
"assets/assets/images/Main%2520Characters/Patrick%2520(Boss)/Patrick%2520Final%2520Transforming%25201.png": "1c3b05097c1aac1af03185186de2ac5f",
"assets/assets/images/Main%2520Characters/Desappearing%2520(96x96).png": "1284313649da02eccc0d3ed6796996a3",
"assets/assets/images/Main%2520Characters/Player_charged_donut_shot%2520(16%2520x%252016).png": "3e4491ff503dd87b296c34ce5d9baee7",
"assets/assets/images/Main%2520Characters/Rocket%2520Relaxaurus/Hit%252032x32.png": "f2a24950656884972c1e6aa3eaa51f74",
"assets/assets/images/Main%2520Characters/Rocket%2520Relaxaurus/Died%252032x32.png": "0f9f83f626f261508d416e15edd54448",
"assets/assets/images/Main%2520Characters/Rocket%2520Relaxaurus/Idle%252032x32.png": "3b14c805e2abd6b3e46659997144e01d",
"assets/assets/images/Main%2520Characters/Relaxaurus/Run%2520(32x32).png": "621d19443c0d1bf07cba34184aaded85",
"assets/assets/images/Main%2520Characters/Relaxaurus/Idle%2520(32x32).png": "cbfcc5e1b9fc516f3c6a94966aceef93",
"assets/assets/images/Main%2520Characters/Relaxaurus/Jump%2520(32x32).png": "8f52d268b1737597bd01659d021b20c3",
"assets/assets/images/Main%2520Characters/Relaxaurus/Hit%2520(32x32).png": "088710982bc3c29fb6117da5efe3b63c",
"assets/assets/images/Main%2520Characters/Relaxaurus/Fall%2520(32x32).png": "8d7da798397540371d87d906621fde42",
"assets/assets/images/Main%2520Characters/Appearing%2520(96x96).png": "9449bf1f8d68ac08331aa091d6095e34",
"assets/assets/images/Opponent%2520(Patrick)/Run%2520(32x32).png": "d739b5f6153ebb7c1273d46487323af7",
"assets/assets/images/Opponent%2520(Patrick)/Idle%2520(32x32).png": "bb8dd5ea645cf2e200e78a0b5ba465e8",
"assets/assets/images/Opponent%2520(Patrick)/Hit%2520(32x32).png": "bb9002d2cb7c232135764be5060668a1",
"assets/assets/images/Background/Gray.png": "31fb9bc36ec926ee64d999d3387b7e09",
"assets/assets/images/Background/Space(64%2520x%252064).png": "74f1c25b9afd148844d1110aa5c57e52",
"assets/assets/images/Background/Blue.png": "f86e07aab82505fc49710152f83cc385",
"assets/assets/images/Background/Purple.png": "f8cc6aa8fd738e6e4db8b6607b7e6c37",
"assets/assets/images/Background/Level%2520cleared%2520white%2520screen.png": "b808899ce5338696a9eac6e17ff9943d",
"assets/assets/images/Background/DinoDengzz%2520Game%2520Over%2520Screen.png": "f91de7d08fa8facb03ad518b07f0af98",
"assets/assets/images/Background/Level%2520cleared%2520no%2520bg.png": "87983ac0e38d440be8765638035c6461",
"assets/assets/images/Background/Yellow.png": "c3f96416e21f366bc0c3635ce5b530d5",
"assets/assets/images/Background/DinoDengzz%2520Start%2520Screen.png": "24a6491bbf064c62edd5257f278073d0",
"assets/assets/images/Background/Brown.png": "45c9c887fa73b0ade76974de63ab9157",
"assets/assets/images/Background/Green.png": "e6eeace8a9d516f2e9768e5228e824fb",
"assets/assets/images/Background/Pink.png": "31b5e360eb9610c58138bb7cfdfb96a1",
"assets/assets/images/Background/Kuayteaw.png": "0cab9bc3a5f6fab6f2c9e5d9e44b6f01",
"assets/assets/images/HUD/Joystick.png": "0d48d554dbd23681dc2c3dc26d9ec0cc",
"assets/assets/images/HUD/Knob.png": "07acc29d4e539b9c402f4f1a57d9f4e0",
"assets/assets/images/HUD/JumpButton.png": "2aae75504af5dbea909cd93764ef527a",
"assets/assets/images/HUD/Setting.png": "bb5ae13bfd4f2f845a36fed9985638b5",
"assets/assets/images/DinoDengzz%2520Icon/Exit%2520button.png": "d7e436b07f30bc2fabd10f9da6891835",
"assets/assets/images/DinoDengzz%2520Icon/Plain%2520Back%2520Button.png": "69dca23774b5ff2dda028cad7d0e41e0",
"assets/assets/images/DinoDengzz%2520Icon/Next%2520level%2520button.png": "2a91df5c9630de1be576679b04ef7432",
"assets/assets/images/DinoDengzz%2520Icon/Quit%2520button%25202.0.png": "5d24dcd4a79807e612c212beb026459a",
"assets/assets/images/DinoDengzz%2520Icon/Boss%2520level%2520button.png": "6d64dc15d237b2bc41a0f1f3c7ab0c23",
"assets/assets/images/DinoDengzz%2520Icon/Black%2520restart%2520button.png": "c90c0d62b2035599af6895f7f6431d3d",
"assets/assets/images/DinoDengzz%2520Icon/Next%2520level%2520icon.png": "02d5edd1f25e5587d0e44fc02883a75e",
"assets/assets/images/DinoDengzz%2520Icon/Tutorial.png": "531a9985ee9f2746d3dd8d33c340b8d3",
"assets/assets/images/DinoDengzz%2520Icon/Sound%2520setting%2520full%2520options.png": "6878481354d8240cb10f8f82aa8acba2",
"assets/assets/images/DinoDengzz%2520Icon/Boss%2520level%2520button%2520enraged.png": "627b2f31c5713b43db59ec0d6c255fc8",
"assets/assets/images/DinoDengzz%2520Icon/Plain%2520background.png": "6c8cdaaac715d0880176f200c772f451",
"assets/assets/images/DinoDengzz%2520Icon/Setting%2520button.png": "9ea68ee075e7da9b34a042b5aa32972f",
"assets/assets/images/DinoDengzz%2520Icon/Select%2520Level%2520Screen.png": "22e4ef60e78a3a55415007eca89994ce",
"assets/assets/images/DinoDengzz%2520Icon/Boss%2520level%2520button%2520locked.png": "1d597fdfafb7c2a81eb41e458cc1d572",
"assets/assets/images/DinoDengzz%2520Icon/Sound%2520setting%2520no%2520line.png": "7e3773732d6ca72dc0492f660ec3cf6a",
"assets/assets/images/DinoDengzz%2520Icon/Red%2520restart%2520button.png": "66489748f244fb5119e613ba9f6a6010",
"assets/assets/images/DinoDengzz%2520Icon/Back%2520to%2520level%2520select%2520icon.png": "367f779d4cfec46a8708e86f95e61759",
"assets/assets/images/DinoDengzz%2520Icon/White%2520Back%2520Button.png": "da800c457df6fa6ee4924455770f2d51",
"assets/assets/images/DinoDengzz%2520Icon/Start%2520button.png": "351926eb38d808cab66ac456c40c6f2b",
"assets/assets/images/DinoDengzz%2520Icon/Restart%2520icon.png": "1b39a99053def67616fa655e138a00eb",
"assets/assets/images/DinoDengzz%2520Icon/Sound%2520setting%2520no%2520line%2520and%2520button.png": "9272bb85c42f84824988587063fbe0f2",
"assets/assets/fonts/Kanit-Regular.ttf": "ba95370355da928d1c09da6a0a49a1d6",
"assets/assets/Menu/Buttons/Play.png": "23f2b2a41eb467518bbfef795d876dc8",
"assets/assets/Menu/Buttons/Volume.png": "60060aab64ff40a0a996820f64a308b3",
"assets/assets/Menu/Buttons/Back.png": "661cfd0fdba294a951eb63c556684a64",
"assets/assets/Menu/Buttons/Levels.png": "5364f08108b6f75ff31b5b7c84f9789a",
"assets/assets/Menu/Buttons/Restart.png": "45fe1343f546485e8e288b122467f2fd",
"assets/assets/Menu/Buttons/Settings.png": "a56908d71e428647c51e73af372739ab",
"assets/assets/Menu/Buttons/Achievements.png": "b9bb58144606336efcd4862d35482f47",
"assets/assets/Menu/Buttons/Previous.png": "c63a3a14721d926b03801f38b81b66a6",
"assets/assets/Menu/Buttons/Close.png": "5c3a207383c5642288b01d314855a42a",
"assets/assets/Menu/Buttons/Leaderboard.png": "e3854b8ad5633b1f8017d08b7a783047",
"assets/assets/Menu/Buttons/Next.png": "2f75777c57c36c83c6140bbd7b97a5e1",
"assets/assets/Menu/Levels/05.png": "616f770983d550594de6dce58cdfd5b8",
"assets/assets/Menu/Levels/42.png": "13b602a32df5aae75a97615edc7c57a9",
"assets/assets/Menu/Levels/02.png": "08508f40b546910b1402b3112090f91b",
"assets/assets/Menu/Levels/20.png": "84affb6c644a02eeb2ca3289a4478f33",
"assets/assets/Menu/Levels/33.png": "682046f85570a44f0902dbc7583615bf",
"assets/assets/Menu/Levels/45.png": "d1153f6c9c605634f08a1f5e594e9260",
"assets/assets/Menu/Levels/40.png": "332ce8ae0ea6da6ce0dfe0dab7da5496",
"assets/assets/Menu/Levels/04.png": "1b53eb9a9fcb93f627f874626999b9eb",
"assets/assets/Menu/Levels/48.png": "768351a97acbbd8428ca33b073c7a866",
"assets/assets/Menu/Levels/25.png": "38f83ad87ce5b9e1033a9808b27232d0",
"assets/assets/Menu/Levels/30.png": "b9d3d9c462ea5f310879644dc22b90ca",
"assets/assets/Menu/Levels/06.png": "51a447ce69fcff71e80170c780f9c28f",
"assets/assets/Menu/Levels/03.png": "1f9f974b587331877eed69671dd0e4eb",
"assets/assets/Menu/Levels/34.png": "4fbd87c9be43814740cb1e07429183c4",
"assets/assets/Menu/Levels/46.png": "5e1bacd2980de985fe15bc3eac170f11",
"assets/assets/Menu/Levels/49.png": "e4482f7db83104af60eaf931a8b2b1c1",
"assets/assets/Menu/Levels/12.png": "04accdc4c4f1d3d280b68d470534a78f",
"assets/assets/Menu/Levels/38.png": "b765f20e7e7a16b59262a0ba5e245a20",
"assets/assets/Menu/Levels/50.png": "b87c87dec1916d3bee96ce69ec9fbb03",
"assets/assets/Menu/Levels/27.png": "40265837ef70a977c1acb2efe19b40b1",
"assets/assets/Menu/Levels/36.png": "0a3663508994f5a64b59b0fd318f8396",
"assets/assets/Menu/Levels/09.png": "baed976d717bd3d06dfee2ea39d78001",
"assets/assets/Menu/Levels/32.png": "4e1f62217b65790564c3f903b65e4637",
"assets/assets/Menu/Levels/22.png": "6ac40e97760aee2267872319a5ac1c06",
"assets/assets/Menu/Levels/26.png": "4c60a5b7b5675434f647d2964402a84f",
"assets/assets/Menu/Levels/35.png": "4ca4713c74ec75f1735473f080cbb1b0",
"assets/assets/Menu/Levels/39.png": "c889d1617a2130f2454ed940eb55e2a6",
"assets/assets/Menu/Levels/37.png": "dc22ace9201c806fdf9fc9cb438d5175",
"assets/assets/Menu/Levels/16.png": "fad064526892b2616b527a15bf77fe4c",
"assets/assets/Menu/Levels/29.png": "617b1485fcef9a94953b0608f6dd4215",
"assets/assets/Menu/Levels/08.png": "7cf0a9570d1e462911f42f3b53e050f7",
"assets/assets/Menu/Levels/19.png": "c976c40625f767184f1abe468db5f375",
"assets/assets/Menu/Levels/44.png": "1b9f7f955f3e615a21cf8198a6b8ed35",
"assets/assets/Menu/Levels/15.png": "54f287e88233a1920a1eb939d96e3b5b",
"assets/assets/Menu/Levels/21.png": "00647eca8e6ed0149fb651a55eed68d5",
"assets/assets/Menu/Levels/07.png": "c88c31a2ad1ec997f056c337bb14fd69",
"assets/assets/Menu/Levels/41.png": "1ec256afdf7de31a869bc88fddff9943",
"assets/assets/Menu/Levels/23.png": "c01e777908fc433e2f7e3d48a1af9ada",
"assets/assets/Menu/Levels/01.png": "d7f6549e6809bd7867b8eddd75e6bf21",
"assets/assets/Menu/Levels/43.png": "9526f399e906a5b10330d8b3a679a4d7",
"assets/assets/Menu/Levels/24.png": "6127aab3b8ff227fa95e49c8facf53d2",
"assets/assets/Menu/Levels/47.png": "30b54134f5a79564400ea90e451d7c18",
"assets/assets/Menu/Levels/10.png": "ce544e6879468566e1b066c7f19d56c2",
"assets/assets/Menu/Levels/14.png": "3ebc69f789c0e9dcee5cf8ab5824a11b",
"assets/assets/Menu/Levels/28.png": "b4f5454651b31f958f55ba10f2102662",
"assets/assets/Menu/Levels/11.png": "6ff53942f0ce0fcb9a306e580fa97f39",
"assets/assets/Menu/Levels/18.png": "4f675585ad0a1944e9fc80e5e6dcb486",
"assets/assets/Menu/Levels/17.png": "286c8805e99d6970b39b38f7be879b1f",
"assets/assets/Menu/Levels/31.png": "7332e2ccf70241eef0d3c837eba8560c",
"assets/assets/Menu/Levels/13.png": "493285cf2283a88931bc4d22bbe8e349",
"assets/assets/audio/Boss.mp3": "2ca6073e6e1dc7b521ea815f4157421a",
"assets/assets/audio/Disappear.mp3": "e52fe38d2f921e498a38a5019614b983",
"assets/assets/audio/Bgm.mp3": "4bd5c638c1e8ef1aec272d58df0fce62",
"assets/assets/audio/Hit.mp3": "771a1cce61e232bf5ea481743ea11aa0",
"assets/assets/audio/KT.mp3": "bcf68469c11b7bbe6dc0cd98e70ae387",
"assets/assets/audio/StarHit.mp3": "5655297139b2ea26430ad9e1f2db312b",
"assets/assets/audio/Collect.mp3": "3cfe3cd2fa23404be2faa98d49eabe5a",
"assets/assets/audio/Deng_Suu.mp3": "303e40289aa4f1a91c6b30f05d6546d7",
"assets/assets/audio/Over.mp3": "b87b3de6117eb7643b5a11e8aa16bfab",
"assets/assets/audio/laserShoot.mp3": "7ddd999b3f964cf7fbfa4fd4fb09cee5",
"assets/assets/audio/FinalBoss.mp3": "c79beaa7676e9690c7f5b4d9dcdc28ea",
"assets/assets/audio/Start_Screen.mp3": "aa0f34e902334a18d318a591b2bca031",
"assets/assets/tiles/Level-01.tmx": "8844c0c4076cacb06b12fa50c7c219eb",
"assets/assets/tiles/Level-03.tmx": "58da6b2b0f41ed12a746c626c16084d3",
"assets/assets/tiles/Level-04.tmx": "4279dba9bf156005d7b8c48d0527ad9d",
"assets/assets/tiles/Dino%2520Dengzz.tsx": "a0139e5b1e7cb83a64049ca6a0ebfdac",
"assets/assets/tiles/Level-02.tmx": "8b3e984bb02ca081465f7c18b2d32a02",
"assets/assets/tiles/Dino%2520Dengzz.tiled-project": "97165873765b29a5041f09e541be15d5",
"assets/assets/tiles/Dungeon.tsx": "b1085c154bc18016f0a348a502959f51",
"assets/assets/tiles/Dino%2520Dengzz.tiled-session": "139f42fd926debeb79923a3ddfda26a5",
"assets/assets/Terrain/Dungeon%2520(16x16).png": "2b95f226e86660dfcd3dcf3d71cf1525",
"assets/assets/Terrain/Terrain%2520(16x16).png": "df891f02449c0565d51e2bf7823a0e38",
"assets/AssetManifest.bin": "0f0401303dc7466bf9b6615604809073",
"assets/NOTICES": "9bd2cdb1aca969489bfd229bea144e08",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "86d11aad6b3e95e1cce3cbe7cf15dabd",
"version.json": "9e0881949a3552e772ed89b182547d13",
"icons/Icon-512.png": "e69b635436f933af662a68d00e5f36b4",
"icons/Icon-maskable-192.png": "469889db2a97a6160a9bdbbac020a905",
"icons/Icon-maskable-512.png": "e69b635436f933af662a68d00e5f36b4",
"icons/Icon-192.png": "469889db2a97a6160a9bdbbac020a905",
"manifest.json": "e39f507a24764273110ad51fe749946d",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "a5f57352930c268ed6fd83f40c6e99cd",
"main.dart.js": "1b05ee9f56fa5c228a78519edaa2de03"};
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
