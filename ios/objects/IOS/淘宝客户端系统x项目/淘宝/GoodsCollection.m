//
//  GoodsCollection.m
//  TaoBaoClient
//
//  Created by 陈刚 on 15/4/13.
//  Copyright (c) 2015年 陈刚. All rights reserved.
//

#import "GoodsCollection.h"
#import "Goods.h"
@interface GoodsCollection()
{
    NSArray *goodses;
}
@end

@implementation GoodsCollection
static GoodsCollection *instance;

- (id)init{
    if (self = [super init]) {
        goodses = @[
            [[Goods alloc]initWithName:@"小米NOTE移动联通4G" categoryId:@"001" image:[UIImage imageNamed:@"Goods001.jpg"] price:2308 desc:@" 【5年金皇冠老店 +5万保证金】官网原封正品 带防伪码支持官网验证。前1000名购买送豪礼：线控通话耳机+剪卡器(含还原卡托)+ 超薄布丁保护套+专用高清贴膜+防辐射贴+ 擦机布+ 绕线器+看电影支架+本店独享延保一年+优先顺丰包邮 "],
            [[Goods alloc]initWithName:@"红米手机2标准版" categoryId:@"001" image:[UIImage imageNamed:@"Goods002.jpg"] price:699 desc:@" ★★　红米手机2　新一代性价比神器　机遇数码　大量现货　原装未拆封　秒发　　　　 ★★　请注意不同颜色代表不同网络版本　请下拉详情页&darr;　　　　　　　　　　　　　　　 "],
            [[Goods alloc]initWithName:@"红米手机2高配版" categoryId:@"001" image:[UIImage imageNamed:@"Goods003.jpg"] price:938 desc:@" [红米手机2代颜色版本较多,请亲们阅读购买说明按需选购---感谢光临] 【金皇冠信誉小米手机集市销量第一】【购买套餐送高清钢化膜+线控通话耳机+ 剪卡器(含还原卡托)+ 防辐射贴+专用高清贴膜+ 擦机布+ 耳机绕线器+手机电影支架+ 一年延保服务+ 默认享受顺丰包邮 ! "],
            [[Goods alloc]initWithName:@"红米Note电信标准版" categoryId:@"001" image:[UIImage imageNamed:@"Goods004.jpg"] price:828 desc:@" 红米Note 4G标准版电信4G版 IUI V6系统，支持Android4.4，四核 1.2GHz处理器。 5.5英寸 ，1300万像素摄像头，3100mAh 电池容量，8GB ROM+1G RAM 内存，可扩展到32G，小卡,双卡双待，支持电信4G/3G/2G和移动2G和联通2G！正品现货首发！ "],
            [[Goods alloc]initWithName:@"红米Note 4G移动联通版" categoryId:@"001" image:[UIImage imageNamed:@"Goods005.jpg"] price:918 desc:@" 【红米Note　4G增强版,100%官网原封现货,有新升级.购套餐还送皮套等12重豪华大礼】 【红米Note　4G增强版,100%官网原封现货,有新升级.购套餐还送皮套等12重豪华大礼】 "],
            [[Goods alloc]initWithName:@"MIUI/小米 小米Note 5.7寸 双卡移动联通版双4G手机" categoryId:@"001" image:[UIImage imageNamed:@"Goods006.jpg"] price:2308 desc:@" 【八年五皇冠老店 +5万保证金，售后无忧 】官网正品 带防伪码小米Note具有金属边框双曲面玻璃，大屏旗舰5.7英寸全高清大屏，1300万像素光学防抖，HiFi系统，双4G双卡双待。购买就送: 豪华大礼包，购买套餐加送智能天窗皮套 "],
            [[Goods alloc]initWithName:@"大神F2八核智能手机" categoryId:@"001" image:[UIImage imageNamed:@"Goods007.jpg"] price:918 desc:@" 【878实价销售 不虚标价格 坚持诚信为本】【五皇冠信誉 7万保证金 官网正品  买正品手机 选叮当 亲最贴心的手机拍档 口碑第一 售后无忧 】真八核1.7G联发科CPU 、 5.5寸全切合720p屏，2G运行内存+16G手机内存、1300W索尼镜头 【套餐送专用皮套+入耳耳机等12件套礼包】 "],
            [[Goods alloc]initWithName:@"大神F2移动智能手机" categoryId:@"001" image:[UIImage imageNamed:@"Goods008.jpg"] price:899 desc:@" 【官方直营】标配仅需899元   温馨提示：定制版机器后壳有个中国移动LOGO  此次销售的是智尚白定制机【皎月白机身颜色是全白/智尚白机身颜色是前黑后白】  大神F2移动4G版配备八核处理器1300+500万摄像头 2G运行+16G机身 5.5寸高清大屏双卡双待智能手机 "],
            [[Goods alloc]initWithName:@"大神F1八核手机" categoryId:@"001" image:[UIImage imageNamed:@"Goods009.jpg"] price:599 desc:@" 【官方直营】酷派大神 F1青春版（八核版）智珀银机身颜色是浅灰色  F1八核版配备8核处理器，5吋高清屏1300万+500万，双卡双待，仅需599元 "],
            [[Goods alloc]initWithName:@"酷派5951电信版全网通" categoryId:@"001" image:[UIImage imageNamed:@"Goods010.jpg"] price:579 desc:@" 【国行正品，双12畅销新品！顺丰包邮，限量特价， 随时涨价!】【5.5英寸HD 四核 1G运行内存 800万像素相机 电信3G/移动联通2G 双卡双待】 "],
            [[Goods alloc]initWithName:@"酷派大神F2全网通" categoryId:@"001" image:[UIImage imageNamed:@"Goods011.jpg"] price:975 desc:@" 【骁龙8核64位/5.5英寸/16GB ROM+2G RAM 内存】【电信、移动、联通4G全网通，双卡双待】【5.5英寸高清大屏+2500mAh可拆卸式电池+1300万像素】购套餐即送: 线控通话耳机+ 剪卡器(含还原卡托)+ 防辐射贴+ 擦机布+ 耳机绕线器+ 店铺延保一年 "],
            [[Goods alloc]initWithName:@"大神X7移动4G版手机" categoryId:@"001" image:[UIImage imageNamed:@"Goods012.jpg"] price:1599 desc:@" 【官方直营】大神旗舰机型X7移动4G版  钛白晶 土豪金双色来袭  双面玻璃，纯彩航空铝，5.2吋Super AMOLED炫丽屏，支持光学防抖，1920*1080超高清屏  官方标配仅需1599元 "],
            [[Goods alloc]initWithName:@"酷派大神F2手机" categoryId:@"001" image:[UIImage imageNamed:@"Goods013.jpg"] price:915 desc:@" 【移动4G版&mdash;&mdash;联发科CPU分辨率1280X720P 支持 移动4G,3G,2G/联通2G  移动卡专用】【全网通4G版&mdash;&mdash;高通CPU分辨率1280X720P 支持 电信/移动/联通4G 3G 2G全网通吃】 【高清版双4G版&mdash;&mdash;高通CPU分辨率1920X1080P支持 移动/联通4G 3G 2G】 "],
            [[Goods alloc]initWithName:@"大神F1Plus移动手机" categoryId:@"001" image:[UIImage imageNamed:@"Goods014.jpg"] price:599 desc:@" 【官方直营】 顺丰包邮官方标配 【温馨提示：智铂银是浅灰色，智尚白是白色】大神F1Plus移动4G版定制手机仅需599元，大神F1plus移动4G版配备64位处理器，双卡双待，800W+500W摄像头 "],
            [[Goods alloc]initWithName:@"魅族魅蓝 5寸屏移动4G" categoryId:@"001" image:[UIImage imageNamed:@"Goods015.jpg"] price:759 desc:@" 【购机即送时尚靓丽彩壳+线控耳机+剪卡器+高透屏贴+尊享三年保修+好评送50元聊吧话费+顺丰包邮】【购机套餐另送70元钢化玻璃膜防摔防刮花+100元聊吧话费,套餐更优惠&darr;】【原封正品★全国联保★正规授权店铺★无忧退换★诚信卖家★9年老店★值得信赖】　  【每日19点前付款顺丰保价包邮当天发货】　 "],
            [[Goods alloc]initWithName:@"魅蓝note联通版" categoryId:@"001" image:[UIImage imageNamed:@"Goods016.jpg"] price:1108 desc:@" 千元档魅蓝note 大量现货当天发！电信版已经到货！五皇冠大卖家，叮当数码愿竭诚为亲服务，当天17点之前下单购买，即可当天发出，购买魅蓝note就送2.5D弧边钢化玻璃保护膜+青春时尚彩壳（套餐也可换成视窗皮套），套餐加送12件套购机必备礼包，无门槛！不加价！ "],
            [[Goods alloc]initWithName:@"魅蓝5英寸白色版" categoryId:@"001" image:[UIImage imageNamed:@"Goods017.jpg"] price:798 desc:@" 【购机即送布丁套+高清贴膜+线控耳机+剪卡器+电影支架等等,套餐更多豪礼更优惠&darr;】　 【购机即送布丁套+高清贴膜+线控耳机+剪卡器+电影支架等等,套餐更多豪礼更优惠&darr;】　 【原封正品★全国联保★正规授权★无忧退换★诚信商家★8年老店★值得信赖】　　　　 "],
            [[Goods alloc]initWithName:@"魅蓝M1 5寸版" categoryId:@"001" image:[UIImage imageNamed:@"Goods018.jpg"] price:808 desc:@" 【5年金冠魅族大卖家、官网原封正品、支持专卖店检测、全国联保、让你买的放心】买就送:剪卡器(含还原卡托)+ 专用高清贴膜两张+防辐射贴+ 擦机布  + 鱼骨绕线器+ 电影支架+ 小柿子独享延保一年+ 优先顺丰包邮 ! 【购买套餐加送智能休眠皮套+超薄布丁保护套+全5分20好评返现】送完即止 "],
            [[Goods alloc]initWithName:@"Meizu/魅族MX4" categoryId:@"001" image:[UIImage imageNamed:@"Goods019.jpg"] price:1799 desc:@" A17+ A7 的双四核无缝搭配，主频高达 2.2 GHz 。同时支持移动/联通双4G，尽享速度，超强的WiFi性能，2070万像素极致摄像头，助你记录一切美妙瞬间，3100毫安大电池续航能力更强。 "],
            [[Goods alloc]initWithName:@"魅族MX4Pro" categoryId:@"001" image:[UIImage imageNamed:@"Goods020.jpg"] price:2449 desc:@" 【现货当天发，买就送唤醒皮套+保护套+高清贴膜+剪卡器】【灰】代表灰色现货MX4-PRO移动版  【深灰色】代表灰色现货MX4-PRO联通版 【白】代表银翼MX4-PRO移动版现货 【刷通用固件支持双4G】 "],
            [[Goods alloc]initWithName:@"魅蓝NOTE联通4G版" categoryId:@"001" image:[UIImage imageNamed:@"Goods021.jpg"] price:1098 desc:@" 【5年金冠魅族大卖家、官网原封正品、支持专卖店检测、全国联保、让你买的放心】官网原封整箱到货，保证未拆封。买就送高清贴膜+剪卡器（含卡托） ，购买套餐再送超薄布丁保护套+购机必备小礼品+好评20字截图给客服再返现5元！优惠仅限今日 "],
            [[Goods alloc]initWithName:@"魅族MX4移动版" categoryId:@"001" image:[UIImage imageNamed:@"Goods022.jpg"] price:1799 desc:@" ★★★买就送高清贴膜*2+超薄保护套+剪卡器+专用钢化膜★★★ "],
            [[Goods alloc]initWithName:@"华为mate7急速4G" categoryId:@"001" image:[UIImage imageNamed:@"Goods023.jpg"] price:2999 desc:@" 【MATE 7原封现货 购套餐1-6送399元豪礼含：智能开窗皮套+100元聊吧话费+三年质保+剪卡器+高清屏贴*2+好评送50元聊吧话费+好评送彩票！】【建议购买套餐另送钢化玻璃膜+100元聊吧话费 更划算】【16G为标准版，32G为高配版，64G为表尊爵版】【每日19点前付款的订单顺丰当天发】 "],
            [[Goods alloc]initWithName:@"华为荣耀畅玩4" categoryId:@"001" image:[UIImage imageNamed:@"Goods024.jpg"] price:763 desc:@" 买正品手机 到诚亨通讯 淘宝智能手机大卖家，五皇冠信誉  品质保证 售后无忧 华为荣耀畅玩4，5英寸IPS高清显示屏，采用高通骁龙四核处理器，支持LTE Cat4高速网络，小羊皮纹理后背，亲情关怀模式，魅影触控，智像2.0，EMUI 2.3特色功能。 "],
            [[Goods alloc]initWithName:@"荣耀畅玩4X手机" categoryId:@"001" image:[UIImage imageNamed:@"Goods025.jpg"] price:918 desc:@" 好消息：购机即送高透贴膜+剪卡器-----标准版内存1G+8G，高配版内存2G+8G，西湖数码，所售均为原厂未拆封★★★本店承诺：17点前付款，当天发，当天不发赔您10元谢罪！顺丰全国包邮（港澳台地区除外） "],
            [[Goods alloc]initWithName:@"荣耀6plus全系列" categoryId:@"001" image:[UIImage imageNamed:@"Goods026.jpg"] price:2158 desc:@" 活动配件价  引擎耳机原价58 活动价48  钢化贴膜原价50 活动价25  专用皮套原价38 活动价18   带官网发票+10元 "],
            [[Goods alloc]initWithName:@"联想A355e电信版双卡" categoryId:@"001" image:[UIImage imageNamed:@"Goods027.jpg"] price:235 desc:@" 【双模双待CDMA2000+GSM、4.0英寸大屏800x480像素、30万像素、Android 4.3操作系统、国际大牌、高性价比首推】 "],
            [[Goods alloc]initWithName:@"联想A850发哥版智能机" categoryId:@"001" image:[UIImage imageNamed:@"Goods028.jpg"] price:499 desc:@"联想 A850 5.5英寸大屏四核3G发哥版手机，请进入谷米科技的谷米科技实力旺铺，更多中国移动合约购机-合约购机-移动/联通/电信网上营业厅商品任你选购"],
             [[Goods alloc]initWithName:@"联想S668T移动3G" categoryId:@"001" image:[UIImage imageNamed:@"Goods029.jpg"] price:480 desc:@" ①新品现货，极速发货！②移动3G智能手机，4.7英寸晶彩大屏，四核1.3G处理器，1G运行内存，8G机身内存，800W像素高清拍照，外观超薄时尚，硬件高端大气！④全五星好评截图给旺旺客服即可获赠一年保修，享受保修2年！ "],
             [[Goods alloc]initWithName:@"乐檬K3" categoryId:@"001" image:[UIImage imageNamed:@"Goods030.jpg"] price:621 desc:@" ★★【厂家直供,优势货源.正品保证,顺丰包邮】真的好一点，乐檬K3，极致性价比之选. ★★【厂家直供,优势货源.正品保证,顺丰包邮】真的好一点，乐檬K3，极致性价比之选. ★★【限时特惠:现购买套餐即送】侧翻皮套/高清贴膜/耳机/剪卡器等超级大礼包.★★　 "],
             [[Goods alloc]initWithName:@"TCLM2M移动4G八核" categoryId:@"001" image:[UIImage imageNamed:@"Goods031.jpg"] price:899 desc:@" 5.5吋FHD全高清大屏，64位新8核双卡双待,2GB RAM,1300+800万高清摄像头，么么哒功能全新升级 "],
             [[Goods alloc]initWithName:@"努比亚NX503A大牛" categoryId:@"001" image:[UIImage imageNamed:@"Goods032.jpg"] price:1099 desc:@" 买手机，信天探！3G全网通手机，夏普5.0寸高清大屏，1300W+500W双摄像头，可以拍星星的手机，大量现货顺丰包邮！ "],
             [[Goods alloc]initWithName:@"TCL么么哒3N移动4G" categoryId:@"001" image:[UIImage imageNamed:@"Goods033.jpg"] price:939 desc:@" 【金牌代理，实力保证】【移动4G联通双4G电信4G现货抢购】官网原装未拆封发货。【拍下当天发货】首批次到货前黑后白和前黑后金。现货当天发。5.5吋全高清大屏，64位新8核双卡双待,2GB RAM,1300+800万高清摄像头，么么哒功能全新升级 "],
             [[Goods alloc]initWithName:@"谷歌Nexus6" categoryId:@"001" image:[UIImage imageNamed:@"Goods034.jpg"] price:4400 desc:@" Nexus6 香港代购，原封，蓝色，白色现货，拍下即发，全网见证独家现货实力。【现在拍下送钢化膜，保护套等大礼包】。首家全球购认证老店。全网Nexus系列销量第一！ "],
             [[Goods alloc]initWithName:@"苹果5c三网限时特价" categoryId:@"001" image:[UIImage imageNamed:@"Goods035.jpg"] price:1570 desc:@" ┏一一有锁销量冠军一一┓　　┏一一官方小票购物袋一一┓　　┏一一原装正品一一┓　┊　信任承诺服务一生　┊　　┊　 十码合一8天包退换　┊　　┊店保3年 即拍即发┊ ┗一一一一一一一一一一┛　　┗一一一一一一一一一一一┛　　┗一一一一一一一一┛ "],
             [[Goods alloc]initWithName:@"iPhone6美版S版" categoryId:@"001" image:[UIImage imageNamed:@"Goods036.jpg"] price:4349 desc:@" iPhone6 4.7全部现货,本店直接从香港日本美国等苹果直营店采购。【港版2网:移动/联通2G3G4G】【大陆3网:A1586 移动/联通/电信2G3G4G】【日版3网:移动/联通/电信2G3G4G】【美版V版3网:移动2G,联通/电信2G3G4G】【美版S版3网:移动/联通/电信2G3G4G】 "],
             [[Goods alloc]initWithName:@"iPhone6Plus" categoryId:@"001" image:[UIImage imageNamed:@"Goods037.jpg"] price:4830 desc:@" 全网最低价未激活港版16G白=5138库存不多，美国S版16G金色=4918，A1524支持三网4G 大量现货拍美国选框】--【新到台版，新加坡，澳大利亚A1524支持移动联通234G，特价销售请拍亚太选框】--【版本小贴士：全网通4G版本:日版/S版/国行！三网版:美国V版/ATT版/港台 "],
            [[Goods alloc]initWithName:@"Nature Republic 芦荟啫喱" categoryId:@"026" image:[UIImage imageNamed:@"Goods026001.jpg"] price:34 desc:@"Nature Republic 芦荟啫喱"],
            [[Goods alloc]initWithName:@"百雀羚 水嫩倍现盈透精华水" categoryId:@"026" image:[UIImage imageNamed:@"Goods026002.jpg"] price:32 desc:@"百雀羚 水嫩倍现盈透精华水"],
            [[Goods alloc]initWithName:@"水宝宝 无泪无油无香防晒霜 SPF50" categoryId:@"026" image:[UIImage imageNamed:@"Goods026003.jpg"] price:79 desc:@"水宝宝 无泪无油无香防晒霜 SPF50"],
            [[Goods alloc]initWithName:@"Kanebo/嘉娜宝 洁面粉" categoryId:@"026" image:[UIImage imageNamed:@"Goods026004.jpg"] price:95 desc:@"Kanebo/嘉娜宝 洁面粉"],
            [[Goods alloc]initWithName:@"Midea/美的 MXV-ZLP80K03" categoryId:@"009" image:[UIImage imageNamed:@"Goods009001.jpg"] price:399 desc:@"Midea/美的 MXV-ZLP80K03"],
            [[Goods alloc]initWithName:@"Canbo/康宝 ZTP80A-25(H)" categoryId:@"009" image:[UIImage imageNamed:@"Goods009002.jpg"] price:524 desc:@"Canbo/康宝 ZTP80A-25(H)"],
            [[Goods alloc]initWithName:@"Canbo/康宝 ZTP80E-4E" categoryId:@"009" image:[UIImage imageNamed:@"Goods009003.jpg"] price:1145 desc:@"Canbo/康宝 ZTP80E-4E"],
            [[Goods alloc]initWithName:@"Canbo/康宝 ZTP108E-11XG" categoryId:@"009" image:[UIImage imageNamed:@"Goods009004.jpg"] price:1786 desc:@"Canbo/康宝 ZTP108E-11XG"],
            [[Goods alloc]initWithName:@"Midea/美的 MXV-ZLP-Q1031-GO1" categoryId:@"009" image:[UIImage imageNamed:@"Goods009005.jpg"] price:2598 desc:@"Midea/美的 MXV-ZLP-Q1031-GO1"],
            [[Goods alloc]initWithName:@"Canbo/康宝 ZTP380H-1" categoryId:@"009" image:[UIImage imageNamed:@"Goods009006.jpg"] price:656 desc:@"Canbo/康宝 ZTP380H-1"],
            [[Goods alloc]initWithName:@"Midea/美的 MXV-ZLP90QD506" categoryId:@"009" image:[UIImage imageNamed:@"Goods009007.jpg"] price:1036 desc:@"Midea/美的 MXV-ZLP90QD506"],
            [[Goods alloc]initWithName:@"Vatti/华帝 ZTD110-i13007" categoryId:@"009" image:[UIImage imageNamed:@"Goods009008.jpg"] price:2239 desc:@"Vatti/华帝 ZTD110-i13007"]
        ];
    }
    return self;
}

+ (GoodsCollection *)sharedInstance{
    dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        if (!instance) {
            instance = [[GoodsCollection alloc]init];
        }
    });
    if (!instance) {
        instance = [[GoodsCollection alloc]init];
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
}

- (NSArray *)goodsForCategory:(NSString *)categoryId{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"categoryId = %@", categoryId];
    NSArray *array = [goodses filteredArrayUsingPredicate:predicate];
    return array;
}

- (NSArray *)goodsArray{
    return goodses;
}
@end
