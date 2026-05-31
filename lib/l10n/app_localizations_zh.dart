// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get vietnam => '越南';

  @override
  String get appName => 'S-Mate';

  @override
  String get login => '登录';

  @override
  String get register => '注册';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get password => '密码';

  @override
  String get home => '首页';

  @override
  String get profile => '个人资料';

  @override
  String get tripPlanner => '旅行规划器';

  @override
  String get generateItinerary => '生成行程';

  @override
  String get destination => '目的地';

  @override
  String get budget => '预算';

  @override
  String get peopleCount => '人数';

  @override
  String get startDate => '开始日期';

  @override
  String get endDate => '结束日期';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get logout => '退出登录';

  @override
  String get notifications => '通知';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get loading => '加载中';

  @override
  String get error => '错误';

  @override
  String get success => '成功';

  @override
  String get retry => '重试';

  @override
  String get myTrip => '我的旅行';

  @override
  String get scan => '扫描';

  @override
  String get map => '地图';

  @override
  String get aiChat => 'AI 聊天';

  @override
  String get all => '全部';

  @override
  String get upcoming => '即将开始';

  @override
  String get inProgress => '进行中';

  @override
  String get completed => '已完成';

  @override
  String get cancelled => '已取消';

  @override
  String get couldNotLoadTrips => '无法加载旅行';

  @override
  String get couldNotLoadTripsMessage => '我们现在无法加载您的旅行。请重试。';

  @override
  String get tryAgain => '重试';

  @override
  String get noTripsYet => '还没有旅行';

  @override
  String get noTripsYetMessage => '创建您的第一个 AI 行程，它会显示在这里。';

  @override
  String get noTripsFoundForFilter => '没有找到符合此筛选的旅行';

  @override
  String get createNewTrip => '创建新旅行';

  @override
  String get destinationPending => '目的地待定';

  @override
  String defaultTripName(Object destination) {
    return '$destination之旅';
  }

  @override
  String budgetValue(Object value) {
    return '预算：$value';
  }

  @override
  String get close => '关闭';

  @override
  String get back => '返回';

  @override
  String get create => '创建';

  @override
  String get update => '更新';

  @override
  String get edit => '编辑';

  @override
  String get done => '完成';

  @override
  String get customize => '自定义';

  @override
  String get openMap => '打开地图';

  @override
  String get createTrip => '创建旅行';

  @override
  String get welcomeBackTraveler => '欢迎回来，旅行者！';

  @override
  String get planNextAdventure => '规划您的下一次冒险';

  @override
  String get itineraryReminder => '行程提醒';

  @override
  String get nextActivitySoon => '您的下一个活动即将开始。';

  @override
  String get mapUpdate => '地图更新';

  @override
  String get nearbyRecommendationsReady => '附近推荐已准备好探索。';

  @override
  String get albumReminder => '相册提醒';

  @override
  String get addTodaysPhotos => '将今天的照片添加到您的旅行相册。';

  @override
  String timeAgoHours(Object hours) {
    return '$hours小时前';
  }

  @override
  String timeAgoDays(Object days) {
    return '$days天前';
  }

  @override
  String get planYourFirstTrip => '规划您的第一次旅行';

  @override
  String get chooseDestination => '选择您的目的地';

  @override
  String get newStatus => '新建';

  @override
  String get action => '操作';

  @override
  String get generateTrip => '生成旅行';

  @override
  String get generateTripDescription => '根据日期和预算创建新的 AI 行程。';

  @override
  String get currentTrip => '当前旅行';

  @override
  String get currentTrips => '当前旅行';

  @override
  String get viewMyTrips => '查看我的旅行';

  @override
  String get viewItinerary => '查看行程';

  @override
  String get popularDestinations => '热门目的地';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get createAccount => '创建账户';

  @override
  String get signInContinueJourney => '登录以继续您的旅程';

  @override
  String get signUpStartAdventure => '注册以开始规划下一次冒险';

  @override
  String get loginSuccessful => '登录成功！';

  @override
  String get accountCreatedSuccessfully => '账户创建成功！';

  @override
  String get resetPassword => '重置密码';

  @override
  String get resetPasswordInstructions => '输入您的电子邮件，我们会发送重置链接。';

  @override
  String get sendResetLink => '发送重置链接';

  @override
  String get passwordResetOtpSent => '密码重置 OTP 已发送！';

  @override
  String get fullName => '全名';

  @override
  String get fullNameHint => 'John Doe';

  @override
  String get location => '位置';

  @override
  String get locationHint => 'San Francisco, USA';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get signUp => '注册';

  @override
  String get dontHaveAccount => '还没有账户？';

  @override
  String get alreadyHaveAccount => '已有账户？';

  @override
  String get yourName => '您的姓名';

  @override
  String get yourLocation => '您的位置';

  @override
  String get displayName => '显示名称';

  @override
  String get editProfile => '编辑资料';

  @override
  String get profileUpdated => '资料已更新！';

  @override
  String get saveChanges => '保存更改';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageVietnamese => 'Tiếng Việt';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageKorean => '한국어';

  @override
  String get languageChinese => '中文';

  @override
  String languageChangedTo(Object language) {
    return '语言已更改为 $language';
  }

  @override
  String get notificationsEnabled => '通知已开启';

  @override
  String get notificationsDisabled => '通知已关闭';

  @override
  String get privacy => '隐私';

  @override
  String get privacySetting => '隐私设置';

  @override
  String privacySetTo(Object privacy) {
    return '隐私已设置为 $privacy';
  }

  @override
  String get changePassword => '更改密码';

  @override
  String get newPassword => '新密码';

  @override
  String get passwordUpdatedSuccessfully => '密码更新成功！';

  @override
  String get updatePassword => '更新密码';

  @override
  String get failedSignOut => '退出登录失败。请重试。';

  @override
  String get signOut => '退出登录';

  @override
  String get signOutConfirmation => '您确定要退出登录吗？';

  @override
  String get traveler => '旅行者';

  @override
  String get unknown => '未知';

  @override
  String get unknownDestination => '未知目的地';

  @override
  String get countries => '国家';

  @override
  String get trips => '旅行';

  @override
  String get locations => '地点';

  @override
  String get days => '天';

  @override
  String get tripHistory => '旅行历史';

  @override
  String get enabled => '已启用';

  @override
  String get disabled => '已禁用';

  @override
  String get public => '公开';

  @override
  String get friendsOnly => '仅好友';

  @override
  String get private => '私密';

  @override
  String get planned => '已计划';

  @override
  String get unknownTrip => '未知旅行';

  @override
  String get aiTripPlanner => 'AI 旅行规划器';

  @override
  String get planYourJourney => '规划您的旅程';

  @override
  String get aiCreatePerfectItinerary => '让 AI 创建完美行程';

  @override
  String get selectDate => '选择日期';

  @override
  String get pleaseSelectDates => '请选择开始和结束日期';

  @override
  String get endDateAfterStartDate => '结束日期必须晚于开始日期';

  @override
  String get tripGeneratedSuccessfully => '旅行生成成功！';

  @override
  String get generateTripFailed => '无法生成旅行。请重试。';

  @override
  String get aiGeneratedTrip => 'AI 生成的旅行';

  @override
  String get fallbackItineraryUsed => '已使用备用行程';

  @override
  String get budgetUsd => '预算（USD）';

  @override
  String get enterYourBudget => '输入您的预算';

  @override
  String get numberOfTravelers => '旅行人数';

  @override
  String get travelPreferences => '旅行偏好';

  @override
  String get additionalPreferences => '其他偏好';

  @override
  String get additionalPreferencesHint => '告诉我们更多您喜欢的内容（例如隐藏景点、本地市场、晚点出发……）';

  @override
  String get generating => '生成中……';

  @override
  String get generatingTrip => '正在生成旅行……';

  @override
  String get generateAiItinerary => '生成 AI 行程';

  @override
  String get soloTraveler => '独自旅行（1人）';

  @override
  String get coupleTravelers => '情侣（2人）';

  @override
  String get smallGroupTravelers => '小团体（3-5人）';

  @override
  String get largeGroupTravelers => '大团体（6人以上）';

  @override
  String get cultural => '文化';

  @override
  String get adventure => '冒险';

  @override
  String get relaxation => '放松';

  @override
  String get food => '美食';

  @override
  String get nature => '自然';

  @override
  String get shopping => '购物';

  @override
  String get tripDay => '旅行日';

  @override
  String get tripItinerary => '旅行行程';

  @override
  String get tripSavedSuccessfully => '旅行保存成功！';

  @override
  String get newActivity => '新活动';

  @override
  String get customActivity => '自定义活动';

  @override
  String get editDayTitle => '编辑日期标题';

  @override
  String get dayTitle => '日期标题';

  @override
  String get previewYourPlan => '预览您的计划';

  @override
  String get tripProgress => '旅行进度';

  @override
  String completedCount(Object completed, Object total) {
    return '已完成 $completed/$total';
  }

  @override
  String get confirmSavePlan => '确认并保存计划';

  @override
  String dayNumber(Object day) {
    return '第 $day 天';
  }

  @override
  String get addActivity => '添加活动';

  @override
  String get arrivalLocalDiscovery => '抵达与本地探索';

  @override
  String get cityLandmarkVisit => '城市地标参观';

  @override
  String get localFoodExperience => '本地美食体验';

  @override
  String get culturalSite => '文化景点';

  @override
  String get eveningWalk => '夜间散步';

  @override
  String get adventureExploration => '冒险与探索';

  @override
  String get morningExcursion => '上午短途游';

  @override
  String get lunchBreak => '午餐休息';

  @override
  String get outdoorActivity => '户外活动';

  @override
  String get dinnerRelaxation => '晚餐与放松';

  @override
  String get relaxedFinalDay => '轻松的最后一天';

  @override
  String get slowMorning => '悠闲早晨';

  @override
  String get souvenirShopping => '购买纪念品';

  @override
  String get finalPhotoSpot => '最后拍照点';

  @override
  String get exploringSaigon => '探索西贡';

  @override
  String get mockLandmarkDescription => '从著名的本地地标开始您的旅行。';

  @override
  String get mockFoodDescription => '在市中心附近品尝正宗本地美食。';

  @override
  String get mockCulturalDescription => '参观博物馆、寺庙或文化目的地。';

  @override
  String get mockEveningDescription => '在夜晚享受城市氛围。';

  @override
  String get mockExcursionDescription => '前往附近景点进行短途游。';

  @override
  String get mockLunchDescription => '在推荐的本地餐厅补充能量。';

  @override
  String get mockOutdoorDescription => '探索自然、市场或隐藏宝地。';

  @override
  String get mockDinnerDescription => '用轻松的晚餐结束一天。';

  @override
  String get mockSlowMorningDescription => '用咖啡或早餐悠闲开始一天。';

  @override
  String get mockSouvenirDescription => '购买纪念品或参观本地市场。';

  @override
  String get mockPhotoDescription => '离开前记录最后的回忆。';

  @override
  String get scanDemoResult => '在价格检查 API 可用前显示演示结果。';

  @override
  String get estimatedLocalPrice => '预估本地价格';

  @override
  String get detectedPrice => '检测到的价格';

  @override
  String get advice => '建议';

  @override
  String get cameraPreview => '相机预览';

  @override
  String get cameraPreviewHint => '对准物品、收据或菜单价格。';

  @override
  String get checkingPrice => '正在检查价格……';

  @override
  String get scanItemMenu => '扫描物品或菜单';

  @override
  String get takePhoto => '拍照';

  @override
  String get upload => '上传';

  @override
  String get priceCheckInfo => '当后端扫描器连接后，价格检查会将检测价格与本地价格范围比较。';

  @override
  String get scannedItem => '已扫描物品';

  @override
  String get pending => '待处理';

  @override
  String get unknownWarning => '未知';

  @override
  String get scanAdviceDefault => '付款前请参考本地价格核对。';

  @override
  String get menuItem => '菜单项';

  @override
  String get apiPending => 'API 待连接';

  @override
  String get demo => '演示';

  @override
  String get scanBackendPending => '扫描器后端尚未连接。请将此布局作为未来结果界面。';

  @override
  String get usingOfflinePlaces => '正在使用离线地点。';

  @override
  String zoomPercent(Object percent) {
    return '缩放：$percent%';
  }

  @override
  String get centeringLocation => '正在居中到您的位置……';

  @override
  String get searchPlaces => '搜索地点……';

  @override
  String get mapExplorer => '地图探索器';

  @override
  String get myLocation => '我的位置';

  @override
  String get search => '搜索';

  @override
  String get zoomIn => '放大';

  @override
  String get zoomOut => '缩小';

  @override
  String get nearbyPlaces => '附近地点';

  @override
  String foundCount(Object count) {
    return '找到 $count 个';
  }

  @override
  String get noPlacesFound => '未找到地点';

  @override
  String get place => '地点';

  @override
  String get unknownPlace => '未知地点';

  @override
  String get nearby => '附近';

  @override
  String get coffeeShop => '咖啡店';

  @override
  String get vietnameseRestaurant => '越南餐厅';

  @override
  String get market => '市场';

  @override
  String get aiTravelAssistant => 'AI 旅行助手';

  @override
  String get alwaysHereToHelp => '随时为您提供帮助';

  @override
  String get askMeAnything => '问我任何问题……';

  @override
  String get suggestedQuestions => '建议问题';

  @override
  String get assistantGreeting =>
      '您好！我是您的 AI 旅行助手。我可以帮助您获取本地推荐、翻译、文化提示和旅行问题解答。今天需要什么帮助？';

  @override
  String get assistantFallback => '我可以帮忙。您能提供更多细节吗？';

  @override
  String get assistantConnectionError => '抱歉，无法连接到 AI 助手。';

  @override
  String get suggestionBestTimeHaLong => '什么时候最适合游览 Ha Long Bay？';

  @override
  String get suggestionVietnameseRestaurants => '推荐正宗越南餐厅';

  @override
  String get suggestionHanoiToSapa => '如何从 Hanoi 到 Sapa？';

  @override
  String get suggestionLocalCustoms => '我应该了解哪些本地习俗？';

  @override
  String get completeYourPurchase => '完成购买';

  @override
  String get paymentInformation => '付款信息';

  @override
  String get choosePlanUnlock => '选择套餐并解锁个性化旅行体验';

  @override
  String get mostPopular => '最受欢迎';

  @override
  String get perTrip => ' /次旅行';

  @override
  String get selected => '已选择';

  @override
  String get selectPlan => '选择套餐';

  @override
  String continueToPayment(Object price) {
    return '继续付款 - $price';
  }

  @override
  String get purchaseSuccessful => '购买成功！';

  @override
  String get planActiveEnjoyTrip => '您的套餐已激活。祝您旅途愉快！';

  @override
  String get openItinerary => '打开行程';

  @override
  String get goToHome => '前往首页';

  @override
  String get required => '必填';

  @override
  String get cardNumber => '卡号';

  @override
  String get cardholderName => '持卡人姓名';

  @override
  String get cardholderNameHint => 'John Doe';

  @override
  String get expiryDate => '到期日期';

  @override
  String get expiryDateHint => 'MM/YY';

  @override
  String get cvv => 'CVV';

  @override
  String get demoPaymentWarning => '这是演示付款。请勿输入真实银行卡信息。';

  @override
  String get processing => '处理中……';

  @override
  String completePurchase(Object price) {
    return '完成购买 - $price';
  }

  @override
  String get basicPlan => '基础套餐';

  @override
  String get premiumPlan => '高级套餐';

  @override
  String get proPlan => '专业套餐';

  @override
  String get sevenDays => '7天';

  @override
  String get fourteenDays => '14天';

  @override
  String get thirtyDays => '30天';

  @override
  String get unlimitedPlanning => '无限规划';

  @override
  String get fullMapAccess => '完整地图访问';

  @override
  String get smartAiSuggestions => '智能 AI 建议';

  @override
  String get premiumFeatures => '高级功能';

  @override
  String get prioritySupport => '优先支持';

  @override
  String get plan => '套餐';

  @override
  String get tripAlbums => '旅行相册';

  @override
  String get newAlbum => '新相册';

  @override
  String get createNewAlbum => '创建新相册';

  @override
  String get albumName => '相册名称';

  @override
  String get albumNameHint => '例如：Hanoi Adventures';

  @override
  String get description => '描述';

  @override
  String get publicAlbum => '公开相册';

  @override
  String get albumCreated => '相册已创建！';

  @override
  String get noAlbumsYet => '还没有相册';

  @override
  String get createFirstAlbum => '创建您的第一个相册';

  @override
  String get createAlbum => '创建相册';

  @override
  String get untitledAlbum => '未命名相册';

  @override
  String get tripCamera => '旅行相机';

  @override
  String get savePhoto => '保存照片';

  @override
  String get caption => '说明文字';

  @override
  String get captionHint => '写点关于这张照片的内容……';

  @override
  String get photoLocationHint => '例如：Da Lat, Vietnam';

  @override
  String get cameraSource => '相机';

  @override
  String get gallerySource => '图库';

  @override
  String get mustLoginUploadPhotos => '上传照片前必须先登录。';

  @override
  String get photoReadyUploadUnavailable => '照片已准备好。后端上传暂不可用。';

  @override
  String get photoSaveFailed => '无法保存照片。请重试。';

  @override
  String photoSaveFailedWithMessage(Object message) {
    return '无法保存照片：$message';
  }

  @override
  String tripCameraPermissionDenied(Object source) {
    return '权限被拒绝。请允许访问 $source 后重试。';
  }

  @override
  String couldNotOpenSource(Object source, Object message) {
    return '无法打开 $source。$message';
  }

  @override
  String get couldNotSelectPhoto => '无法选择照片。请重试。';

  @override
  String get viewAlbums => '查看相册';

  @override
  String get readyCaptureMoment => '准备好记录这一刻了吗？';

  @override
  String get tapOpenCamera => '点击下方打开相机';

  @override
  String get openCamera => '打开相机';

  @override
  String get uploadFromGallery => '从图库上传';

  @override
  String get photoUploadBackendInfo => '当后端添加相册存储后将启用照片上传';

  @override
  String get emergencySupport => '紧急支持';

  @override
  String playingPhrase(Object phrase) {
    return '正在播放：$phrase';
  }

  @override
  String get quickTalk => '快速用语';

  @override
  String get emergencyContacts => '紧急联系人';

  @override
  String get emergency => '紧急';

  @override
  String get police => '警察';

  @override
  String get fire => '消防';

  @override
  String get ambulance => '救护车';

  @override
  String get general => '通用';

  @override
  String get medical => '医疗';

  @override
  String get incident => '事件';

  @override
  String get security => '安全';

  @override
  String get navigation => '导航';

  @override
  String get communication => '沟通';

  @override
  String get call => '呼叫';

  @override
  String get quickTips => '快速提示';

  @override
  String get tipHotelAddress => '请始终携带越南语酒店地址。';

  @override
  String get tipPhoneBattery => '出门前检查手机电量。';

  @override
  String get tipSaveEmergencyContacts => '在手机中保存紧急联系人。';

  @override
  String get phraseHelpMe => '请帮帮我！';

  @override
  String get phraseHospital => '最近的医院在哪里？';

  @override
  String get phraseLostWalletPassport => '我的钱包/护照丢了。';

  @override
  String get phraseCallPolice => '我需要报警。';

  @override
  String get phraseLost => '我迷路了。';

  @override
  String get phraseSpeakEnglish => '您会说英语吗？';

  @override
  String get aboutSMate => '关于 S-Mate';

  @override
  String get aboutSMateDescription => 'S-Mate 是您的一站式旅行伙伴，旨在让每段旅程顺畅而难忘。';

  @override
  String get aiTripPlanning => 'AI 旅行规划';

  @override
  String get aiTripPlanningDescription => '由 AI 生成个性化行程。只需输入目的地、日期和偏好。';

  @override
  String get interactiveMaps => '互动地图';

  @override
  String get interactiveMapsDescription => '通过实时地图、附近地点和导航支持探索目的地。';

  @override
  String get assistant247 => '24/7 AI 助手';

  @override
  String get assistant247Description => '即时获得有关本地习俗、翻译、餐厅和旅行贴士的答案。';

  @override
  String get tripAlbumsFeatureDescription => '用照片和相册记录并整理您的旅行回忆。';

  @override
  String get emergencySupportDescription => '在任何情况下访问紧急联系人、快速用语和安全提示。';

  @override
  String get smartTips => '智能提示';

  @override
  String get smartTipsDescription => '根据您的计划和目的地获得个性化旅行建议。';

  @override
  String get getStarted => '开始';

  @override
  String get welcomeToSMate => '欢迎使用 S-Mate';

  @override
  String get introSubtitle => '帮助您发现、规划并体验难忘旅程的智能伙伴';

  @override
  String get smartItineraries => '智能行程';

  @override
  String get exploreDestinations => '探索目的地';

  @override
  String get instantAnswers => '即时回答';

  @override
  String get saveMemories => '保存回忆';

  @override
  String get localLaws => '本地法律';

  @override
  String get staySafe => '保持安全';

  @override
  String get personalized => '个性化';

  @override
  String get learnMore => '了解更多';

  @override
  String get copyright => '© 2026 S-Mate。保留所有权利。';

  @override
  String validationRequiredField(String fieldName) {
    return '请输入$fieldName';
  }

  @override
  String get validationEmailRequired => '请输入您的电子邮件';

  @override
  String get validationEmailInvalid => '请输入有效的电子邮件地址';

  @override
  String get validationPasswordRequired => '请输入您的密码';

  @override
  String validationPasswordMinLength(int min) {
    return '密码至少需要 $min 个字符';
  }

  @override
  String get validationPasswordTooLong => '密码太长';

  @override
  String get validationPasswordComplexity => '密码必须包含大写字母、数字和特殊字符';

  @override
  String get validationConfirmPasswordRequired => '请确认您的密码';

  @override
  String get validationPasswordsDoNotMatch => '密码不匹配';

  @override
  String validationNumberInvalid(String fieldName) {
    return '$fieldName必须是有效数字';
  }

  @override
  String validationNumberNegative(String fieldName) {
    return '$fieldName不能为负数';
  }

  @override
  String validationMinLength(String fieldName, int min) {
    return '$fieldName至少需要 $min 个字符';
  }

  @override
  String validationMaxLength(String fieldName, int max) {
    return '$fieldName必须少于 $max 个字符';
  }

  @override
  String get validationPhoneRequired => '请输入电话号码';

  @override
  String get validationPhoneInvalid => '电话号码无效';

  @override
  String get validationBudgetTooLow => '预算太低';

  @override
  String get validationUsernameRequired => '请输入用户名';

  @override
  String validationUsernameMinLength(int min) {
    return '用户名至少需要 $min 个字符';
  }

  @override
  String get validationUsernameTooLong => '用户名太长';

  @override
  String get validationUsernameInvalid => '用户名只能包含字母、数字和下划线';

  @override
  String validationDescriptionMaxLength(int maxLength) {
    return '描述必须少于 $maxLength 个字符';
  }

  @override
  String get continueTrip => '继续旅行';
}
