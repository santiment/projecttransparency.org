BEGIN;

drop table if exists cmm_data;
CREATE TABLE cmm_data
(
    id serial NOT NULL,
    ticker character varying(255) NOT NULL,
    market_cap real NOT NULL,
    price_usd real NOT NULL,
    active integer NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO cmm_data VALUES (1,'BTC',61979400000,3755.73,1),(2,'ETH',29279800000,311.664,1),(3,'XRP',6793980000,0.177145,1),(4,'BCH',5431540000,329.409,1),(5,'LTC',2459810000,46.9194,1),(6,'XEM',2589410000,0.287712,1),(7,'ETC',1412250000,14.951,1),(8,'DASH',1545460000,206.409,1),(9,'MIOTA',1881930000,0.677067,1),(10,'STRAT',705603000,7.16347,1),(11,'XMR',713008000,47.7763,1),(12,'ANS',776540000,15.5308,1),(13,'QTUM',886864000,15.0316,1),(14,'BCC',650733000,101.319,1),(15,'EOS',483806000,1.74327,1),(16,'BTS',456590000,0.175761,1),(17,'WAVES',527375000,5.27375,1),(18,'ZEC',437981000,225.223,1),(19,'USDT',321172000,1.00523,1),(20,'VERI',249139000,123.917,1),(21,'STEEM',302146000,1.26397,1),(22,'SC',221652000,0.00777224,1),(23,'OMG',641032000,6.52038,1),(25,'XLM',228947000,0.0207754,1),(26,'BCN',293205000,0.00160018,1),(27,'GNT',260204000,0.312358,1),(28,'LSK',238398000,2.15118,1),(29,'GNO',224175000,202.949,1),(30,'GBYTE',196858000,374.022,1),(31,'DOGE',207437000,0.00187527,1),(32,'REP',239184000,21.744,1),(33,'SNT',246978000,0.0711652,1),(34,'FCT',166073000,18.9728,1),(35,'DGB',132602000,0.0151679,1),(36,'PAY',559074000,5.34174,1),(37,'GAME',156958000,2.46007,1),(38,'DCR',147118000,26.6359,1),(39,'MAID',184770000,0.408284,1),(40,'NXT',120449000,0.12057,1),(42,'PPT',230733000,6.23536,1),(43,'ARDR',138937000,0.139076,1),(44,'DGD',165439000,82.7195,1),(45,'MCAP',132509000,1.94651,1),(46,'PIVX',111303000,2.05981,1),(47,'KMD',185229000,1.83494,1),(48,'LKK',98152900,0.375721,1),(49,'MGO',90739900,0.945958,1),(50,'BNT',119407000,2.9286,1),(51,'SNGLS',122606000,0.204344,1),(52,'MTL',164836000,8.54027,1),(53,'CVC',197603000,0.581186,1),(54,'1ST',75648700,0.884177,1),(55,'ARK',83792700,0.865247,1),(56,'SYS',58431600,0.110925,1),(57,'ANT',97469100,2.90042,1),(58,'BDL',33196500,0.110655,1),(59,'BTCD',90387000,70.1293,1),(60,'UBQ',50082600,1.32973,1),(61,'ETP',85645000,3.7896,1),(62,'FUN',118319000,0.0308166,1),(63,'NXS',68014500,1.3173,1),(64,'PART',65901200,8.59569,1),(65,'BLOCK',55704700,14.0572,1),(66,'PPC',43327900,1.78583,1),(67,'DCT',88119700,1.71753,1),(68,'XVG',35244800,0.00262835,1),(69,'LEO',45060100,0.513316,1),(70,'EMC',42684500,1.05302,1),(71,'XAS',63587600,0.847835,1),(72,'WINGS',54181900,0.603979,1),(73,'SAFEX',49797100,0.0231886,1),(74,'STX',62621200,2.11558,1),(75,'PPY',40192000,10.7339,1),(76,'EDG',49240200,0.600152,1),(77,'ROUND',45976600,0.0540901,1),(78,'NMR',50455500,40.2736,1),(79,'XEL',57783000,0.682135,1),(80,'RDD',28990000,0.00101412,1),(81,'DICE',62278500,8.89487,1),(82,'LBC',31669300,0.46216,1),(83,'RLC',55182200,0.697884,1),(84,'MLN',49334400,82.3063,1),(85,'PLR',65768600,0.117444,1),(86,'VIA',24667300,1.08258,1),(87,'FAIR',24357300,0.457897,1),(88,'STORJ',134078000,1.88536,1),(89,'NLG',26340600,0.0751038,1),(90,'VSL',37969700,1.13714,1),(91,'NMC',25799600,1.75074,1),(92,'CMP',14334800,3.79603,1),(93,'XAUR',23641700,0.185993,1),(94,'XCP',26733100,10.2108,1),(95,'CLOAK',26457900,5.20776,1),(96,'MYST',36821500,1.89518,1),(97,'MONA',20705500,0.389384,1),(98,'HMQ',30453000,0.18699,1),(99,'BAY',22611400,0.0224395,1),(100,'ION',28420300,1.83943,1),(101,'TAAS',27739600,3.4053,1),(102,'XZC',32002400,11.6265,1),(103,'AMP',23099300,0.280821,1),(104,'SKY',22741900,3.89881,1),(105,'BLK',20170800,0.264339,1),(106,'POT',26785500,0.123109,1),(107,'VTC',19172600,0.49818,1),(108,'XDN',17512100,0.00254338,1),(109,'SIB',21126400,1.38966,1),(110,'ECOB',18284000,0.041139,1),(111,'OMNI',16800500,30.0271,1),(112,'EAC',14971500,0.00132799,1),(113,'ADT',45058600,0.0750977,1),(114,'YBC',17278600,5.7205,1),(115,'TKN',34340600,1.4524,1),(116,'QRL',25904200,0.498158,1),(117,'SOAR',17300500,0.0265357,1),(118,'PTOY',23320200,0.333146,1),(119,'QAU',16031400,0.196635,1),(120,'MUSE',11426900,0.00831144,1),(121,'DTB',21635800,0.951115,1),(122,'FRST',21275700,4.69765,1),(123,'IOC',27965000,1.70978,1),(124,'OBITS',18225400,1.14694,1),(125,'BURST',13592700,0.00755016,1),(126,'PLBT',13174900,3.49219,1),(127,'EXP',17036100,2.17844,1),(128,'NAV',17622800,0.286023,1),(129,'TRST',29223400,0.317137,1),(130,'GOLOS',17401000,0.139746,1),(131,'WGR',16082700,0.0878834,1),(132,'SNM',27460400,0.0828717,1),(133,'XRL',28017700,0.36792,1),(134,'MOON',8837680,0.0000397699,1),(135,'GRC',12920200,0.0331022,1),(136,'TIME',19102600,26.9008,1),(137,'UNY',11686600,0.0578545,1),(138,'NEOS',11275400,3.27543,1),(139,'EDR',12701900,0.0143328,1),(140,'MUE',17591800,0.139145,1),(141,'RADS',14613300,4.40087,1),(142,'AGRS',20871200,0.496934,1),(143,'VOX',14120100,0.0672386,1),(144,'EMC2',10658700,0.050209,1),(145,'EB3',21123000,0.396601,1),(146,'CRW',14356100,0.97113,1),(147,'CFI',33064400,0.264515,1),(148,'WCT',12441600,1.55573,1),(149,'NXC',14046600,0.211158,1),(150,'SAN',19620500,0.334125,1),(151,'BNB',44633600,0.446336,1),(152,'ECN',12717700,3.56156,1),(153,'NLC2',34653900,0.170529,1),(154,'DBIX',10026900,9.90618,1),(155,'MCO',45114300,4.59703,1),(156,'PLU',10606400,12.4781,1),(157,'BITCNY',11867200,0.146175,1),(158,'IFC',9366480,0.000103387,1),(159,'DNT',46436300,0.0773938,1),(160,'BASH',9605760,0.013674,1),(161,'SLS',11961400,11.9135,1),(162,'B@',12311900,1.07782,1),(163,'SHIFT',10266600,0.927389,1),(164,'FTC',9907350,0.0577171,1),(165,'BCY',9574930,0.411853,1),(166,'XBC',10682900,107.446,1),(167,'ENRG',11130500,0.0918872,1),(168,'RBY',10773500,0.437137,1),(169,'SWT',15425900,2.03618,1),(170,'ANC',118976,0.0563785,1),(171,'GUP',16855600,0.224741,1),(172,'WDC',8300060,0.0721802,1),(173,'SPR',11104800,1.29767,1),(174,'BCAP',10463900,1.04639,1),(175,'TOA',10235000,0.0060816,1),(176,'UNO',13107800,66.271,1),(177,'VASH',7929050,0.0198058,1),(178,'LMC',13639400,0.0640467,1),(179,'VRC',8204310,0.270467,1),(180,'QRK',7148480,0.0284211,1),(181,'GRS',8192960,0.120221,1),(182,'MGC',7199990,0.0757894,1),(183,'ETT',6407340,0.103126,1),(184,'FLDC',7239140,0.0140658,1),(185,'HEAT',9442710,0.337368,1),(186,'PEPECASH',8897290,0.0126763,1),(187,'XBY',5638630,0.00867482,1),(188,'XPM',7608170,0.376361,1),(189,'CLAM',20382500,7.95083,1),(190,'MSP',10756900,0.076835,1),(191,'GAM',7798540,6.55293,1),(192,'FLO',7500300,0.0551493,1),(193,'NOTE',7234510,0.0573922,1),(194,'ZEN',9324520,5.81805,1),(195,'COE',1639910,38.3425,1),(196,'CHC',4678060,0.306743,1),(197,'LUN',52062000,22.6568,1),(198,'BELA',8882070,0.240388,1),(199,'RISE',7614320,0.0709053,1),(200,'DMD',10175500,4.57357,1),(201,'XCN',5586500,0.0160363,1),(202,'DIME',5171370,0.0000097223,1),(203,'MEC',5802090,0.176428,1),(204,'ZET',5370960,0.0322587,1),(205,'NET',886163,0.00112582,1),(206,'NVC',4045580,2.24799,1),(207,'ADX',19717500,0.492938,1),(208,'SPHR',6255720,2.02914,1),(209,'AEON',6817980,0.46642,1),(210,'ICASH',5920690,0.0263125,1),(211,'PASC',6920950,0.561533,1),(212,'ESP',5355190,0.000262171,1),(213,'NVST',4740630,0.316042,1),(214,'INCNT',7547290,0.164013,1),(215,'DAXX',5494480,0.0114047,1),(216,'MAX',4707830,0.0786432,1),(217,'SLR',5937460,0.165967,1),(218,'CADASTRAL',6796620,0.226554,1),(219,'BSD',5170590,0.321707,1),(220,'COVAL',5630340,0.00563034,1),(221,'OK',4974220,0.0687851,1),(222,'BITB',6069610,0.00293482,1),(223,'BLITZ',5049870,1.23781,1),(224,'AUR',5356240,0.618637,1),(225,'MUSIC',4867050,0.017372,1),(226,'PINK',5138410,0.0148039,1),(227,'XRB',10874200,0.10552,1),(228,'IXT',9082210,0.253843,1),(229,'PZM',5307770,1.10898,1),(230,'ZCC',3760550,0.0609914,1),(231,'CRB',10246000,0.862797,1),(232,'ICOO',4758150,10.216,1),(233,'GCR',5177440,0.0502531,1),(234,'DAR',4602390,0.337821,1),(235,'SEQ',5046530,0.112419,1),(236,'XVC',3220370,0.21111,1),(237,'XSPEC',3421480,0.167339,1),(238,'APX',5981890,7.6948,1),(239,'GLD',4692620,0.11609,1),(240,'ECC',6532090,0.000262749,1),(241,'BITUSD',3715480,1.01102,1),(242,'PUT',4562460,0.0227479,1),(243,'SMART',6008870,0.027958,1),(244,'SIGT',6537600,0.0803723,1),(245,'CURE',4609710,0.194192,1),(246,'VRM',2772900,2.26109,1),(247,'RIC',3411220,0.0941306,1),(248,'ATMS',3339730,0.0333423,1),(249,'BQX',51561900,0.730895,1),(250,'SBD',3037490,0.854855,1),(251,'MINT',3723720,0.000150071,1),(252,'ABY',5831190,0.00736748,1),(253,'NAUT',2903780,0.179467,1),(254,'ZRC',2743840,1.1239,1),(255,'VISIO',3406510,0.0671888,1),(256,'EMV',4161790,0.624269,1),(257,'XBB',4196340,0.440215,1),(258,'QWARK',4226640,0.150142,1),(259,'XMY',3364410,0.00223719,1),(260,'ZENI',2747390,0.00274524,1),(261,'WBB',4216840,1.76848,1),(262,'MNY',451899,0.000451899,1),(263,'EXCL',3044900,0.726989,1),(264,'BTA',2388010,0.480635,1),(265,'DYN',3175300,1.79908,1),(266,'ZCL',2642850,1.4603,1),(267,'TAG',2303480,0.408138,1),(268,'PDC',4230260,0.0846053,1),(269,'XST',2896490,0.108666,1),(270,'PTC',2087900,0.0160388,1),(271,'CRAVE',2073080,1.55013,1),(272,'SYNX',2219480,0.154533,1),(273,'DOT',1988290,0.00822282,1),(274,'DOPE',2802520,0.0252285,1),(275,'SNRG',3216270,1.08858,1),(276,'SWIFT',2730810,0.671737,1),(277,'EQT',3750390,0.608628,1),(278,'STA',2594230,0.553539,1),(280,'SNC',2883780,0.0293766,1),(281,'FST',1691150,0.0133409,1),(282,'ZEIT',2638590,0.0000713689,1),(283,'TRIG',3273070,0.101947,1),(284,'FNC',2154640,0.167303,1),(285,'INSN',2620350,0.165675,1),(286,'VSM',1892880,2.2928,1),(287,'POSW',2271210,0.0515013,1),(288,'JINN',5079970,86.5368,1),(289,'1337',2044380,0.0000878493,1),(290,'CCRB',2218180,0.622716,1),(291,'VTR',2001090,0.185013,1),(292,'SKIN',2197090,0.024915,1),(293,'ERC',2015430,0.203818,1),(294,'BRX',2820700,0.45001,1),(295,'KORE',2402020,1.21837,1),(296,'NET',886163,0.00112582,1),(297,'HUC',1745190,0.0934637,1),(298,'FUCK',1679890,0.038892,1),(299,'ADC',1387890,0.00169251,1),(300,'HUSH',1692780,1.53765,1),(301,'2GIVE',2279860,0.0044292,1),(302,'ADZ',2182160,0.0393728,1),(303,'TX',1965200,0.323667,1),(304,'THC',1606130,0.0071689,1),(305,'NTRN',1971670,0.0656051,1),(306,'NKA',1412160,0.000154118,1),(307,'START',1894400,0.0420232,1),(308,'JNS',2709560,0.12842,1),(309,'RNS',1752250,0.0525317,1),(310,'INPAY',1930070,0.193007,1),(311,'EGC',1690090,0.126871,1),(312,'BTM',1593230,0.408397,1),(313,'BRK',2175200,0.120114,1),(314,'TRC',1925310,0.0915271,1),(315,'LGD',2528100,1.26405,1),(316,'GEO',2708170,0.856732,1),(317,'TIX',1458000,0.0000218014,1),(318,'MER',1693780,0.0169378,1),(319,'CANN',1606470,0.0208008,1),(320,'CREA',1117200,0.104846,1),(321,'NSR',1825320,0.000675475,1),(322,'MNE',1342890,1.55582,1),(323,'FUNC',1353280,0.231386,1),(324,'LDOGE',1331370,0.0000898279,1),(325,'HTML5',1958470,0.0000481681,1),(326,'HKG',1649530,0.102386,1),(327,'MBRS',2184940,0.0436988,1),(328,'XWC',1705150,0.00686902,1),(329,'TKS',1765410,1.83838,1),(330,'PEPE',2100200,0.148588,1),(331,'RLT',715229,0.0708667,1),(332,'PND',1213000,0.0000373059,1),(333,'HYP',1299730,0.00135143,1),(334,'GLC',599328,0.00919623,1),(335,'EFL',1333600,0.0864595,1),(336,'SPRTS',1841670,0.0000054943,1),(337,'TRUST',1171870,0.0365222,1),(338,'SXC',1184810,0.00956623,1),(339,'NETKO',1423190,0.395996,1),(340,'RAIN',1416240,0.027134,1),(341,'ICE',1188700,0.756644,1),(342,'XTC',1404210,0.0140421,1),(343,'TIPS',1352730,0.0000030524,1),(344,'PING',1782490,0.179107,1),(345,'MOIN',832618,0.117618,1),(346,'EL',956832,0.0853631,1),(347,'WGO',873765,0.0874033,1),(348,'CPC',812040,0.408051,1),(349,'TES',840757,0.011561,1),(350,'DRACO',917342,0.0103201,1),(351,'CBX',1099190,1.09972,1),(352,'XMG',1026820,0.142642,1),(353,'HERO',742283,155.517,1),(354,'PROC',321336,0.114143,1),(355,'PKB',1142460,0.239809,1),(356,'ZUR',570057,0.00694241,1),(357,'FJC',853408,0.000811026,1),(358,'MRT',618494,0.0618494,1),(359,'KEK',463461,0.0470697,1),(360,'INFX',777365,0.464547,1),(361,'ALT',992501,8.12358,1),(362,'VUC',610096,0.0101007,1),(363,'ENT',880168,0.235255,1),(364,'PIE',1090410,0.014599,1),(365,'UIS',842071,0.0179984,1),(366,'JET',425283,0.257246,1),(367,'LNK',1363170,28.6963,1),(368,'XVP',675248,0.0739208,1),(369,'CFT',398854,0.00867073,1),(370,'RBX',851651,0.00223392,1),(371,'BYC',778142,0.451591,1),(372,'ZER',470272,0.375356,1),(373,'GCN',432753,0.0000030387,1),(374,'UNB',589346,0.258695,1),(375,'BUCKS',185157,0.770257,1),(376,'BTX',367779,0.00450427,1),(377,'USNBT',523254,0.998861,1),(378,'NYC',456656,0.0000076466,1),(379,'FOOT',582447,0.138882,1),(380,'GRE',496021,0.000152057,1),(381,'BTB',569642,16.8898,1),(382,'FCN',555302,0.0900855,1),(383,'DCY',512106,0.000414628,1),(384,'OTX',491809,0.0621941,1),(385,'CNT',301590,0.0113523,1),(386,'PIGGY',445582,0.000919822,1),(387,'HNC',441329,0.00799509,1),(388,'EMB',877455,0.000135223,1),(389,'ITI',518298,16.1968,1),(390,'FIMK',866326,0.00150142,1),(391,'TRUMP',500695,0.0765275,1),(392,'DGC',233645,0.00884732,1),(393,'ZOI',427832,0.033856,1),(394,'POST',465688,0.0293472,1),(395,'PAK',759173,0.0191844,1),(396,'CV2',491380,0.0000218884,1),(397,'TRI',314626,4.31637,1),(398,'CNC',402100,0.0116992,1),(399,'XHI',293554,0.00154722,1),(400,'KRB',431300,0.105817,1),(401,'BUN',144886,0.000001423,1),(402,'GTC',54655,0.00191432,1),(403,'42',469304,11173.9,1),(404,'SUMO',389827,0.345403,1),(405,'HTC',412753,0.0000375356,1),(406,'FRN',271136,0.0727369,1),(407,'8BIT',329727,0.28317,1),(408,'DSH',262395,0.015083,1),(409,'DNR',686264,0.849925,1),(410,'UNIFY',432826,0.0265982,1),(411,'RBIES',335989,0.0322593,1),(412,'HBN',288304,0.00514331,1),(413,'PIP',144249,0.0206071,1),(414,'VIDZ',242109,0.00193257,1),(415,'DEM',264262,0.00950809,1),(416,'XP',474373,0.000003357,1),(417,'NEWB',280410,0.00934701,1),(418,'ATOM',282348,0.0244322,1),(419,'LINX',343392,0.0728204,1),(420,'CORG',94703,0.00007565,1),(421,'PSB',192302,0.00581802,1),(422,'808',289216,0.000751268,1),(423,'GB',235372,0.0156718,1),(424,'DP',109956,0.00474353,1),(425,'BITBTC',274389,3679.02,1),(426,'SCORE',140054,0.00513553,1),(427,'MAC',297419,0.015013,1),(428,'GCC',32741,0.00161403,1),(429,'YOC',290364,0.00274917,1),(430,'XVS',309212,0.00289609,1),(431,'BXT',152627,0.273526,1),(432,'CAT',175646,0.0300285,1),(433,'TSE',253138,0.00279952,1),(434,'DAS',214217,0.133736,1),(435,'BITSILVER',154983,17.0292,1),(436,'KURT',135236,0.0136334,1),(437,'UET',110168,0.02778,1),(438,'ASAFE2',103752,0.0129206,1),(439,'PASL',140146,0.0489464,1),(440,'CJ',171261,0.000421235,1),(441,'ADCN',118592,0.00475678,1),(442,'KAYI',132116,0.000150301,1),(443,'MSCN',121475,0.00288023,1),(444,'XCO',101815,0.00822086,1),(445,'GLT',101235,0.00452458,1),(446,'PRC',141139,0.0119739,1),(447,'TOR',45715,0.144585,1),(448,'BITEUR',129212,1.20449,1),(449,'FLAX',92528,0.0166656,1),(450,'CXT',92772,0.0314694,1),(451,'XCT',150076,0.00103195,1),(452,'HONEY',107336,0.548161,1),(453,'MOJO',123769,0.0102404,1),(454,'PXI',149628,0.0093839,1),(455,'MAR',58275,0.0536393,1),(456,'QTL',93303,0.012312,1),(457,'VRS',59264,0.000484682,1),(458,'GPU',62208,0.00153688,1),(459,'XPD',94045,0.00146961,1),(460,'LBTC',33202,0.0104138,1),(461,'EVO',60874,0.0246533,1),(462,'BIOS',39395,0.00189203,1),(463,'ERY',66239,0.0141022,1),(464,'MNC',59349,0.0127621,1),(465,'DBTC',51209,0.00284526,1),(466,'ECO',36197,0.09049,1),(467,'HXX',44979,0.0317072,1),(468,'U',48967,0.0182048,1),(469,'1CR',328,0.00371603,1),(470,'BLAS',146547,0.000601083,1),(471,'CREVA',51906,0.00142635,1),(472,'DIBC',84179,0.0168357,1),(473,'CESC',32454,0.000225214,1),(474,'AMS',47537,0.00494987,1),(475,'CTO',39631,0.00367849,1),(476,'ZYD',20390,0.0032656,1),(477,'BRIA',16229,0.481948,1),(478,'WEX',29491,0.139091,1),(479,'CTIC2',19603,0.00893693,1),(480,'LVPS',4072,0.00758113,1),(481,'EBT',14783,0.0138882,1),(482,'TAGR',14515,0.000375356,1),(483,'SH',13053,0.00330313,1),(484,'CF',4171,0.0375356,1),(485,'UNITY',14712400,18.0285,1),(486,'ARC',559861,0.287643,1),(487,'MED',4590910,0.0902967,1),(488,'DEX',3992580,3.99258,1),(489,'BPC',8358220,0.111443,1),(490,'XC',3658790,0.627183,1),(491,'INSANE',2003890,0.109247,1),(492,'AC',2557730,0.00269411,1),(493,'IXC',2263110,0.107772,1),(494,'BLOCKPAY',2419960,0.445805,1),(495,'PANGEA',1488320,1.48928,1),(496,'FUND',1621170,1.62117,1),(497,'I0C',615476,0.0293363,1),(498,'ADL',1684080,0.0717477,1),(499,'YASH',1088550,0.108853,1),(500,'XTO',571065,0.0187678,1),(501,'BITZ',1324880,0.665469,1),(502,'CARBON',577747,0.0000375356,1),(503,'E4ROW',974012,0.233688,1),(504,'BTD',396652,0.0351709,1),(505,'ORB',882894,0.293584,1),(506,'RC',981972,0.119513,1),(507,'LOG',964231,0.120001,1),(508,'CASINO',675219,0.675219,1),(509,'CDN',643845,0.00660926,1),(510,'GOOD',464573,0.00105262,1),(511,'BTSR',709641,0.216111,1),(512,'SDC',699055,0.104462,1),(513,'SMC',370362,0.0160137,1),(514,'KOBO',374325,0.0151547,1),(515,'MNM',115421,0.0122315,1),(516,'TROLL',420954,0.000753445,1),(517,'MXT',768160,0.280391,1),(518,'HPC',1104420,0.0943523,1),(519,'USC',540811,0.0522871,1),(520,'BTX',367779,0.00450427,1),(521,'ETB',325132,1.09247,1),(522,'BLU',648508,0.00112846,1),(523,'NOBL',431455,0.000187678,1),(524,'UFO',379680,0.000112607,1),(525,'V',385296,0.000855662,1),(526,'SMLY',391418,0.0000150776,1),(527,'CCN',247203,0.052613,1),(528,'SUPER',457436,0.0104658,1),(529,'CAGE',2669470,0.0000263864,1),(530,'ECA',563382,0.0000281175,1),(531,'METAL',461992,0.0060057,1),(532,'FLY',633017,3.00285,1),(533,'BRIT',707713,0.0332758,1),(534,'XGR',235900,0.013738,1),(535,'SHORTY',446674,0.00446674,1),(536,'BITS',213044,0.00923077,1),(537,'RAREPEPEP',222044,12.3358,1),(538,'DVC',604069,0.0000417787,1),(539,'TALK',323496,0.0049547,1),(540,'UTC',272366,0.00623091,1),(541,'GAIA',379052,0.0157274,1),(542,'STS',254552,0.000450427,1),(543,'PXC',355700,0.00596615,1),(544,'REE',219580,0.0177543,1),(545,'FUNK',279879,0.0000062249,1),(546,'MZC',410114,0.00037535,1),(547,'CNO',532338,0.00506579,1),(548,'BSTY',277113,0.0222782,1),(549,'XPY',227334,0.0193754,1),(550,'MILO',27540,0.00255242,1),(551,'FLT',316804,0.000983209,1),(552,'CRYPT',381200,0.0630223,1),(553,'AMBER',328057,0.00750712,1),(554,'LANA',263737,0.000337888,1),(555,'LOT',202055,0.0000139435,1),(556,'EMD',177998,0.00931091,1),(557,'LTBC',17963,0.0000363722,1),(558,'020',147445,0.0000009464,1),(559,'TIT',224926,0.00450769,1),(560,'TEK',212316,0.000150147,1),(561,'SWING',163414,0.0661144,1),(562,'AU',201709,0.680954,1),(563,'C2',213741,0.00213792,1),(564,'4CHN',196584,0.0317789,1),(565,'NYAN',175692,0.000589787,1),(566,'FC2',186702,0.00183925,1),(567,'Q2C',260544,0.001051,1),(568,'ICN',174380,0.00604323,1),(569,'HODL',223492,0.00191432,1),(570,'CAP',179049,0.00108853,1),(571,'UNITS',246104,0.0708624,1),(572,'UNIC',157906,0.053696,1),(573,'XPTX',129603,0.536087,1),(574,'BLC',157801,0.0104347,1),(575,'VLT',167760,0.302349,1),(576,'TRK',208681,0.00153897,1),(577,'J',197835,0.0808016,1),(578,'ANC',118976,0.0563785,1),(579,'BOST',222501,0.0187678,1),(580,'OHM',253459,0.00893348,1),(581,'BIGUP',83093,0.0000399371,1),(582,'CHESS',201295,0.00372542,1),(583,'CSC',253561,0.00656873,1),(584,'DUO',120450,0.406473,1),(585,'XRA',156279,0.00142756,1),(586,'XJO',136732,0.00409898,1),(587,'UNI',104063,0.0186927,1),(588,'BITGOLD',115953,1288.81,1),(589,'HMP',101845,0.0000750712,1),(590,'KED',137266,0.0130606,1),(591,'EUC',81721,0.00687046,1),(592,'TTC',102958,0.000081725,1),(593,'KIC',166667,0.0113371,1),(594,'RUP',98302,0.00449547,1),(595,'LTB',133639,0.188846,1),(596,'TGC',130734,0.00300285,1),(597,'SLG',135515,0.0324519,1),(598,'BTCR',112549,0.000663622,1),(599,'WAY',135183,0.00135128,1),(600,'BOLI',136965,0.0188148,1),(601,'SRC',147997,0.0185002,1),(602,'888',105624,0.00212723,1),(603,'BERN',117244,0.00164589,1),(604,'MI',80799,0.000198942,1),(605,'MTM',95656,0.0318854,1),(606,'VAL',131606,0.0000375098,1),(607,'FRC',171368,0.0060057,1),(608,'YAC',106144,0.000900855,1),(609,'STV',112715,0.0159177,1),(610,'KUSH',126054,0.0231975,1),(611,'RED',75105,0.00101346,1),(612,'XLR',176223,0.469188,1),(613,'GRT',95343,0.00226861,1),(614,'BTPL',51191,0.0102139,1),(615,'SPEX',107600,0.0000375356,1),(616,'ARI',192837,0.00137483,1),(617,'SPACE',103915,0.00550595,1),(618,'XRE',123020,0.00559281,1),(619,'CNNC',64962,0.0262273,1),(620,'ARCO',89623,0.0675142,1),(621,'BUMBA',52058,0.00235064,1),(622,'SPT',76533,0.00341574,1),(623,'GP',62342,0.0510936,1),(624,'GUN',98824,0.000525499,1),(625,'CRX',79123,0.00107314,1),(626,'ICOB',115091,0.00109444,1),(627,'AGLC',86021,0.0150142,1),(628,'UNIBURST',150049,0.150049,1),(629,'CUBE',92050,0.0000378941,1),(630,'BTCS',129971,0.00799509,1),(631,'EVIL',87102,0.00414369,1),(632,'ELE',151740,0.00596816,1),(633,'300',53060,176.868,1),(634,'QCN',90352,0.0150142,1),(635,'KLC',66314,0.000337821,1),(636,'GAP',87620,0.00773234,1),(637,'URC',64901,0.00923937,1),(638,'RBT',76805,0.00066498,1),(639,'ACOIN',80380,0.0658805,1),(640,'HAL',68245,0.0139257,1),(641,'CYP',73807,0.0115952,1),(642,'DLC',239278,0.0262749,1),(643,'SCRT',71426,0.016891,1),(644,'PR',88789,0.455126,1),(645,'ATX',49317,0.00262749,1),(646,'DRM',50450,0.0206035,1),(647,'IMS',94755,0.0176487,1),(648,'PHS',73949,0.0304414,1),(649,'MAD',75097,0.0000375356,1),(650,'WMC',61875,0.00536759,1),(651,'CON',86334,0.00374672,1),(652,'BIP',59240,0.0385115,1),(653,'NRO',48506,0.00270256,1),(654,'ALL',52717,0.00850368,1),(655,'FRK',68587,0.107681,1),(656,'GBC',44959,0.003957,1),(657,'PUTIC',39774,0.0011636,1),(658,'ARB',47781,0.00683293,1),(659,'NEVA',64558,0.0309388,1),(660,'TAJ',61634,0.00912797,1),(661,'ZNY',73794,0.000975926,1),(662,'VC',93309,0.0092713,1),(663,'SOON',37891,0.00304039,1),(664,'VTA',31085,0.0000059767,1),(665,'MARS',70058,0.00247739,1),(666,'BCF',42239,0.0112232,1),(667,'POP',72591,0.000021558,1),(668,'BVC',110694,0.0355329,1),(669,'DRS',38347,0.0000750712,1),(670,'FLVR',46056,0.00220385,1),(671,'CPN',89014,0.00453803,1),(672,'TSTR',54541,0.0108478,1),(673,'WYV',17293,0.012124,1),(674,'BLRY',44172,0.00491717,1),(675,'BOB',50864,0.0100515,1),(676,'ARG',54571,0.00689859,1),(677,'MEOW',45261,0.0000018933,1),(678,'VEC2',54523,0.00337821,1),(679,'DIX',57023,0.0000005702,1),(680,'MST',60214,0.0956112,1),(681,'PONZI',50196,0.0582928,1),(682,'PHO',44378,0.0000023559,1),(683,'JIN',121991,0.0123868,1),(684,'$$$',42555,0.000927382,1),(685,'URO',38021,0.0314924,1),(686,'JWL',51512,0.00255242,1),(687,'BSTAR',23677,0.0000375356,1),(688,'PX',38068,0.000450427,1),(689,'B3',86784,0.148679,1),(690,'CHAO',27778,109980,1),(691,'ISL',46591,0.0307792,1),(692,'611',62525,0.149005,1),(693,'ANTI',32778,0.00187678,1),(694,'UNIT',44574,0.00341653,1),(695,'COAL',34289,0.00761973,1),(696,'PRX',33286,0.00281565,1),(697,'KNC',18978,9.46513,1),(698,'SOCC',32692,0.023819,1),(699,'PULSE',25547,0.00178665,1),(700,'RPC',40164,0.0478579,1),(701,'CWXT',32201,0.000563023,1),(702,'WORM',76589,0.000713177,1),(703,'AUM',51807,0.00255242,1),(704,'SFC',27466,0.0019502,1),(705,'FIRE',51715,0.525499,1),(706,'XCRE',71797,0.00349879,1),(707,'FUZZ',25381,0.00525499,1),(708,'LUNA',40736,0.0281892,1),(709,'SLING',60233,0.0560782,1),(710,'BNX',37821,0.00183925,1),(711,'CASH',34779,0.00127621,1),(712,'GCC',32741,0.00161403,1),(713,'STEPS',30061,0.00161403,1),(714,'MTLMC3',32915,0.000412892,1),(715,'BENJI',32491,0.00164644,1),(716,'LEA',37629,0.000131112,1),(717,'MND',30612,0.00243982,1),(718,'CACH',198761,0.0473789,1),(719,'VIP',31324,0.000375356,1),(720,'MCRN',72650,0.000180983,1),(721,'SCS',10211,0.0389995,1),(722,'QBK',5605,0.00375122,1),(723,'VPRC',28728,0.0000368247,1),(724,'SONG',31777,0.000975792,1),(725,'OFF',22428,0.00855812,1),(726,'CMT',27651,0.0316801,1),(727,'DOLLAR',21220,0.0281517,1),(728,'CAB',27181,0.0025887,1),(729,'ACP',27209,0.0061911,1),(730,'RIDE',26603,0.000262749,1),(731,'RSGP',14221,8.25847,1),(732,'XBTS',16691,0.0109472,1),(733,'AMMO',20436,0.000262749,1),(734,'BTQ',24979,0.00349081,1),(735,'GBT',25540,0.00120114,1),(736,'VLTC',52772,0.00176281,1),(737,'ORLY',26136,0.000713177,1),(738,'HVCO',15648,0.0104724,1),(739,'LTCR',5947,0.000196737,1),(740,'HIRO',23992,0.0000750712,1),(741,'XBTC21',41856,0.0527751,1),(742,'BOAT',18533,0.000999202,1),(743,'420G',18218,0.0187305,1),(744,'BLZ',18887,0.0000310363,1),(745,'ZMC',22534,0.0000375356,1),(746,'XOC',21976,0.0523247,1),(747,'PLNC',18603,0.00108853,1),(748,'WARP',22487,0.020532,1),(749,'EGO',19140,0.000318996,1),(750,'G3N',23275,0.00307792,1),(751,'DES',21618,0.013511,1),(752,'DLISK',17000,0.000169995,1),(753,'CONX',13102,0.0176042,1),(754,'ICON',30711,0.0517992,1),(755,'ZNE',10467,0.00405385,1),(756,'MAY',19865,0.00112607,1),(757,'IMX',28759,0.000262749,1),(758,'ARGUS',13882,0.0120893,1),(759,'IBANK',16389,0.00362079,1),(760,'SLEVIN',15765,0.000225214,1),(761,'TOKEN',575067,0.0000375356,1),(762,'IMPS',14299,0.000706298,1),(763,'OS76',16880,0.0188804,1),(764,'CRT',14282,0.180171,1),(765,'TRADE2',75632,0.00450427,1),(766,'VOLT',9643,0.000638106,1),(767,'LIR',14736,0.000412892,1),(768,'DPAY',14928,0.000187678,1),(769,'JOBS',7959,0.0000750712,1),(770,'BSC',21249,0.00382863,1),(771,'BQC',60960,0.00120081,1),(772,'CCM100',7058,0.00285093,1),(773,'OCEAN',4768,0.0225073,1),(774,'GEERT',10118,0.00198733,1),(775,'PEX',11418,0.00465442,1),(776,'ALTC',12002,0.000380862,1),(777,'XRC',6800,0.00964665,1),(778,'REV',5520,0.00461688,1),(779,'SANDG',9244,0.00301619,1),(780,'ELS',13530,0.00337821,1),(781,'IMPCH',7142,0.0231748,1),(782,'SDP',7514,0.0472573,1),(783,'P7C',6610,0.000187678,1),(784,'BIOB',7015,0.00792002,1),(785,'JIO',8380,0.00439167,1),(786,'NODC',5292,0.00315299,1),(787,'ONX',7140,0.00236474,1),(788,'XNG',3370,0.202692,1),(789,'ABN',3431,0.0506731,1),(790,'ENV',4707,0.000035488,1),(791,'DRAGON',2995,0.00742741,1),(792,'SLFI',4047,0.0000375356,1),(793,'PIZZA',7022,0.00509607,1),(794,'LEX',13880,0.0138795,1),(795,'FDC',2790,0.00101346,1),(796,'PWR',1876,0.0000375356,1),(797,'ZHS',1909,0.000675641,1),(798,'MGM',7739,0.00206446,1),(799,'DGCS',1312,0.000225214,1),(800,'MUG',835,0.000835656,1),(801,'DMB',342,0.000810761,1),(802,'XEN',171,0.016891,1),(803,'CALC',105,0.00120114,1),(804,'GXS',0,2.59954,1),(805,'ICO',130130000,1.3013,1),(806,'FRGC',0,7.62712,1),(807,'HLB',0,0.0280547,1),(808,'DMC',0,0.999985,1),(809,'ATCC',1960230,0.186228,1),(810,'GP',62342,0.0510936,1),(811,'OAX',16110100,0.644167,1),(812,'BGC',0,0.00448161,1),(813,'GYC',0,0.0164378,1),(814,'XID',0,0.150143,1),(815,'AXF',0,0.0844629,1),(816,'SJCX',0,0.427321,1),(817,'MALC',0,41.3485,1),(818,'BITOK',0,0.00570993,1),(820,'HBC',0,0.0157458,1),(821,'ZBC',0,0.363844,1),(822,'FBC',0,0.0596974,1),(823,'FEI',0,0.0236187,1),(824,'GBG',0,0.0861303,1),(825,'LINDA',1282820,0.000225252,1),(826,'OCN',0,0.916408,1),(827,'BTU',0,231,1),(828,'DTF',0,0.0108438,1),(829,'DEUS',0,0.40321,1),(830,'CLUB',0,0.352539,1),(831,'THS',0,0.731267,1),(832,'DHG',0,0.132205,1),(833,'CRM',927731,0.0213202,1),(834,'MG',0,0.0130068,1),(835,'SHELL',0,0.0204993,1),(836,'EBST',0,0.118965,1),(837,'WA',0,0.0374976,1),(838,'HMC',0,0.0262178,1),(839,'IOP',0,0.612334,1),(840,'IFLT',678864,0.0000707021,1),(841,'FAL',0,1.64964,1),(842,'TYCHO',0,0.127118,1),(843,'FYN',0,1.35326,1),(844,'PCS',0,0.125246,1),(845,'AE',0,0.475858,1),(846,'MGC',7199990,0.0757894,1),(847,'CVCOIN',0,0.401233,1),(848,'9COIN',0,0.00123723,1),(849,'BGR',0,0.0000531089,1),(850,'GSR',0,0.0348796,1),(851,'FEDS',0,0.0000229577,1),(852,'TCOIN',0,0.000126896,1),(853,'NTCC',0,0.00057103,1),(854,'FXE',304866,1.29498,1),(855,'FLASH',0,0.00323585,1),(856,'APC',0,0.250682,1),(857,'KASHH',0,0.0000322191,1),(858,'RUBIT',0,0.00308177,1),(859,'GARY',0,0.129592,1),(860,'EMP',0,0.0924751,1),(861,'TERA',0,0.000824821,1),(862,'BURN',0,0.0000317239,1),(863,'SKULL',0,0.00351886,1),(864,'ABC',0,11.3197,1),(865,'XOT',0,951.716,1),(866,'SHND',0,0.0000003506,1),(867,'PAC',0,0.0000001507,1),(868,'PRIMU',0,0.000253791,1),(869,'PRES',0,0.00565611,1),(870,'PBT',4681400,4681.4,1),(871,'STEX',0,0.362182,1),(872,'TODAY',0,0.00203033,1),(873,'EFYT',0,7.96432,1),(874,'RBBT',0,0.0000016819,1),(875,'TYC',0,0.317048,1),(876,'SLM',337525,0.022709,1),(877,'ACN',0,0.000253791,1),(878,'TESLA',0,0.602627,1),(879,'BEST',0,0.00120447,1),(880,'QORA',0,0.201766,1),(881,'BRAIN',0,0.0136095,1),(882,'OPAL',0,0.0113821,1),(883,'WOMEN',0,0.00721718,1),(884,'RMC',0,0.602754,1),(885,'TER',0,595.649,1),(886,'ZSE',0,0.00791561,1),(887,'UR',0,0.000984589,1),(888,'SOIL',0,0.0161114,1),(889,'FFC',0,0.000128743,1),(890,'WEC',0,0.12,1),(891,'CMPCO',53857,0.000726933,1),(892,'XLC',0,0.0602754,1),(893,'XDE2',0,1.58493,1),(894,'BTWTY',0,125574,1),(895,'UNRC',0,0.00555168,1),(896,'LEPEN',0,0.0000693474,1),(897,'GAY',0,0.142789,1),(898,'UTA',0,0.0248715,1),(899,'AV',0,0.0915551,1),(900,'BIT',0,0.0115158,1),(901,'MARX',0,0.000942612,1),(902,'ROYAL',0,0.000888269,1),(903,'SKR',0,0.00115902,1),(904,'NANOX',0,158619,1),(905,'OCT',0,0.206667,1),(906,'BAT',207074000,0.207074,1),(907,'SHA',0,0.000793097,1),(908,'EDRC',0,0.0243773,1),(909,'XRY',0,0.131178,1),(910,'TROPTIONS',0,1.13637,1),(911,'SAK',0,0.0190661,1),(912,'ANTX',0,0.0000275172,1),(913,'AMIS',0,1605.58,1),(914,'IRL',0,0.00117378,1),(915,'PCN',0,0.0000004952,1),(916,'XBG',0,0.00206205,1),(917,'MEN',0,0.00104689,1),(918,'HALLO',0,0.000147568,1),(919,'POKE',0,0.0000951716,1),(920,'TELL',0,0.000126703,1),(921,'FAZZ',0,0.00438278,1),(922,'GPL',58555,0.262749,1),(923,'LKC',0,0.000158619,1),(924,'GBRC',0,0.0000634478,1),(925,'TCR',0,0.000190343,1),(926,'BLAZR',0,0.00070296,1),(927,'TIC',0,0.00387031,1),(928,'X2',0,0.0000317239,1),(929,'LDCN',0,0.0222936,1),(930,'FUTC',0,0.000793097,1),(931,'TOPAZ',0,0.123116,1),(932,'QBT',0,0.00145916,1),(933,'UNC',0,0.0000317239,1),(934,'BXC',0,0.00480936,1),(935,'BTG',0,1.59667,1),(936,'COUPE',0,0.0000014074,1),(937,'HCC',0,0.000126896,1),(938,'CYC',0,0.000761373,1),(939,'GOLF',0,0.0000634478,1),(940,'RHFC',0,0.000697925,1),(941,'VOYA',0,0.953017,1),(942,'GUC',0,2.22083,1),(943,'ANI',0,0.0000951716,1),(944,'GMX',0,0.000507582,1),(945,'SPORT',0,0.00136413,1),(946,'XID',0,0.0157668,1),(947,'SOUL',0,0.0000634478,1),(948,'SNAKE',0,0.0404298,1),(949,'GAIN',0,0.000475858,1),(950,'MOTO',0,0.00275329,1),(951,'CBD',0,0.00111034,1),(952,'FONZ',0,0.000380687,1),(953,'MONETA',0,0.000253791,1),(954,'YOG',0,0.0948901,1),(955,'WSX',0,0.00130068,1),(956,'TLE',0,0.0634478,1),(957,'XAU',0,0.014593,1),(958,'DON',0,0.000317239,1),(959,'IVZ',0,0.356418,1),(960,'CLINT',0,0.00339446,1),(961,'SKC',0,0.00272825,1),(962,'YES',0,0.0000064475,1),(963,'MIU',0,0.0000317239,1),(964,'OCOW',0,0.0034579,1),(965,'BIRDS',0,0.000158619,1),(966,'AXIOM',0,0.00634478,1),(967,'LAZ',0,0.000919993,1),(968,'DASHS',0,0.0198274,1),(969,'MBL',0,0.000222067,1),(970,'OP',0,0.000602754,1),(971,'LTH',0,0.000222067,1),(972,'OPES',0,0.00098344,1),(973,'VGC',0,0.000253791,1),(974,'VTY',0,0.0000150322,1),(975,'TEAM',0,0.0000951716,1),(976,'BRO',0,0.0803566,1),(977,'HNC',441329,0.00799509,1),(978,'PI',0,0.0019986,1),(979,'QBC',0,0.000793097,1),(980,'COXST',0,0.0014593,1),(981,'DUB',0,0.00126896,1),(982,'IEC',0,0.0374659,1),(983,'PAYP',0,0.0000634478,1),(984,'BAC',0,0.00218895,1),(985,'ACES',0,0.0000376347,1),(986,'EGG',0,0.0119282,1),(987,'RCN',0,0.0000317239,1),(988,'MONEY',0,0.0000634478,1),(989,'CME',0,0.0000634478,1),(990,'PSY',0,0.00923165,1),(991,'ELC',0,0.0988199,1),(992,'FRWC',0,0.00104689,1),(993,'MAVRO',0,0.00583719,1),(994,'STRB',0,0.0000317239,1),(995,'KARMA',0,0.0000317239,1),(996,'RYCN',0,0.000634478,1),(997,'TRICK',0,0.00383859,1),(998,'CC',0,0.0000634478,1),(999,'SFE',0,0.0000317239,1),(1000,'DISK',0,0.000634478,1),(1001,'MRC',0,0.0000317239,1),(1002,'DCRE',0,0.0649911,1),(1003,'SHELL',0,0.0130478,1),(1004,'SYNC',0,129.327,1),(1005,'TURBO',0,0.0000285071,1),(1006,'PRM',0,0.00066879,1),(1007,'MMXVI',0,0.00228698,1),(1008,'NBIT',0,0.015815,1),(1009,'XSTC',0,0.0001262,1),(1010,'QRZ',0,0.0000261612,1),(1011,'ELCO',0,8.21044,1),(1012,'XVE',0,0.000188836,1),(1013,'ZENGOLD',0,0.0493875,1),(1014,'BET',8930010,0.0814686,1),(1015,'NBE',0,0.0000079934,1),(1016,'AIB',0,0.00492883,1),(1017,'CHEAP',0,0.000113237,1),(1018,'DBG',0,0.001844,1),(1019,'GMB',0,0.000250899,1),(1020,'HILL',0,0.0000318372,1),(1021,'PDG',0,0.0000570503,1),(1022,'WARRANT',0,0.563904,1),(1023,'XQN',0,0.00343632,1),(1024,'DFT',0,0.156783,1),(1025,'TP1',0,0.0247308,1),(1026,'ASC',0,0.000143553,1),(1027,'RICHX',0,0.00505297,1),(1028,'GML',0,0.00308663,1),(1029,'OMC',0,0.138924,1),(1030,'WOW',0,0.0000458937,1),(1031,'BUK',0,0.0444597,1),(1032,'REGA',0,0,1),(1033,'ADT',45058600,0.0750977,1);

drop table if exists wallet_data;
CREATE TABLE wallet_data
(
  id serial NOT NULL,
  name character varying(255) NOT NULL,
  address character varying(255) NOT NULL,
  balance real NOT NULL,
  last_incoming character varying(255) NOT NULL,
  last_outgoing character varying(255) NOT NULL,
  tx_out real NOT NULL,
  tx_in integer NOT NULL,
  update_date timestamp NOT NULL,
  ticker character varying(255) NOT NULL,
  active integer NOT NULL,
  logo_url character varying(255) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO wallet_data VALUES (1,'EOS','0xA72Dc46CE562f20940267f8deb02746e242540ed',11222.6,'2017-08-08','2017-08-11',2500,54341,'2017-08-12 00:02:16','EOS',0,'eos.png'),(2,'Golem','0x7da82c7ab4771ff031b66538d2fb9b0b047f6cf9',386023,'2017-08-01','No transfers yet',0,3000,'2017-08-12 00:02:18','GNT',0,'golem.png'),(3,'Iconomi','0x154Af3E01eC56Bc55fD585622E33E3dfb8a248d8',165362,'2017-06-10','No transfers yet',0,7500,'2017-08-12 00:02:22','ICN',0,'iconomi.png'),(4,'Gnosis','0x851b7F3Ab81bd8dF354F0D7640EFcD7288553419',233875,'2017-06-26','No transfers yet',0,10000,'2017-08-12 00:02:24','GNO',0,'gnosis.png'),(5,'Status','0xA646E29877d52B9e2De457ECa09C724fF16D0a2B',299902,'2017-06-21','No transfers yet',0,299902,'2017-08-12 00:02:25','SNT',0,'status.png'),(6,'TenX','0x185f19B43d818E10a31BE68f445ef8EDCB8AFB83',99474.6,'2017-07-10','No transfers yet',0,500,'2017-08-12 00:02:28','PAY',0,'tenx.png'),(7,'Basic Attention Token','0x7c31560552170ce96c4a7b018e93cddc19dc61b6',3.84,'No transfers yet','No transfers yet',0,0,'2017-08-12 00:02:29','BAT',0,'basic-attention-token.png'),(8,'Populous','0x1a8CC57F1155D7dF4626978401e203E00DA097f7',1797.65,'2017-07-15','No transfers yet',0,30745,'2017-08-12 00:02:30','PPT',0,'populous.png'),(9,'DigixDAO','0xf0160428a8552ac9bb7e050d90eeade4ddd52843',466648,'2016-04-29','No transfers yet',0,0,'2017-08-12 00:02:36','DGD',0,'digixdao.png'),(10,'Bancor','0x5894110995B8c8401Bd38262bA0c8EE41d4E4658',12000,'2017-06-12','No transfers yet',0,1,'2017-08-12 00:02:40','BNT',0,'bancor.png'),(11,'MobileGo','0x6d7ea347ef837462a55337C4f772868F2A80B863',953.74,'No transfers yet','No transfers yet',0,0,'2017-08-12 00:02:41','MGO',0,'mobilego.png'),(12,'Aeternity','0x15c19E6c203E2c34D1EDFb26626bfc4F65eF96F0',74270.7,'2017-07-24','2017-07-23',199,73982,'2017-08-12 00:02:42','AE',0,'aeternity.png'),(13,'Metal','0x93B7e9364C4DF6De55eD0D10c80E7aFC0612e93A',2091.33,'2017-07-25','2017-08-02',6.84,167,'2017-08-12 00:02:44','MTL',0,'metal.png'),(14,'SingularDTV','0x5901Deb2C898D5dBE5923E05e510E95968a35067',118263,'2017-08-10','No transfers yet',0,3,'2017-08-12 00:02:46','SNGLS',0,'singulardtv.png'),(15,'Civic','0x2323763D78bF7104b54A462A79C2Ce858d118F2F',486.88,'2017-07-25','No transfers yet',0,3,'2017-08-12 00:02:49','CVC',0,'civic.png'),(16,'Aragon','0xcafE1A77e84698c83CA8931F54A755176eF75f2C',268445,'2017-07-31','No transfers yet',0,100,'2017-08-12 00:02:51','ANT',0,'aragon.png'),(17,'FirstBlood','0xa5384627F6DcD3440298E2D8b0Da9d5F0FCBCeF7',84920.7,'2017-01-26','No transfers yet',0,100,'2017-08-12 00:02:53','1ST',0,'firstblood.png'),(18,'Etheroll','0x24C3235558572cff8054b5a419251D3B0D43E91b',16445.1,'2017-08-07','No transfers yet',0,1418,'2017-08-12 00:02:54','DICE',0,'etheroll.png'),(19,'Melon','0x1e549606B695423368e851fF13Edef7eA4790Fe9',0,'2017-06-19','2017-08-08',1690.94,31000,'2017-08-12 00:02:55','MLN',0,'melon.png'),(20,'iExec RLC','0x21346283a31A5AD10Fa64377E77A8900Ac12d469',120883,'2017-07-25','No transfers yet',0,0,'2017-08-12 00:02:57','RLC',0,'rlc.png'),(21,'Stox','0x3dD88B391fe62a91436181eD2D43E20B86CDE60c',106823,'2017-08-09','No transfers yet',0,3215,'2017-08-12 00:02:59','STX',0,'stox.png'),(22,'Humaniq','0xa2c9a7578e2172f32a36c5c0e49d64776f9e7883',504.63,'2017-04-27','2017-08-03',0,0,'2017-08-12 00:03:03','HMQ',0,'humaniq.png'),(23,'Polybius','0xe9Eca8bB5e61e8e32f26B5E8c117561F68084a9C',27477.3,'2017-08-03','No transfers yet',0,0,'2017-08-12 00:03:07','PLBT',0,'polybius.png'),(24,'Santiment','0x6dD5A9F47cfbC44C04a0a4452F0bA792ebfBcC9a',44000.9,'2017-07-12','2017-08-06',1000,45000,'2017-08-12 00:03:08','SAN',0,'santiment.png'),(25,'district0x','0xd20E4d854C71dE2428E1268167753e4C7070aE68',42942.5,'2017-08-04','No transfers yet',0,227,'2017-08-12 00:03:12','DNT',0,'district0x.png'),(26,'arcade.city','0x8D9d0BD75319A3780d3CAb012759EFBAe334291B',0.77,'2017-03-29','No transfers yet',0,56627,'2017-08-12 00:03:15','ARC',0,'arcade-token.png'),(27,'Bitquence','0x9A60Ad6de185C4ea95058601bEaf16f63742782a',0.02,'2017-07-20','No transfers yet',0,13527,'2017-08-12 00:03:18','BQX',0,'bitquence.png'),(28,'DAO.Casino','0x1446bf7AF9dF857b23a725646D94f9Ec49802227',56070.5,'2017-08-11','No transfers yet',0,270,'2017-08-12 00:03:24','BET',0,'dao-casino.png'),(29,'Centra','0x96A65609a7B84E8842732DEB08f56C3E21aC6f8a',6327.93,'2017-07-31','No transfers yet',0,518,'2017-08-12 00:03:26','CTR',0,'centra.png'),(30,'Tierion','0x0C4b367e876d18d5c102023D9240DD7e9C11b380',51482.7,'2017-07-29','2017-08-06',20000,95985,'2017-08-12 00:03:27','TNT',0,'tierion.png');

COMMIT;