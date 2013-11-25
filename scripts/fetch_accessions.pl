use LWP::Simple;
# $gi_list = '5031669,140560917,211971072,22027538,14150155,140560917,150421681,45827729,54607139,115529486,41393547,57164942,51039802,194440727,12597641,114431236,7706706,260763890,155029546,7662078,149274648,4505573,223633995,4504643,154240677,8051579,38348729,17981704,15619008,4501885,32967601,239745083,56550039,75812966,222418637,45935385,189163501,23510381,4759128,62988328,207452735,82830424,14211536,19923274,16579888,40254931,183583553,62955833,112382250,169188544,4506913,55770834,157738649,21361583,6005846,238231392,310110430,238859593,34577118,110611228,5902010,267844826,28269693,226246523,29294649,206597539,194018484,32526901,4885563,45505167,4759140,197382841,7669550,7019485,7661788,15834617,257467652,120953300,34452705,198442844,56549123,115648142,222418565,148233596,150170670,4502371,299829223,31543385,116812586,238908503,13124765,4759050,47059046,46361983,157671937,154813193,38373675,256818774,15834619,21361863,4507033,23097308,52218872,52138523,134254443,5031561,148596984,110611228,4506671,126116589,27437015,291045225,114842389,171846278,87196343,23503313,54292123,7705704,21536485,254281232,226958575,48255945,116063534,119395718,4504379,31415870,118421089,119392094,4758578,57634534,113722120,50959191,4505487,89941470,18104993,15147234,94721327,156616290,31621309,153946395,154146189,120953300,22547221,52138513,310110428,55743161,116089284,4759128,169216516,23397672,4885397,134133279,4507829,29029550,19115954,49574502,52426735,38348408,5453978,19924175,14210504,38679890,118421085,45446740,90652855,239747141,119395754,22538461,7662470,4503591,21626468,24308089,9943848,31317309,5031593,239787758,291045225,38195080,269315880,13654239,38045919,148839305,24308163,262118216,54292123,148491057,117168250,5031755,310123118,55770888,16554449,221136781,41872631,119395758,191252801,150421681,155722983,56606127,310124069,88758615,117168273,20357585,110611233,21362105,194239713,4507157,32455236,37674210,50897852,30425510,187607300,154090997,23097308,110347463,256574792,291045225,149944474,16933542,134142062,9558721,4557485,169658378,171184451,118600967,31377806,40548403,21361792,134948558,7662184,302370985,7662342,94557299,35493701,197209826,4826898,11968023,30089935,47078235,148839305,95147555,38570107,4557757,239743562,62243652,10835121,197383077,19923613,115511036,21361794,25453472,88900507,4758032,51100978,226494053,18079218,120953300,4507947,4557757,156104903,44680141,282721148,21362096,18104967,4502629,38708324,56237021,157389005,148664209,153792466,148762969,260064009,148612811,27903825,61742784,300797344,4505229,6552299,44890065,19923790,4502169,199562283,167466264,255652953,13386490,4506431,17986273,33188443,45439359,122937255,4757732,38016957,195947365,222352129,40254823,27903825,140560917,282721148,5292161,38788260,270133251,5032179,118918403,21361553,4758862,23097308,182509178,45504380,50053795,4501881,4503579,14210514,33354279,134948558,21717810,19923050,42716275,31542743,46049063,23097308,38490688,59710107,33469966,172072597,156627571,153946395,115334673,226246523,197333755,4758950,27477113,24308043,5729945,157388917,4557471,156616290,55741473,77404397,27477041,87116683,260064009,5729730,4505023,215599570,4557032,124430557,54792088,32967601,157388989,111038120,13569901,7705885,229577247,38202205,5453603,13186234,56550039,4758148,157504499,31317290,148233596,157738667,7662126,52353286,41393573,4507163,56237029,116812593,134142062,4502709,156151377,310120620,15147337,66346693,50838795,4502371,163659918,58761500,7657134,4507943,310114449,165932370,150170658,77404397,31542634,5453974,6274550,149773449,115387094,56699482,33519450,186972143,50962882,33188463,21264602,40254823,76150623,53759103,21040324,21040314,4557269,93141047,297206791,122937398,62241003,5706731,105990539,148536830,21362032,41322908,4504281,38570111,109255232,6005812,4502081,4504251,71773480,217330656,194294556,187608784,34485727,42415492,7662320,39812229,4505541,16332358,24497612,223555935,115527082,11386139,116805342,119393876,23097308,4506107,28373065,310127828,7661744,4826976,62821790,5031877,7662126,5174617,16445029,57863301,32880208,118421085,41872673,157388917,157502201,115334682,226817313,4502301,89886456,4502505,110349786,291290994,13027826,118600979,28274709,256222019,118402578,118918403,4505039,299782571,222831610,4502599,38202205,127138957,130484567,310131806,22749363,46852166,44917619,115430255,218749820,57242774,197333755,225543461,52851437,153251865,31542650,5803181,4557485,115511036,7706557,154813193,17149828,291045225,45359842,89257346,27477105,206597472,6912642,16975496,259013213,41872673,13376259,14149627,41054864,156938257,157739942,40353736,194353993,187608784,11345454,41350333,154090997,140560917,256017245,21245134,167234419,148833504,153945790,5032281,87159829,19718741,34452681,4504491,226817313,4507635,45387947,8923885,4507109,148839466,26787968,116805322,119964726,21536476,23238222,145309300,46399198,4505733,20532340,132566536,7242140,25777600,31657117,4502169,226342869,4502629,134948558,10834994,31317309,169208214,38505161,153791670,18860833,300797344,226509740,291045225,85362735,110347400,221316676,117320537,217330646,7661960,217330568,46909590,226246554,195233774,5453603,149274648,39777586,288541299,21040263,30089940,126723564,209969690,27735029,11968023,4502173,162809334,56676335,46049092,157384998,22027541,4757818,149944474,30520335,5730023,156151441,188528644,164565366,226246554,80861396,153792694,310124069,297206791,38045919,38788135,191252806,90903231,281306733,52486265,5729877,223029410,4501881,118600963,4502499,38788260,211059439,41352697,28872725,32528291,73747799,146198654,18765694,5803221,7657595,8659555,219689123,112382257,61097912,169168870,110611237,13654237,310128164,224586838,33188443,24797103,21264602,145309300,145312251,36796743,91208426,157817023,57164942,223468608,47578105,148536844,52630429,222418565,5453726,19923274,23238228,157671951,10835121,188536004,19913428,55741473,36029914,4501891,150456415,157388914,55743151,153945846,21735572,288541299,189571664,155030226,4502629,18201905,22748853,31543140,38679960,5031699,118918403,190194365,148596992,222080100,19923584,116008442,13569901,238624122,46488937,5174501,41350333,57164942,157743252,58533182,7019381,5902010,21450808,151301013,48762685,147903302,22027632,9257190,291045225,251831107,119220552,222080066,197382841,4557817,110347427,223972612,16905367,310110278,73623035,167466169,38327029,4758532,4501919,76880486,42542394,23957690,187829418,45935385,33188443,40538772,170763479,157266317,126517478,89191868,116875763,166999098,239746114,7656922,224589129,157952215,291045225,118918409,10835000,6912674,239787919,153251840,28416940,91105174,16445031,4757982,110611228,27881501,112421108,4758696,7657269,310124454,28372499,109659845,213511508,164607124,189409150,23308733,292781435,10518506,41327764,28603838,30181236,155029546,51173715,21735572,21361792,30425420,21735572,116063573,21359963,150456444,5174617,70780353,157671929,4507651,4758754,4507883,5453904,4826898,45387945,18152771,148839305,94721248,63079718,291045225,33350932,21361348,45383011,75709192,148596992,226817313,38788260,36796743,20357585,145701005,23397696,54607135,110825984,90403614,4885583,55741567,6005926,53933280,11559929,4506323,118582255,46852390,4501887,7657106,239047271,15147248,21361278,310113358,14110407,24211017,11128031,158261990,163659918,32307128,31083099,21071060,4759300,205360987,116284392,21361077,153791300,149589008,153945790,134142826,21450675,31742476,194306650,4503253,238231392,52630447,45269141,19923931,122937382,145977194,87116683,4501881,118572613,19718762,19913408,291045225,148727286,4507691,38201638,29789008,217416392,19923981,4502263,20270305,5032133,16876441,117414162,296179427,42544136,270288733,33469141,5031711,94536788,7656967,32484979,4826932,34452705,4502443,38176149,21361684,291045225,4502111,22748929,19923729,239735519,21314600,187960059,148762969,34577049,44680143,41152506,13375827,27764882,13124875,21361114,14916483,50897852,238908524,118572588,33356170,149944526,57864582,5174623,262231746,310114449,118600975,170932494,40255149,118572613,4506765,215982794,16506820,302058305,19913408,37187860,57864582,50980309';
$gi_list = '24797099,50727002';

# 2::HBB_HUMAN
# 2::SSPA_STAAU
# 2::CO5_HUMAN
# 2::SSPA_STAAU

#assemble the URL
# $base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
# $url = $base . "efetch.fcgi?db=nucleotide&id=$gi_list&rettype=acc";

#assemble the URL
$base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
$url = $base . "efetch.fcgi?db=protein&id=$gi_list&rettype=acc";

#post the URL
$output = get($url);
print "$output";

