class MeatInfoSource {
  final orders = ['소', '돼지'];
  final largeOrders_1 = [
    '안심',
    '등심',
    '채끝',
    '목심',
    '앞다리',
    '우둔',
    '설도',
    '양지',
    '사태',
    '갈비'
  ];
  final largeOrders_2 = [
    '안심',
    '등심',
    '목심',
    '앞다리',
    '갈비',
    '삼겹살',
    '뒷다리',
  ];

  final List<List<String>> tableData_1 = [
    ['안심살'],
    ['윗등심', '꽃등심', '아래등심', '살치살'],
    ['채끝살'],
    ['목심살'],
    ['꾸리살', '부채살', '앞다리살', '갈비덧살', '부채덮개살'],
    ['우둔살', '홍두깨살'],
    ['보섭살', '설깃살', '설깃머리살', '도가니살', '삼각살'],
    ['양지머리', '차돌박이', '업진살', '업진안살', '치마양지', '치마살', '앞치마살'],
    ['앞사태', '뒷사태', '뭉치사태'],
    ['본갈비', '꽃갈비', '참갈비', '갈빗살', '마구리', '토시살', '안창살', '제비추리'],
  ];

  final List<List<String>> tableData_2 = [
    ['안심살'],
    ['등심살', '등심덧살'],
    ['목심살'],
    ['앞다리살', '앞사태살', '항정살', '꾸리살', '부채살', '주걱살'],
    ['갈비', '갈비살', '마구리'],
    ['삼겹살', '갈매기살', '등갈비', '토시살', '오돌삼겹살'],
    ['볼기살', '설깃살', '도가니살', '홍두께살', '보섭살', '뒷사태살'],
  ];

  final Map<String, String> species = {
    "소": "cattle",
    "돼지": "pig",
  };

  final Map<String, String> cattleLarge = {
    '안심': 'tenderloin',
    '등심': 'sirloin',
    '채끝': 'striploin',
    '목심': 'chuck',
    '앞다리': 'blade',
    '우둔': 'round',
    '설도': 'bottom_round',
    '양지': 'brisket',
    '사태': 'shank',
    '갈비': 'rib',
  };

  final Map<String, String> pigLarge = {
    '안심': 'tenderloin',
    '등심': 'loin',
    '목심': 'boston_shoulder',
    '앞다리': 'picnic_shoulder',
    '갈비': 'spare_ribs',
    '삼겹살': 'belly',
    '뒷다리': 'ham',
  };

  final Map<String, String> cattleSmall = {
    '안심살': 'tenderloin',
    '윗등심': 'chuck_roll',
    '꽃등심': 'ribeye_roll',
    '아래등심': 'lower sirloin',
    '살치살': 'chuck_flap_tail',
    '채끝살': 'strip_loin',
    '목심살': 'chuck',
    '꾸리살': 'chuck_tender',
    '부채살': 'top_blade_muscle',
    '앞다리살': 'blade',
    '갈비덧살': 'blade_meat',
    '부채덮개살': 'top_blade_meat',
    '우둔살': 'inside_round',
    '홍두깨살': 'eye_of_round',
    '보섭살': 'rump_round',
    '설깃살': 'top_sirloin',
    '설깃머리살': 'top_sirloin_cap',
    '도가니살': 'knuckle',
    '삼각살': 'tri_tip',
    '양지머리': 'brisket',
    '차돌박이': 'brisket_point',
    '업진살': 'plate',
    '업진안살': 'inside_skirt',
    '치마양지': 'flank',
    '치마살': 'flap_meat',
    '앞치마살': 'apron',
    '앞사태': 'fore_shank',
    '뒷사태': 'hind_shank',
    '뭉치사태': 'heel_muscle',
    '본갈비': 'chuck_short_rib',
    '꽃갈비': 'boneless_short_rib',
    '참갈비': 'short_rib',
    '갈빗살': 'interconstal',
    '마구리': 'tirmmed_rib',
    '토시살': 'hanging_tender',
    '안창살': 'outside_skirt',
    '제비추리': 'neck_chain',
  };

  final Map<String, String> pigSmall = {
    '안심살': 'tenderloin',
    '등심살': 'loin',
    '등심덧살': 'sirloin',
    '목심살': 'boston_shoulder',
    '앞다리살': 'picnic_shoulder',
    '앞사태살': 'foreshank',
    '항정살': 'pork_jowl',
    '꾸리살': 'chuck_tender',
    '부채살': 'top_blade_muscle',
    '주걱살': 'spatula_meat',
    '갈비': 'rib',
    '갈비살': 'ribs',
    '마구리': 'tirmmed_rib',
    '삼겹살': 'belly',
    '갈매기살': 'skirt_meat',
    '등갈비': 'back_rib',
    '토시살': 'hanging_tender',
    '오돌삼겹살': 'odol_belly',
    '볼기살': 'buttok',
    '설깃살': 'top_sirloin',
    '도가니살': 'knuckle',
    '홍두께살': 'eye_of_round',
    '보섭살': 'rump_round',
    '뒷사태살': 'hind_shank',
  };
}
