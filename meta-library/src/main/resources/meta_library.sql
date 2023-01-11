-- -------------------------
-- Table structure for user
-- -------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- -----------------
-- Records of user
-- -----------------
INSERT INTO `user` VALUES (1,'admin','db6151e3738551e61e707f9dae2b788a','/qr3X0NicrCOk4OaiU7fqA==',1),(2,'editor','e5e755a0e5150798e3d04357747bc977','hMRP2iWdfWKkWgFWLNeo4w==',1),(3,'visitor','4857cf4b3c171169ecc914741434f90d','kSgyuIwfhwuwh7aQDna9Ew==',1);


-- ------------------------------
-- Table structure for category
-- ------------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- ----------------------
-- Records of category
-- ----------------------
INSERT INTO `category` VALUES (1,'文学'),(2,'流行'),(3,'文化'),(4,'生活'),(5,'经管'),(6,'科技');


-- --------------------------
-- Table structure for book
-- --------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cover` varchar(255) DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `author` varchar(255) DEFAULT '',
  `date` varchar(20) DEFAULT '',
  `press` varchar(255) DEFAULT '',
  `abs` varchar(255) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_book_category_on_cid` (`cid`),
  CONSTRAINT `fk_book_category_on_cid` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- ------------------
-- Records of book
-- ------------------
INSERT INTO `book` VALUES (1,'http://localhost:8443/api/file/w88uv3.jpg','是，首相','[英]乔纳森·林恩 / [英]安东尼·杰伊','2017-11','生活·读书·新知三联书店','本书是《是，大臣》的续篇。在《是，首相》当中，大臣吉姆•哈克在党内角力中意外地当上了首相，汉弗莱爵士也提前一步升迁为内阁秘书，而伯纳德则荣任首相的私人秘书。于是，官僚帝国的故事继续在唐宁街十号展开。 小说以及之前的《是，大臣》以吉姆哈克的日记为主，辅以其他政府官员的备忘录、信件等，同样的事件在不同的记录中互相参照，幽默、辛辣，非常精彩。',1),(2,'http://localhost:8443/api/file/pbgtvc.jpg','与父亲的奥德赛','[美]丹尼尔·门德尔松','2022-9','上海人民出版社','门德尔松81岁的数学家父亲去旁听儿子给本科生开设的《奥德赛》研读课，细读关于“漂泊与回家”的12110行史诗，之后父子二人又一起参加《奥德赛》主题游轮旅行。在文本与空间的“奥德赛之旅”中，他得以一次又一次重新理解父亲。《奥德赛》是英雄漂泊多年，历尽千辛万苦得以归乡的故事；也是稚子长大成人，在寻父过程中逐渐了解父亲的故事。《与父亲的奥德赛》则将《奥德赛》中古希腊英雄父子的传奇史诗与当代父子的普通人生并置，在文本与现实的交叠中，两对父子相互映照。时空交错的回旋里，父、子与史诗的故事缓缓展开。',1),(3,'http://localhost:8443/api/file/by1jwh.jpg','活着','余华','2012-8-1','作家出版社','《活着(新版)》讲述了农村人福贵悲惨的人生遭遇。福贵本是个阔少爷，可他嗜赌如命，终于赌光了家业，一贫如洗。他的父亲被他活活气死，母亲则在穷困中患了重病，福贵前去求药，却在途中被国民党抓去当壮丁。经过几番波折回到家里，才知道母亲早已去世，妻子家珍含辛茹苦地养大两个儿女。此后更加悲惨的命运一次又一次降临到福贵身上，他的妻子、儿女和孙子相继死去，最后只剩福贵和一头老牛相依为命，但老人依旧活着，仿佛比往日更加洒脱与坚强。',1),(4,'http://localhost:8443/api/file/s62wdx.jpg','呐喊','鲁迅','1973-3','人民文学出版社','《呐喊》是鲁迅1918-1922年所作的短篇小说的结集，收有《狂人日记》、《孔乙己》、《药》、《明天》、《一件小事》、《头发的故事》等14篇作品。当时正值五四革命精神高扬时期。作者创作小说意在描写“病态社会的不幸的人们”，“揭出病苦，引起疗救的注意”，并为新文化运动“呐喊”。作品真实地描绘了从辛亥革命到五四时期的社会生活，揭示了种种深层次的社会矛盾，对封建制度及陈腐的传统观念进行了深刻的剖析和彻底的否定，表现出对民族生存的浓重的忧患意识和对社会变革的强烈渴望。',1),(5,'http://localhost:8443/api/file/geqpmo.jpg','百年孤独','[哥伦比亚] 加西亚·马尔克斯','2011-6','南海出版公司','《百年孤独》是魔幻现实主义文学的代表作，描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪最重要的经典文学巨著之一。1982年加西亚•马尔克斯获得诺贝尔文学奖，奠定世界级文学大师的地位，很大程度上乃是凭借《百年孤独》的巨大影响。',1),(6,'http://localhost:8443/api/file/pf8ri2.jpg','围城','钱锺书','1991-2-1','人民文学出版社','《围城》是一幅栩栩如生的世井百态图，人生的酸甜苦辣千般滋味均在其中得到了淋漓尽致的体现。钱钟书先生将自己的语言天才并入极其渊博的知识，再添加上一些讽刺主义的幽默调料，以一书而定江山。《围城》显示给我们一个真正的聪明人是怎样看人生，又怎样用所有作家都必得使用的文字来表述自己的“观”和“感”的。',1),(7,'http://localhost:8443/api/file/fwto80.jpg','纪伯伦散文诗经典','[黎巴嫩] 纪·哈·纪伯伦','2005-5','译林出版社','纪伯伦是“旅美派”作家中的杰出代表,被誉为“旅美文学家们的头号领袖”、“旅美文学的旗手和灵魂”。他在诗歌、散文、小说的创作上不落窠臼,开一代文坛新风。尤其值得称道的是他的散文诗创作,达到了炉火纯青的境界,不仅当时的“旅美派”作家中无人能比,就是当今阿拉伯文坛上也很少有人堪与之相提并论。他不仅在用母语阿拉伯语创作上取得了可观的成就,还用英文写下了数部传世佳作,轰动了美国,传遍西方和东方。',1),(8,'http://localhost:8443/api/file/x8ywfn.jpg','无问西东','季羡林','2019-10','天地出版社','《无问西东：季羡林生命之书》，从超200万字文集里粹选25万字，囊括了季老人生中的重要阶段，包括童年成长、清华园求学、留德十年、北大执教、牛棚杂忆、病榻杂忆等，特别收录《不完满才是人生》《听雨》《我的童年》《清塘荷韵》《怀念母亲》《九十抒怀》《月是故乡明》等经典篇目，将季羡林近80年的创作经历整体性地呈现，也尽收季老百岁人生智慧。',1),(9,'http://localhost:8443/api/file/edolgy.jpg','我的心中每天开出一朵花','幾米','2007-7','人民文学出版社','《我的心中每天开出一朵花》的主要内容是：畿米“手绘图像”的梦想之作，每天画下一朵花，象征着梦想与期望，更是一种生命力的展现。书中有一个男主角，并有一只小兔子、小女孩陪伴，他们用极富想象力的图片和简洁深刻的语言带领大家在作者丰富的内心世界里畅游。',2),(10,'http://localhost:8443/api/file/y4jfxy.jpg','挪威的森林','[日]村上春树','2014-4','上海译文出版社','《挪威的森林》系日本著名作家村上春树的重要作品之一。汉堡机场一曲忧郁的《挪威的森林》，复苏了主人公渡边感伤的二十岁记忆：娴静缅腆、多愁善感的直子，是他动情倾心的女孩，那缠绵的病况，如水的柔情，甚至在她花烛香销之后，仍令他无时或忘；神采飞扬、野性未脱的绿子，是他邂逅相遇的情人，那迷人的活力、大胆的表白，即使是他山盟已订之时，也觉她难以抗拒。悲欢恋情，如激弦，如幽曲，掩卷犹余音颤袅；奇句妙语，如泉涌，如露凝，读来真口角噙香。《挪威的森林》是纯而又纯的青春情感，百分之百的恋爱小说。',2),(11,'http://localhost:8443/api/file/3giyex.jpg','2001：太空漫游','[英]阿瑟·克拉克','2014-5-1','上海人民出版社','所有的故事，都开始于300万年前\n\n一块神秘的黑色石板，出现在非洲丰饶广袤的草原上。没有人知道是谁放在那里的，因为那里根本没有“人”。但地球未来的主宰者，却从此踏上了他们漫长的征途。300万年后的一个寻常日子，一块黑色石板在月球上被人类挖出。\n\n“发现号”宇宙飞船沉稳老练的鲍曼船长，带着他的精英船员和顶尖科学家团队，在超级电脑“哈儿”的辅佐下，开启了对这石板主人的秘密追寻。此时他一点儿也不知道，他的全部船员都将遇害，不知道他的忠诚伙伴“哈儿”会倒戈一击，更加不知道，他自己即将变成一位真正的神。',2),(12,'http://localhost:8443/api/file/bchxr2.jpg','寻获与失落','[美国] 厄休拉·勒古恩','2022-9','河南文艺出版社','《寻获与失落》是勒古恩的中篇作品合集，汇集十三部中篇，囊括五种世界观，既有长篇的恢弘，又有短篇的轻盈，每部均可独立成篇，又与其他作品遥相呼应，极为全面地展现了勒古恩的文字风格与思想深度，由此可纵览勒古恩写作生涯的整体图景。',2),(13,'http://localhost:8443/api/file/5itukx.jpg','撒哈拉的故事','三毛','2003-8','哈尔滨出版社','三毛作品中最脍炙人口的《撒哈拉的故事》，由12篇精彩动人的散文结合而成，其中《沙漠中的饭店》，是三毛适应荒凉单调的沙漠生活后，重新拾笔的第一篇文字，自此之后，三毛便写出一系列以沙漠为背景的故事，倾倒了全世界的中文读者。',2),(14,'http://localhost:8443/api/file/aop4oq.jpg','生死疲劳','莫言','2022-1','浙江文艺出版社','不看不知道，欲哭又想笑。活着不容易，幽默无价宝。——莫言\n\n五十年间西门闹经历六次转世，\n\n一世为驴，二世为牛，三世为猪，四世为狗，五世为猴，最终降生为人。\n\n在这六世里，他目睹蓝脸一家三代经历人生的生死疲劳，\n\n他们爱就爱到底，恨就恨到底，犟就犟到底，干就干到底，\n\n有极致的痛苦，也有彻底的放纵。\n\n而他们的故事，要从1950年1月1日讲起……\n\n2012年诺贝尔文学奖授奖辞\n\n莫言是继拉伯雷、斯威夫特以及我们这个时代的加西亚马尔克斯之后，同时代作家中文笔更妙趣横生和令人惊骇的一位。',2),(15,'http://localhost:8443/api/file/t69nxc.jpg','六人飞行组','祝晓羽','2003-06','中国少年儿童出版社','世界是否像我们看到的那样平淡无奇？从一个周五夜晚开始，住在上海的女孩安琪彻底改变了想法：陌生女孩的奇怪问题，地下穿行的不明生物，从窗口习飞进的少年，还有隐隐约约居在神秘树林中的老博士。　路人物粉墨登场，天上飞的地下跑的无所不有，她和五个来自不同的国家的伙伴一起，被卷入了一场不可思议的冒险，并接触到了一个充满诡异的地下世界。原来，一切都因为梦游发明麦博士发明的一种习行药水……',2),(16,'http://localhost:8443/api/file/6d8q3c.jpg','帷幕','[英] 阿加莎·克里斯蒂',' 2021-10','新星出版社','波洛和黑斯廷斯的探案生涯回到了起点——斯泰尔斯庄园，正是在这里，初到英国的波洛侦破了第一起谋杀案。如今，波洛已风烛残年。饱受关节炎之苦、行动受限的他依然拥有一颗敏捷的头脑。他召唤老友黑斯廷斯回到斯泰尔斯庄园协助他探案。\n\n这一次，虽然波洛知晓凶手的身份，但他并没有向黑斯廷斯透露，只是用神秘的X来代替。连环杀手X已经罪行累累。波洛警告道，X马上会再制造一起新的命案。在帷幕降下之前，这对黄金搭档必须迅速行动，阻止凶手再次犯罪……',2),(17,'http://localhost:8443/api/file/y3tetj.jpg','南京大屠杀','[美]张纯如（Iris Chang）','2015-8','中信出版社','在这本书的核心篇章里，作者通过采访当事人、查阅档案资料以及实地考察与研究，极其详实地记录了日本军队残暴、灭绝人性的屠杀行动，深刻揭示了日本侵略军的凶残本性。同时，作者还生动记述了南京安全区里以德国商人约翰•拉贝、美国外科医生罗伯特•威尔逊、“南京活菩萨”明妮•魏特琳拯救中国人的英雄壮举。\n\n最后，作者以悲愤的笔触揭露了世人所了解的南京大屠杀、日本占领下的南京、对日本战犯的审判、幸存者的命运等鲜为人知的情节。\n\n这本书是关于这段恐怖历史的权威之作。',3),(18,'http://localhost:8443/api/file/zf0exy.jpg','赫尔佐格谈赫尔佐格','[英]保罗·克罗宁','2008-1','文汇出版社','本书汇集了对这位曾被弗朗索瓦·特吕弗赞誉为当世最重要的电影导演所展开的一系列访谈。我们自以为对赫尔佐格所拥有的认识，其实绝大部分并非真实：在他身上集聚着各式各样的传说、谣言乃至弥天大谎，数目相当惊人。本书则为此提供了一次辨别是非的好机会，既有关于其影片摄制过程的阐幽明微，又有针对那些不实之词的拨乱反正，涉及其电影生涯的各段历程，方方面面。',3),(19,'http://localhost:8443/api/file/hfk6hz.jpg','知堂回想錄','周作人','2019-7','牛津大學出版社','《知堂回想錄》是一本傷逝之作，一九六二年書寫到第四卷「北大感舊錄」，知堂老人說，「今天聽說胡適之於二月二十四日在臺灣去世了，這樣便成為我的感舊錄裏的材料，因為這感舊錄中是照例不收生存的人的。」《回想錄》七○年五月香港三育初版，至今已歷半個世紀，箇中出版的艱辛曲折，請參見本書附錄曹景行文。近十幾年來，曾有多家出版社相繼重印《回想錄》，然因為種種條件的限制，一直未能達到知堂後人所說的「接近著者的本意」。',3),(20,'http://localhost:8443/api/file/z2y6nc.jpg','上学记','文靖','2009-9','生活·读书·新知三联书店','《上学记(修订版)》内容简介：“中国文库”主要收选加世纪以来我国出版的哲学社会科学研究、文学艺术创作、科学文化普及等方面的优秀著作。这些著作，对我国百余年来的政治、经济、文化和社会的发展产生过重大积极的影响，至今仍具有重要价值，是中国读者必读、必备的经典性、工具性名著。',3),(21,'http://localhost:8443/api/file/dh8plg.jpg','昨天的世界','[奥地利] 斯蒂芬·茨威格','2000-9','安徽文艺出版社','本书是茨威格传记系列中的一册，讲述了斯蒂芬·茨威格自己的一生，全书详细记录了一个欧洲人对过去世界的追忆，对读者全面了解作家，人道主义者和和平主义者的战斗和不屈的一生具有相当重要的意义。',3),(22,'http://localhost:8443/api/file/l0mw0t.jpg','伊凡诺夫·海鸥','[俄] 契诃夫','2014-9','上海译文出版社','本丛书将契诃夫戏剧作品的优秀中文译本结集，分四卷出版。本卷包含名剧《海鸥》和《伊凡诺夫》。喜剧《海鸥》描写乡村富家少女妮娜的爱情理想和遭遇，于1898年在莫斯科艺术剧院上演，获得空前成功，高翔着的海鸥形象成了莫斯科艺术剧院的院徽。《伊凡诺夫》是契诃夫的第一部戏剧力作。',3),(23,'http://localhost:8443/api/file/sqpotu.jpg','桃花扇','孔尚任','2016-11','中华书局','《桃花扇》是清代著名的传奇剧本，与《西厢记》《牡丹亭》《长生殿》并称中国古代“四大名剧”。如孔尚任自己所说，“借离合之情，写兴亡之感”，中原才子侯方域，巧遇秦淮佳人李香君，题诗定情宫扇上，却难抵历史的风云变幻——李自成陷落京师，八旗军摧垮南朝。侯李情缘在烽火板荡的晚明变局中，如柳絮浮萍，相遇相散，儿女情与家国情交织着，吟唱出一首婉曲、浩荡长歌。此剧代表了中国古代历史剧创作的水平。',3),(24,'http://localhost:8443/api/file/h41jua.jpg','安提戈涅','[法]让·阿努伊','2019-10','人民文学出版社','《安提戈涅》是法国剧作家让·阿努伊的代表作，根据古希腊剧作家索福克勒斯的同名戏剧重写，一九四四年二月四日在巴黎首次上演，获得巨大成功，之后场场爆满，观众中甚至有许多德国占领军军官和士兵。大半个世纪以来，这部现代肃剧长盛不衰，在世界各地的舞台上演出，剧本也长年占据法国图书网站榜首。',3),(25,'http://localhost:8443/api/file/0yy3hd.jpg','自知','朱建军','2022-1-1','中国广播电视出版社','“认识自己”不仅是一种想法，而是有趣、有效的高明做法。用原始思维拆解真实自己，“练习百宝箱”+“故事铺”趣味看穿自己，掌握“心病”核心症结及变好秘诀。著名心理学家、意象对话疗法创始人朱建军带你彻底看清隐秘的自己。',4),(26,'http://localhost:8443/api/file/xj3kq9.jpg','士兵突击','兰晓龙','2018-1','人民文学出版社','他来自农村，生性怯懦，在人才辈出的钢七连显得如此不着调。但就是这种笨拙，让他心无旁骛，让他心思简单，无往而不胜。\n\n从不抱怨，相信别人就像相信自己，承担所有误解，接受一切现实而永不改变内心的信仰。他是当代中国军人最真实的士兵形象，他叫许三多，一名二级士官……',4),(27,'http://localhost:8443/api/file/qfnsya.jpg','永恒的时光之旅','[日] 星野道夫','2016-1','广西师范大学出版社','《永恒的时光之旅》收录星野道夫未公开摄影作品及西伯利亚绝笔日记 ，是对星野道夫史诗般摄影生涯的回顾和致敬。星野道夫用镜头扑捉自然的至美和生命的脆弱与坚强，用最纯粹的热爱记录极地的风景、动物和人，他的文字也如他的影像一样质朴温暖，每一次旅程都是触动人心的 “心灵之旅”。星野道夫曾说：“当人生将走至终点，我希望我的生命能结束在阿拉斯加。”他将人生中最青春的岁月献给了这片极北之地，而这里也成为他最后的安眠之所。他用镜头为我们留下那些珍贵的即将消逝的生命和风景，也书写了人与自然的永恒对话。',4),(28,'http://localhost:8443/api/file/7mgfzz.jpg','攀岩人生','[美] 汤米·考德威尔','2020-3','中信出版集团','汤米·考德威尔以相当诚实的方式分享了自己成长与冒险的旅程，你可以从无数细节中看到自己的影子：少年汤米的手足无措、尴尬青春；青年汤米在成人世界里经历的猜忌、迷茫、失败；到最后探索未知的自我， 放开心胸让自己成长，学会与他人分享。如今已经40多岁的汤米，人生经历十分传奇，被恐怖分子挟持、被迫杀人、惨遭断指、不幸婚变，但每多碰到一次挫折，就多一分坚定的意志。',4),(29,'http://localhost:8443/api/file/cat5kc.jpg','在峡江的转弯处','陈行甲','2021-1','人民日报出版社','《在峡江的转弯处：陈行甲人生笔记》是陈行甲的自传体随笔，从童年岁月写起，写母亲，写爱人；写了从大学毕业到基层工作九年多的生活经历；回顾了作者在巴东任县委书记期间的工作和生活；讲述了作者转场公益几年来的经历和感受。从本书中，作者用鲜活的故事和大量的细节讲述了一个普通人的爱与成长，以及如何在世事变幻中守住内心和实践的知行合一。',4),(30,'http://localhost:8443/api/file/ks7ufs.jpg','肖申克的救赎','[法]弗兰克`达拉邦特','2015-3','湖南人民出版社','一场看似无懈可击的谋杀审判，一段跨越二十年的高墙抗争，一曲动人心魄的越狱传奇……蒙冤入狱的银行家安迪?杜弗雷在地狱般的肖申克监狱，凭借理性与希望，二十年如一日坚守自己的救赎之路，救人救己，穿越层层苦难，最终逃出生天，并将希望深深印刻在肖申克每一个人的心中……这一个斯蒂芬?金的故事，经达拉邦特改编并拍摄，成为电影史上最光辉的一笔，曾获奥斯卡最佳影片、最佳剧本、最佳男主角等七项大奖提名，给无数人带来勇气与希望。',4),(31,'http://localhost:8443/api/file/dw2edb.jpg','人间有至味','汪曾祺','2018-1-1','浙江文艺出版社','“资深吃货”汪曾祺的经典美食散文集，收录《故乡的食物》《故乡的野菜》等38篇不同时期的经典名作，以及12幅汪老私房文人画，彩色印刷，精致唯美。\n\n这个世界上，还有比汪曾祺更懂吃的人吗？无论是春天的萝卜、秋天的糖炒栗子，还是新采的枸杞头、缸腌的臭苋菜；不管是江南的马兰头、朔方的手把肉，还是故乡的野菜、他乡的菜肴，所有的吃食，在他的笔下都是人间的至味。《人间有至味》，一花一叶皆有情，一茶一饭过一生。只有懂得生活的人，才是幸福的人。',4),(32,'http://localhost:8443/api/file/nnhek4.jpg','杀死一只知更鸟','[美国] 哈珀·李','2017-2','译林出版社','《杀死一只知更鸟》是公认的美国文学经典，而它在教育领域的意义却使其突破了国界，成为世界上最有名的成长小说之一。《杀死一只知更鸟》在西方世界的影响力巨大，是美国中小学的必读书目，图书馆借阅次数最高的图书，以及英国青少年最喜爱的图书，在最近一次民意投票中，它甚至压倒《圣经》，成为“最具启示意义的书”。',4),(33,'http://localhost:8443/api/file/zkwqcs.jpg','激荡三十年','吴晓波','2017-11','中信出版社','本书作者没有用传统的教科书或历史书的方式来写作这部著作，而是站在民间的角度，以真切而激扬的写作手法描绘了中国企业在改革开放年代走向市场、走向世界的成长、发展之路。改革开放初期汹涌的商品大潮；国营企业、民营企业、外资企业，这三种力量此消彼长、互相博弈的曲折发展；整个社会的躁动和不安……整部书稿中都体现得极为真切和实在。作者用激扬的文字再现出人们在历史创造中的激情、喜悦、呐喊、苦恼和悲愤。',5),(34,'http://localhost:8443/api/file/pqsok6.jpg','权力与领导','[美] 詹姆斯·克劳森','2019-7','民主与建设出版社','《权力与领导》这本书对于寻求建立长效领导力，塑造企业文化和价值观的企业家、管理人员来说是极具启发和实操意义的。\n\n领导力并不仅仅是管理职位上碾压别人的权力，也不仅仅是大数据死理性派的运筹帷幄，还有属于企业家精神的热情和感染力，包括选择什么样的企业战略，建立什么样的企业文化，如何陈述企业愿景。这些都是企业长效发展必备的顶层设计，而一个高屋建瓴的企业家不应该忽略这一点。',5),(35,'http://localhost:8443/api/file/0au28f.jpg','史蒂夫·乔布斯传','[美] 沃尔特·艾萨克森','2011-11','中信出版社','这本乔布斯唯一授权的官方传记，在2011年上半年由美国出版商西蒙舒斯特对外发布出版消息以来，备受全球媒体和业界瞩目，这本书的全球出版日期最终确定为2011年11月21日，简体中文版也将同步上市。\n\n两年多的时间，与乔布斯40多次的面对面倾谈，以及与乔布斯一百多个家庭成员、 朋友、竞争对手、同事的不受限的采访，造就了这本独家传记。\n\n尽管乔布斯给予本书的采访和创作全面的配合，但他对内容从不干涉，也不要求出版前阅读全文的权利。对于任何资源和关联的人，他都不设限，甚至鼓励他所熟知的人袒露出自己的心声。',5),(36,'http://localhost:8443/api/file/osxebj.jpg','浪潮之巅','吴军','2011-8','电子工业出版社','近一百多年来，总有一些公司很幸运地、有意识或无意识地站在技术革命的浪尖之上。在这十几年间，它们代表着科技的浪潮，直到下一波浪潮的来临。\n\n从一百年前算起，AT&T 公司、IBM 公司、苹果公司、英特尔公司、微软公司、思科公司、雅虎公司和Google公司都先后被幸运地推到了浪尖。虽然，它们来自不同的领域，中间有些已经衰落或正在衰落，但是它们都极度辉煌过。本书系统地介绍了这些公司成功的本质原因及科技工业一百多年的发展。',5),(37,'http://localhost:8443/api/file/pseo1i.jpg','DOOM启世录','[美] David Kushner','2015-10-1','电子工业出版社','本书忠实详尽地讲述了两个天才游戏玩家如何走上游戏之路，如何制作出影响力极大的游戏作品——DOOM和Quake，以及他们为何在最辉煌的时候分道扬镳。\n\n本书是一部游戏领域的传记，不同的读者能从中得到不同的体验：游戏制作的背景内幕、光环之中的趣闻轶事、年少创业的梦想豪情、奋斗途中的汗水艰辛，亦或是那成名之后的势易情迁、独辟蹊径的商业模式、天下为公的黑客精神。',5),(38,'http://localhost:8443/api/file/f91xlu.jpg','乱世华尔街','渔阳','2015-12-1','中国人民大学出版社','《乱世华尔街》以华尔街从“盛世末期”到金融海啸，再到浴火重生的大时代故事为背景，以作者的亲身经历为基本内容，将这场人类历史上百年不遇的金融危机展现给读者。华尔街是没有硝烟的战场，作者把市政债券作为切入口，带读者亲历了镀金时代、夏季风暴、贝尔斯登陷落、雷曼地震、黑暗时刻的腥风血雨，整个故事紧凑到让人容不得半点喘息，仿佛在看一部悬疑剧，说故事的人抽丝剥茧，把故事的来龙去脉说的仔仔细细，把读者引入不知深深几许的连环计，次贷危机的魔爪一点点在华尔街蔓延开来，烧毁了五大投行中的三家。',5),(39,'http://localhost:8443/api/file/d8dsoz.jpg','房间里的成年人','[希]雅尼斯·瓦鲁法克斯','2021-10','中信出版集团','2015年初，欧盟委员会、欧洲央行和国际货币基金组织（“三驾马车”）为救助希腊采取的紧缩措施越来越严厉，严重拖累了本就存在结构性问题的希腊经济，使该国陷入财政紧缩—经济衰退的恶性循环之中。债务危机并未化解，政治和社会却持续动荡。绝望的希腊民众将反对实施紧缩政策以换取救助贷款的激进左翼联盟推上了执政舞台。身为资深经济学教授、知名博弈论专家的瓦鲁法克斯——也就是本书作者，临危受命出任财政部长，负责与“三驾马车”继续展开已陷入僵局的谈判。',5),(40,'http://localhost:8443/api/file/zfrupy.jpg','城市化转型与土地陷阱','华生','2013-11-1','东方出版社','市化转型与土地问题是事关中国改革方向和发展命运的重大问题，但同时又极其复杂，不仅在实践中出现了土地财政、地方债务、高房价等连锁问题，在学术界也引起了相当多的争议和分歧。本书指出，目前城市化转型面临的问题已不再是“农村、农民、农业”的老三农问题，而是“农地流转、农民离乡务工、农地非农用”的新三农问题。中国的城市化道路要从“土地城市化”真正走上“人的城市化”，并成功实现现代化转型，其核心是重新调整“土地开发权”的分配，实现公民权利的均等化和人力资本的普遍升级。',5),(41,'http://localhost:8443/api/file/mu0pxa.jpg','星际航行概论','钱学森','2008-12','中国宇航出版社','《星际航行概论》是钱学森于20世纪60年代初撰写的中国第一本高等院校航天专业基础教材，系统地介绍了星际航行技术的各个方面，包括运载火箭的动力系统、运载火箭的设计及制造过程、运载火箭及星际飞船的飞行轨道、控制系统的设计原则及设计过程、星际航行中的通讯问题及防辐射问题、解决飞船再入大气层的设计原理、星际飞船的设计问题，以及星际航行的前景展望等。',6),(42,'http://localhost:8443/api/file/7g58b1.jpg','战斗细胞','[德]菲利普·德特玛','2022-10','海南出版社','既直观、轻松，又精准、实用，还不乏时尚、极客的气息，这就是本书呈现给你“免疫”知识的方式。它以故事性的讲解和风格鲜明的插图，描述人体的免疫机制、免疫系统的各组成部分、各类细胞及重要蛋白（抗体、MHC、细胞因子等），与人有关的各种微生物（包括益生菌和各种病原体），以及多方的相互作用，介绍自愈、发炎、流行病、抗菌、抗病毒、寄生虫、过敏、疫苗、癌症、自身免疫性疾病等种种健康议题，帮你过上更为轻松安泰、胸有成竹的现代人生。',6),(43,'http://localhost:8443/api/file/iuwpfv.jpg','DK蘑菇大百科','[丹] 托马斯·莱瑟斯',' 2020-6','湖南科学技术出版社','《DK蘑菇大百科》是由视觉工具书知名品牌DK打造的关于蘑菇的经典图文读本。配有2000多幅精美的多角度彩色插图，直观展示蘑菇丰富的形态。系统介绍了450多种野生蘑菇，涵盖常见品种和新发现：主要特征、生长环境、出菇季节、分布情况、可食用性、学名和俗名，以及分辨它们的切实可靠的基本知识和方法。',6),(44,'http://localhost:8443/api/file/6sox4u.jpg','地球的故事','[美]罗伯特·哈森','2021-3','中信出版集团','地球是一个不断变化的星球。从第一个原子到分子，从矿物到岩浆，从花岗岩地壳到单细胞生物，一直到蓬勃兴盛的生命景观，这颗星球始终动荡不定、变化从未停歇。这是一个激进的、全新的地球传记，美国卡内基研究所高级研究员、畅销书作家罗伯特·哈森向我们揭示了岩石圈和生物圈的协同演化如何将地球塑造成太阳系中独一无二的行星。',6),(45,'http://localhost:8443/api/file/o07paz.jpg','时间简史','[英] 史蒂芬·霍金','2006-6','湖南科学技术出版社','《时间简史·果壳中的宇宙》(典藏版)(套装共2册)收录了史蒂芬·霍金的《时间简史》插图版和《果壳中的宇宙》两部书。史蒂芬·霍金的《时间简史》在1998年首版以来的岁月里，已成为全球科学著作的里程碑。它被翻译成40种文字，销售了1000万册，成为国际出版史上的奇观。《时间简史》插图版是探索时间和空间核心秘密的引人入胜的故事。',6),(46,'http://localhost:8443/api/file/go6lkx.jpg','对伪心理学说不','[加拿大] 基思·斯坦诺维奇','2012-1-1','人民邮电出版社','在今天的大众媒体和图书市场上，到处充斥着关于潜能提升、心理操控、色彩星座、催眠读心等伪装成心理学的主题，更有一些伪心理学家、所谓的心理治疗师打着心理学的旗号欺世盗名，从中渔利。在浩如烟海、良莠不齐的心理学信息面前，如何拨除迷雾，去伪存真，成为一个明智的心理学信息的消费者呢？本书将教给你科学实用的批判性思维技能，将真正的心理学研究从伪心理学中区分出来，告诉你什么才是真正的心理学。',6),(47,'http://localhost:8443/api/file/rwu8ye.jpg','上帝掷骰子吗','曹天元','2008-9','辽宁教育出版社','《上帝掷骰子吗》这本书是关于量子论的故事。量子论是一个极为奇妙的理论：从物理角度来说，它在科学家中间引起了最为激烈的争议和关注；从现实角度来说，它给我们的社会带来了无与伦比的变化和进步；从科学史角度来说，也几乎没有哪段历史比量子论的创立得到了更为彻底的研究。然而不可思议的是，它的基本观点和假说至今没有渗透到大众的意识中去，这无疑又给它增添了一道神秘的光环。',6),(48,'http://localhost:8443/api/file/r2jlvr.jpg','赶往火星','[美]罗伯特·祖布林','2012-3-1','科学出版社','这是一个宛如科幻小说的大胆计划，可能正是因此，已故科幻大师阿瑟•克拉克为该书第一版（1996）作序。而跟科幻不同的是，祖布林书写的是科学事实。15年来，祖布林已成为无数耽于幻想的科学家与外太空探索者的民间英雄。祖布林并没有费力气来解释为什么要去探索火星，他在这本书里用主要篇幅来阐述如何让这件事成真：200~300亿美元的合理预算，以及“轻装上阵”的登陆准则。',6);


