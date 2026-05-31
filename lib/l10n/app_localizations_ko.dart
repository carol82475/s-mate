// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get vietnam => '베트남';

  @override
  String get appName => 'S-Mate';

  @override
  String get login => '로그인';

  @override
  String get register => '회원가입';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get password => '비밀번호';

  @override
  String get home => '홈';

  @override
  String get profile => '프로필';

  @override
  String get tripPlanner => '여행 플래너';

  @override
  String get generateItinerary => '일정 생성';

  @override
  String get destination => '목적지';

  @override
  String get budget => '예산';

  @override
  String get peopleCount => '인원수';

  @override
  String get startDate => '시작일';

  @override
  String get endDate => '종료일';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get logout => '로그아웃';

  @override
  String get notifications => '알림';

  @override
  String get settings => '설정';

  @override
  String get language => '언어';

  @override
  String get loading => '로딩 중';

  @override
  String get error => '오류';

  @override
  String get success => '성공';

  @override
  String get retry => '다시 시도';

  @override
  String get myTrip => '내 여행';

  @override
  String get scan => '스캔';

  @override
  String get map => '지도';

  @override
  String get aiChat => 'AI 채팅';

  @override
  String get all => '전체';

  @override
  String get upcoming => '예정';

  @override
  String get inProgress => '진행 중';

  @override
  String get completed => '완료';

  @override
  String get cancelled => '취소됨';

  @override
  String get couldNotLoadTrips => '여행을 불러올 수 없습니다';

  @override
  String get couldNotLoadTripsMessage => '지금은 여행을 불러올 수 없습니다. 다시 시도해 주세요.';

  @override
  String get tryAgain => '다시 시도';

  @override
  String get noTripsYet => '아직 여행이 없습니다';

  @override
  String get noTripsYetMessage => '첫 AI 일정을 만들면 여기에 표시됩니다.';

  @override
  String get noTripsFoundForFilter => '이 필터에 해당하는 여행이 없습니다';

  @override
  String get createNewTrip => '새 여행 만들기';

  @override
  String get destinationPending => '목적지 대기 중';

  @override
  String defaultTripName(Object destination) {
    return '$destination 여행';
  }

  @override
  String budgetValue(Object value) {
    return '예산: $value';
  }

  @override
  String get close => '닫기';

  @override
  String get back => '뒤로';

  @override
  String get create => '만들기';

  @override
  String get update => '업데이트';

  @override
  String get edit => '수정';

  @override
  String get done => '완료';

  @override
  String get customize => '맞춤 설정';

  @override
  String get openMap => '지도 열기';

  @override
  String get createTrip => '여행 만들기';

  @override
  String get welcomeBackTraveler => '다시 오신 것을 환영합니다, 여행자님!';

  @override
  String get planNextAdventure => '다음 모험을 계획하세요';

  @override
  String get itineraryReminder => '일정 알림';

  @override
  String get nextActivitySoon => '다음 활동이 곧 시작됩니다.';

  @override
  String get mapUpdate => '지도 업데이트';

  @override
  String get nearbyRecommendationsReady => '주변 추천을 탐색할 준비가 되었습니다.';

  @override
  String get albumReminder => '앨범 알림';

  @override
  String get addTodaysPhotos => '오늘의 사진을 여행 앨범에 추가하세요.';

  @override
  String timeAgoHours(Object hours) {
    return '$hours시간 전';
  }

  @override
  String timeAgoDays(Object days) {
    return '$days일 전';
  }

  @override
  String get planYourFirstTrip => '첫 여행 계획하기';

  @override
  String get chooseDestination => '목적지를 선택하세요';

  @override
  String get newStatus => '새로움';

  @override
  String get action => '동작';

  @override
  String get generateTrip => '여행 생성';

  @override
  String get generateTripDescription => '날짜와 예산으로 새 AI 일정을 만드세요.';

  @override
  String get currentTrip => '현재 여행';

  @override
  String get currentTrips => '현재 여행';

  @override
  String get viewMyTrips => '내 여행 보기';

  @override
  String get viewItinerary => '일정 보기';

  @override
  String get popularDestinations => '인기 목적지';

  @override
  String get welcomeBack => '다시 오신 것을 환영합니다';

  @override
  String get createAccount => '계정 만들기';

  @override
  String get signInContinueJourney => '여정을 계속하려면 로그인하세요';

  @override
  String get signUpStartAdventure => '다음 모험 계획을 시작하려면 가입하세요';

  @override
  String get loginSuccessful => '로그인 성공!';

  @override
  String get accountCreatedSuccessfully => '계정이 성공적으로 생성되었습니다!';

  @override
  String get resetPassword => '비밀번호 재설정';

  @override
  String get resetPasswordInstructions => '이메일을 입력하면 재설정 링크를 보내드립니다.';

  @override
  String get sendResetLink => '재설정 링크 보내기';

  @override
  String get passwordResetOtpSent => '비밀번호 재설정 OTP가 전송되었습니다!';

  @override
  String get fullName => '전체 이름';

  @override
  String get fullNameHint => 'John Doe';

  @override
  String get location => '위치';

  @override
  String get locationHint => 'San Francisco, USA';

  @override
  String get forgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get signUp => '가입';

  @override
  String get dontHaveAccount => '계정이 없으신가요? ';

  @override
  String get alreadyHaveAccount => '이미 계정이 있으신가요? ';

  @override
  String get yourName => '이름';

  @override
  String get yourLocation => '위치';

  @override
  String get displayName => '표시 이름';

  @override
  String get editProfile => '프로필 수정';

  @override
  String get profileUpdated => '프로필이 업데이트되었습니다!';

  @override
  String get saveChanges => '변경 사항 저장';

  @override
  String get selectLanguage => '언어 선택';

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
    return '언어가 $language(으)로 변경되었습니다';
  }

  @override
  String get notificationsEnabled => '알림이 켜졌습니다';

  @override
  String get notificationsDisabled => '알림이 꺼졌습니다';

  @override
  String get privacy => '개인정보';

  @override
  String get privacySetting => '개인정보 설정';

  @override
  String privacySetTo(Object privacy) {
    return '개인정보가 $privacy(으)로 설정되었습니다';
  }

  @override
  String get changePassword => '비밀번호 변경';

  @override
  String get newPassword => '새 비밀번호';

  @override
  String get passwordUpdatedSuccessfully => '비밀번호가 성공적으로 업데이트되었습니다!';

  @override
  String get updatePassword => '비밀번호 업데이트';

  @override
  String get failedSignOut => '로그아웃하지 못했습니다. 다시 시도해 주세요.';

  @override
  String get signOut => '로그아웃';

  @override
  String get signOutConfirmation => '정말 로그아웃하시겠습니까?';

  @override
  String get traveler => '여행자';

  @override
  String get unknown => '알 수 없음';

  @override
  String get unknownDestination => '알 수 없는 목적지';

  @override
  String get countries => '국가';

  @override
  String get trips => '여행';

  @override
  String get locations => '장소';

  @override
  String get days => '일';

  @override
  String get tripHistory => '여행 기록';

  @override
  String get enabled => '켜짐';

  @override
  String get disabled => '꺼짐';

  @override
  String get public => '공개';

  @override
  String get friendsOnly => '친구만';

  @override
  String get private => '비공개';

  @override
  String get planned => '계획됨';

  @override
  String get unknownTrip => '알 수 없는 여행';

  @override
  String get aiTripPlanner => 'AI 여행 플래너';

  @override
  String get planYourJourney => '여정을 계획하세요';

  @override
  String get aiCreatePerfectItinerary => 'AI가 완벽한 일정을 만들게 하세요';

  @override
  String get selectDate => '날짜 선택';

  @override
  String get pleaseSelectDates => '시작일과 종료일을 선택하세요';

  @override
  String get endDateAfterStartDate => '종료일은 시작일 이후여야 합니다';

  @override
  String get tripGeneratedSuccessfully => '여행이 성공적으로 생성되었습니다!';

  @override
  String get generateTripFailed => '여행을 생성할 수 없습니다. 다시 시도해 주세요.';

  @override
  String get aiGeneratedTrip => 'AI 생성 여행';

  @override
  String get fallbackItineraryUsed => '대체 일정이 사용되었습니다';

  @override
  String get budgetUsd => '예산(USD)';

  @override
  String get enterYourBudget => '예산을 입력하세요';

  @override
  String get numberOfTravelers => '여행자 수';

  @override
  String get travelPreferences => '여행 선호도';

  @override
  String get additionalPreferences => '추가 선호도';

  @override
  String get additionalPreferencesHint =>
      '좋아하는 것을 더 알려주세요(예: 숨은 명소, 현지 시장, 늦은 시작...)';

  @override
  String get generating => '생성 중...';

  @override
  String get generatingTrip => '여행 생성 중...';

  @override
  String get generateAiItinerary => 'AI 일정 생성';

  @override
  String get soloTraveler => '혼자(1명)';

  @override
  String get coupleTravelers => '커플(2명)';

  @override
  String get smallGroupTravelers => '소규모 그룹(3-5명)';

  @override
  String get largeGroupTravelers => '대규모 그룹(6명 이상)';

  @override
  String get cultural => '문화';

  @override
  String get adventure => '모험';

  @override
  String get relaxation => '휴식';

  @override
  String get food => '음식';

  @override
  String get nature => '자연';

  @override
  String get shopping => '쇼핑';

  @override
  String get tripDay => '여행일';

  @override
  String get tripItinerary => '여행 일정';

  @override
  String get tripSavedSuccessfully => '여행이 성공적으로 저장되었습니다!';

  @override
  String get newActivity => '새 활동';

  @override
  String get customActivity => '사용자 지정 활동';

  @override
  String get editDayTitle => '일자 제목 수정';

  @override
  String get dayTitle => '일자 제목';

  @override
  String get previewYourPlan => '계획 미리보기';

  @override
  String get tripProgress => '여행 진행률';

  @override
  String completedCount(Object completed, Object total) {
    return '$completed/$total 완료';
  }

  @override
  String get confirmSavePlan => '계획 확인 및 저장';

  @override
  String dayNumber(Object day) {
    return '$day일차';
  }

  @override
  String get addActivity => '활동 추가';

  @override
  String get arrivalLocalDiscovery => '도착 및 현지 탐방';

  @override
  String get cityLandmarkVisit => '도시 명소 방문';

  @override
  String get localFoodExperience => '현지 음식 체험';

  @override
  String get culturalSite => '문화 명소';

  @override
  String get eveningWalk => '저녁 산책';

  @override
  String get adventureExploration => '모험과 탐험';

  @override
  String get morningExcursion => '아침 소풍';

  @override
  String get lunchBreak => '점심 휴식';

  @override
  String get outdoorActivity => '야외 활동';

  @override
  String get dinnerRelaxation => '저녁 식사와 휴식';

  @override
  String get relaxedFinalDay => '여유로운 마지막 날';

  @override
  String get slowMorning => '느긋한 아침';

  @override
  String get souvenirShopping => '기념품 쇼핑';

  @override
  String get finalPhotoSpot => '마지막 사진 명소';

  @override
  String get exploringSaigon => '사이공 탐험';

  @override
  String get mockLandmarkDescription => '유명한 현지 명소에서 여행을 시작하세요.';

  @override
  String get mockFoodDescription => '도심 근처에서 정통 현지 음식을 맛보세요.';

  @override
  String get mockCulturalDescription => '박물관, 사원 또는 문화 명소를 방문하세요.';

  @override
  String get mockEveningDescription => '저녁의 도시 분위기를 즐기세요.';

  @override
  String get mockExcursionDescription => '가까운 명소로 짧은 여행을 떠나세요.';

  @override
  String get mockLunchDescription => '추천 현지 식당에서 에너지를 충전하세요.';

  @override
  String get mockOutdoorDescription => '자연, 시장 또는 숨은 명소를 탐험하세요.';

  @override
  String get mockDinnerDescription => '편안한 저녁 식사로 하루를 마무리하세요.';

  @override
  String get mockSlowMorningDescription => '커피나 아침 식사와 함께 느긋하게 시작하세요.';

  @override
  String get mockSouvenirDescription => '기념품을 사거나 현지 시장을 방문하세요.';

  @override
  String get mockPhotoDescription => '떠나기 전 마지막 추억을 남기세요.';

  @override
  String get scanDemoResult => '가격 확인 API가 준비될 때까지 데모 결과가 표시됩니다.';

  @override
  String get estimatedLocalPrice => '예상 현지 가격';

  @override
  String get detectedPrice => '감지된 가격';

  @override
  String get advice => '조언';

  @override
  String get cameraPreview => '카메라 미리보기';

  @override
  String get cameraPreviewHint => '물건, 영수증 또는 메뉴 가격을 향해 주세요.';

  @override
  String get checkingPrice => '가격 확인 중...';

  @override
  String get scanItemMenu => '물건 또는 메뉴 스캔';

  @override
  String get takePhoto => '사진 찍기';

  @override
  String get upload => '업로드';

  @override
  String get priceCheckInfo => '백엔드 스캐너가 연결되면 가격 확인은 감지된 가격을 현지 범위와 비교합니다.';

  @override
  String get scannedItem => '스캔한 항목';

  @override
  String get pending => '대기 중';

  @override
  String get unknownWarning => '알 수 없음';

  @override
  String get scanAdviceDefault => '결제 전 현지 기준 가격과 비교해 보세요.';

  @override
  String get menuItem => '메뉴 항목';

  @override
  String get apiPending => 'API 대기 중';

  @override
  String get demo => '데모';

  @override
  String get scanBackendPending =>
      '스캐너 백엔드가 아직 연결되지 않았습니다. 이 화면은 향후 결과 화면으로 사용됩니다.';

  @override
  String get usingOfflinePlaces => '오프라인 장소 사용 중.';

  @override
  String zoomPercent(Object percent) {
    return '확대/축소: $percent%';
  }

  @override
  String get centeringLocation => '현재 위치로 이동 중...';

  @override
  String get searchPlaces => '장소 검색...';

  @override
  String get mapExplorer => '지도 탐색기';

  @override
  String get myLocation => '내 위치';

  @override
  String get search => '검색';

  @override
  String get zoomIn => '확대';

  @override
  String get zoomOut => '축소';

  @override
  String get nearbyPlaces => '주변 장소';

  @override
  String foundCount(Object count) {
    return '$count개 발견';
  }

  @override
  String get noPlacesFound => '장소를 찾을 수 없습니다';

  @override
  String get place => '장소';

  @override
  String get unknownPlace => '알 수 없는 장소';

  @override
  String get nearby => '주변';

  @override
  String get coffeeShop => '커피숍';

  @override
  String get vietnameseRestaurant => '베트남 음식점';

  @override
  String get market => '시장';

  @override
  String get aiTravelAssistant => 'AI 여행 도우미';

  @override
  String get alwaysHereToHelp => '항상 도와드릴게요';

  @override
  String get askMeAnything => '무엇이든 물어보세요...';

  @override
  String get suggestedQuestions => '추천 질문';

  @override
  String get assistantGreeting =>
      '안녕하세요! 저는 AI 여행 도우미입니다. 현지 추천, 번역, 문화 팁, 여행 질문을 도와드릴 수 있어요. 오늘 무엇을 도와드릴까요?';

  @override
  String get assistantFallback => '도와드릴 수 있습니다. 자세한 내용을 알려주시겠어요?';

  @override
  String get assistantConnectionError => '죄송합니다. AI 도우미에 연결할 수 없습니다.';

  @override
  String get suggestionBestTimeHaLong => 'Ha Long Bay를 방문하기 가장 좋은 시기는 언제인가요?';

  @override
  String get suggestionVietnameseRestaurants => '정통 베트남 음식점을 추천해 주세요';

  @override
  String get suggestionHanoiToSapa => 'Hanoi에서 Sapa까지 어떻게 가나요?';

  @override
  String get suggestionLocalCustoms => '알아야 할 현지 관습은 무엇인가요?';

  @override
  String get completeYourPurchase => '구매 완료';

  @override
  String get paymentInformation => '결제 정보';

  @override
  String get choosePlanUnlock => '플랜을 선택하고 맞춤형 여행 경험을 잠금 해제하세요';

  @override
  String get mostPopular => '가장 인기';

  @override
  String get perTrip => ' /여행';

  @override
  String get selected => '선택됨';

  @override
  String get selectPlan => '플랜 선택';

  @override
  String continueToPayment(Object price) {
    return '결제로 계속 - $price';
  }

  @override
  String get purchaseSuccessful => '구매 성공!';

  @override
  String get planActiveEnjoyTrip => '플랜이 활성화되었습니다. 즐거운 여행 되세요!';

  @override
  String get openItinerary => '일정 열기';

  @override
  String get goToHome => '홈으로 이동';

  @override
  String get required => '필수';

  @override
  String get cardNumber => '카드 번호';

  @override
  String get cardholderName => '카드 소유자 이름';

  @override
  String get cardholderNameHint => 'John Doe';

  @override
  String get expiryDate => '만료일';

  @override
  String get expiryDateHint => 'MM/YY';

  @override
  String get cvv => 'CVV';

  @override
  String get demoPaymentWarning => '데모 결제입니다. 실제 카드 정보를 입력하지 마세요.';

  @override
  String get processing => '처리 중...';

  @override
  String completePurchase(Object price) {
    return '구매 완료 - $price';
  }

  @override
  String get basicPlan => '기본 플랜';

  @override
  String get premiumPlan => '프리미엄 플랜';

  @override
  String get proPlan => '프로 플랜';

  @override
  String get sevenDays => '7일';

  @override
  String get fourteenDays => '14일';

  @override
  String get thirtyDays => '30일';

  @override
  String get unlimitedPlanning => '무제한 계획';

  @override
  String get fullMapAccess => '전체 지도 접근';

  @override
  String get smartAiSuggestions => '스마트 AI 제안';

  @override
  String get premiumFeatures => '프리미엄 기능';

  @override
  String get prioritySupport => '우선 지원';

  @override
  String get plan => '플랜';

  @override
  String get tripAlbums => '여행 앨범';

  @override
  String get newAlbum => '새 앨범';

  @override
  String get createNewAlbum => '새 앨범 만들기';

  @override
  String get albumName => '앨범 이름';

  @override
  String get albumNameHint => '예: Hanoi Adventures';

  @override
  String get description => '설명';

  @override
  String get publicAlbum => '공개 앨범';

  @override
  String get albumCreated => '앨범이 생성되었습니다!';

  @override
  String get noAlbumsYet => '아직 앨범이 없습니다';

  @override
  String get createFirstAlbum => '첫 앨범 만들기';

  @override
  String get createAlbum => '앨범 만들기';

  @override
  String get untitledAlbum => '제목 없는 앨범';

  @override
  String get tripCamera => '여행 카메라';

  @override
  String get savePhoto => '사진 저장';

  @override
  String get caption => '캡션';

  @override
  String get captionHint => '이 사진에 대해 적어보세요...';

  @override
  String get photoLocationHint => '예: Da Lat, Vietnam';

  @override
  String get cameraSource => '카메라';

  @override
  String get gallerySource => '갤러리';

  @override
  String get mustLoginUploadPhotos => '사진을 업로드하려면 먼저 로그인해야 합니다.';

  @override
  String get photoReadyUploadUnavailable =>
      '사진이 준비되었습니다. 백엔드 업로드는 아직 사용할 수 없습니다.';

  @override
  String get photoSaveFailed => '사진을 저장할 수 없습니다. 다시 시도해 주세요.';

  @override
  String photoSaveFailedWithMessage(Object message) {
    return '사진을 저장할 수 없습니다: $message';
  }

  @override
  String tripCameraPermissionDenied(Object source) {
    return '권한이 거부되었습니다. $source 접근을 허용하고 다시 시도하세요.';
  }

  @override
  String couldNotOpenSource(Object source, Object message) {
    return '$source을(를) 열 수 없습니다. $message';
  }

  @override
  String get couldNotSelectPhoto => '사진을 선택할 수 없습니다. 다시 시도해 주세요.';

  @override
  String get viewAlbums => '앨범 보기';

  @override
  String get readyCaptureMoment => '순간을 담을 준비가 되셨나요?';

  @override
  String get tapOpenCamera => '아래를 눌러 카메라를 여세요';

  @override
  String get openCamera => '카메라 열기';

  @override
  String get uploadFromGallery => '갤러리에서 업로드';

  @override
  String get photoUploadBackendInfo => '백엔드가 앨범 저장소를 추가하면 사진 업로드가 활성화됩니다';

  @override
  String get emergencySupport => '긴급 지원';

  @override
  String playingPhrase(Object phrase) {
    return '재생 중: $phrase';
  }

  @override
  String get quickTalk => '빠른 회화';

  @override
  String get emergencyContacts => '긴급 연락처';

  @override
  String get emergency => '긴급';

  @override
  String get police => '경찰';

  @override
  String get fire => '소방';

  @override
  String get ambulance => '구급차';

  @override
  String get general => '일반';

  @override
  String get medical => '의료';

  @override
  String get incident => '사건';

  @override
  String get security => '보안';

  @override
  String get navigation => '길찾기';

  @override
  String get communication => '의사소통';

  @override
  String get call => '전화';

  @override
  String get quickTips => '빠른 팁';

  @override
  String get tipHotelAddress => '호텔 주소를 베트남어로 항상 지참하세요.';

  @override
  String get tipPhoneBattery => '외출 전 휴대폰 배터리를 확인하세요.';

  @override
  String get tipSaveEmergencyContacts => '긴급 연락처를 휴대폰에 저장하세요.';

  @override
  String get phraseHelpMe => '도와주세요!';

  @override
  String get phraseHospital => '가장 가까운 병원이 어디인가요?';

  @override
  String get phraseLostWalletPassport => '지갑/여권을 잃어버렸습니다.';

  @override
  String get phraseCallPolice => '경찰에 전화해야 합니다.';

  @override
  String get phraseLost => '길을 잃었습니다.';

  @override
  String get phraseSpeakEnglish => '영어를 하시나요?';

  @override
  String get aboutSMate => 'S-Mate 소개';

  @override
  String get aboutSMateDescription =>
      'S-Mate는 모든 여정을 매끄럽고 기억에 남게 만드는 올인원 여행 동반자입니다.';

  @override
  String get aiTripPlanning => 'AI 여행 계획';

  @override
  String get aiTripPlanningDescription =>
      'AI가 맞춤 일정을 생성합니다. 목적지, 날짜, 선호도만 입력하세요.';

  @override
  String get interactiveMaps => '인터랙티브 지도';

  @override
  String get interactiveMapsDescription =>
      '실시간 지도, 주변 장소, 내비게이션 지원으로 목적지를 탐색하세요.';

  @override
  String get assistant247 => '24/7 AI 도우미';

  @override
  String get assistant247Description => '현지 관습, 번역, 식당, 여행 팁에 대한 답변을 즉시 받아보세요.';

  @override
  String get tripAlbumsFeatureDescription => '사진과 앨범으로 여행 추억을 기록하고 정리하세요.';

  @override
  String get emergencySupportDescription =>
      '어떤 상황에서도 긴급 연락처, 빠른 문구, 안전 팁을 이용하세요.';

  @override
  String get smartTips => '스마트 팁';

  @override
  String get smartTipsDescription => '계획과 목적지에 맞춘 여행 제안을 받아보세요.';

  @override
  String get getStarted => '시작하기';

  @override
  String get welcomeToSMate => 'S-Mate에 오신 것을 환영합니다';

  @override
  String get introSubtitle => '잊을 수 없는 여정을 발견하고 계획하고 경험하는 지능형 동반자';

  @override
  String get smartItineraries => '스마트 일정';

  @override
  String get exploreDestinations => '목적지 탐색';

  @override
  String get instantAnswers => '즉시 답변';

  @override
  String get saveMemories => '추억 저장';

  @override
  String get localLaws => '현지 법규';

  @override
  String get staySafe => '안전하게';

  @override
  String get personalized => '맞춤형';

  @override
  String get learnMore => '더 알아보기';

  @override
  String get copyright => '© 2026 S-Mate. 모든 권리 보유.';

  @override
  String validationRequiredField(String fieldName) {
    return '$fieldName을(를) 입력하세요';
  }

  @override
  String get validationEmailRequired => '이메일을 입력하세요';

  @override
  String get validationEmailInvalid => '유효한 이메일 주소를 입력하세요';

  @override
  String get validationPasswordRequired => '비밀번호를 입력하세요';

  @override
  String validationPasswordMinLength(int min) {
    return '비밀번호는 최소 $min자여야 합니다';
  }

  @override
  String get validationPasswordTooLong => '비밀번호가 너무 깁니다';

  @override
  String get validationPasswordComplexity => '비밀번호에는 대문자, 숫자, 특수 문자가 포함되어야 합니다';

  @override
  String get validationConfirmPasswordRequired => '비밀번호를 확인하세요';

  @override
  String get validationPasswordsDoNotMatch => '비밀번호가 일치하지 않습니다';

  @override
  String validationNumberInvalid(String fieldName) {
    return '$fieldName은(는) 유효한 숫자여야 합니다';
  }

  @override
  String validationNumberNegative(String fieldName) {
    return '$fieldName은(는) 음수일 수 없습니다';
  }

  @override
  String validationMinLength(String fieldName, int min) {
    return '$fieldName은(는) 최소 $min자여야 합니다';
  }

  @override
  String validationMaxLength(String fieldName, int max) {
    return '$fieldName은(는) $max자보다 짧아야 합니다';
  }

  @override
  String get validationPhoneRequired => '전화번호를 입력하세요';

  @override
  String get validationPhoneInvalid => '잘못된 전화번호입니다';

  @override
  String get validationBudgetTooLow => '예산이 너무 낮습니다';

  @override
  String get validationUsernameRequired => '사용자 이름을 입력하세요';

  @override
  String validationUsernameMinLength(int min) {
    return '사용자 이름은 최소 $min자여야 합니다';
  }

  @override
  String get validationUsernameTooLong => '사용자 이름이 너무 깁니다';

  @override
  String get validationUsernameInvalid => '사용자 이름은 문자, 숫자, 밑줄만 포함할 수 있습니다';

  @override
  String validationDescriptionMaxLength(int maxLength) {
    return '설명은 $maxLength자보다 짧아야 합니다';
  }

  @override
  String get continueTrip => '여행 계속하기';
}