-- ----------------------------------
-- Table structure for admin_menu
-- ----------------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `name_zh` varchar(64) DEFAULT NULL,
  `icon_cls` varchar(64) DEFAULT NULL,
  `component` varchar(64) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- --------------------------
-- Records of admin_menu
-- --------------------------
INSERT INTO `admin_menu` VALUES (1,'/admin','AdminIndex','首页','el-icon-s-home','AdminIndex',0),(2,'/admin/home','AdminHome','系统主页',NULL,'home/AdminHome',1),(3,'/admin','User','用户管理','el-icon-user','AdminIndex',0),(4,'/admin/user/profile','UserProfile','用户信息',NULL,'user/UserProfile',3),(5,'/admin/user/role','UserRole','角色配置',NULL,'user/UserRole',3),(6,'/admin','Content','内容管理','el-icon-tickets','AdminIndex',0),(7,'/admin/content/book','BookManagement','图书管理',NULL,'content/BookManagement',6);


-- --------------------------------
-- Table structure for admin_role
-- --------------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `name_zh` varchar(100) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- ------------------------
-- Records of admin_role
-- ------------------------
INSERT INTO `admin_role` VALUES (1,'sysAdmin','系统管理员',1),(2,'contentManager','内容管理员',1),(3,'visitor','访客',1);


-- ---------------------------------------
-- Table structure for admin_permission
-- ---------------------------------------
DROP TABLE IF EXISTS `admin_permission`;
CREATE TABLE `admin_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `desc_` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- --------------------------------
-- Records of admin_permission
-- --------------------------------
INSERT INTO `admin_permission` VALUES (1,'users_management','用户管理','/api/admin/user'),(2,'content_management','内容管理','/api/admin/content');


-- --------------------------------------
-- Table structure for admin_user_role
-- --------------------------------------
DROP TABLE IF EXISTS `admin_user_role`;
CREATE TABLE `admin_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_operator_role_operator_1` (`uid`),
  KEY `fk_operator_role_role_1` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- ------------------------------
-- Records of admin_user_role
-- ------------------------------
INSERT INTO `admin_user_role` VALUES (10,1,1),(20,2,2),(30,3,3);


-- ----------------------------------------
-- Table structure for admin_role_menu
-- ----------------------------------------
DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) DEFAULT NULL,
  `mid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- --------------------------------
-- Records of admin_role_menu
-- --------------------------------
INSERT INTO `admin_role_menu` VALUES (2,1,1),(4,1,2),(6,1,3),(8,1,4),(10,1,5),(12,1,6),(14,1,7),(16,2,1),(18,2,2),(20,2,6),(22,2,7),(24,3,1),(26,3,2);


-- ---------------------------------------------
-- Table structure for admin_role_permission
-- ---------------------------------------------
DROP TABLE IF EXISTS `admin_role_permission`;
CREATE TABLE `admin_role_permission` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `rid` int(20) DEFAULT NULL,
  `pid` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_role_permission_role_1` (`rid`),
  KEY `fk_role_permission_permission_1` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- -------------------------------------
-- Records of admin_role_permission
-- -------------------------------------
INSERT INTO `admin_role_permission` VALUES (2,1,1),(4,1,2),(6,1,3),(8,2,2);