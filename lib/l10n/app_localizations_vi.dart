// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get vietnam => 'Việt Nam';

  @override
  String get appName => 'S-Mate';

  @override
  String get login => 'Đăng nhập';

  @override
  String get register => 'Đăng ký';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get password => 'Mật khẩu';

  @override
  String get home => 'Trang chủ';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get tripPlanner => 'Lập kế hoạch chuyến đi';

  @override
  String get generateItinerary => 'Tạo lịch trình';

  @override
  String get destination => 'Điểm đến';

  @override
  String get budget => 'Ngân sách';

  @override
  String get peopleCount => 'Số người';

  @override
  String get startDate => 'Ngày bắt đầu';

  @override
  String get endDate => 'Ngày kết thúc';

  @override
  String get save => 'Lưu';

  @override
  String get cancel => 'Hủy';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get notifications => 'Thông báo';

  @override
  String get settings => 'Cài đặt';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get loading => 'Đang tải';

  @override
  String get error => 'Lỗi';

  @override
  String get success => 'Thành công';

  @override
  String get retry => 'Thử lại';

  @override
  String get myTrip => 'Chuyến đi của tôi';

  @override
  String get scan => 'Quét';

  @override
  String get map => 'Bản đồ';

  @override
  String get aiChat => 'Trò chuyện AI';

  @override
  String get all => 'Tất cả';

  @override
  String get upcoming => 'Sắp tới';

  @override
  String get inProgress => 'Đang diễn ra';

  @override
  String get completed => 'Đã hoàn thành';

  @override
  String get cancelled => 'Đã hủy';

  @override
  String get couldNotLoadTrips => 'Không thể tải chuyến đi';

  @override
  String get couldNotLoadTripsMessage =>
      'Hiện tại chúng tôi không thể tải chuyến đi của bạn. Vui lòng thử lại.';

  @override
  String get tryAgain => 'Thử lại';

  @override
  String get noTripsYet => 'Chưa có chuyến đi';

  @override
  String get noTripsYetMessage =>
      'Tạo lịch trình AI đầu tiên và nó sẽ xuất hiện tại đây.';

  @override
  String get noTripsFoundForFilter => 'Không có chuyến đi phù hợp với bộ lọc';

  @override
  String get createNewTrip => 'Tạo chuyến đi mới';

  @override
  String get destinationPending => 'Chưa chọn điểm đến';

  @override
  String defaultTripName(Object destination) {
    return 'Chuyến đi $destination';
  }

  @override
  String budgetValue(Object value) {
    return 'Ngân sách: $value';
  }

  @override
  String get close => 'Đóng';

  @override
  String get back => 'Quay lại';

  @override
  String get create => 'Tạo';

  @override
  String get update => 'Cập nhật';

  @override
  String get edit => 'Sửa';

  @override
  String get done => 'Xong';

  @override
  String get customize => 'Tùy chỉnh';

  @override
  String get openMap => 'Mở bản đồ';

  @override
  String get createTrip => 'Tạo chuyến đi';

  @override
  String get welcomeBackTraveler => 'Chào mừng trở lại, du khách!';

  @override
  String get planNextAdventure => 'Lên kế hoạch cho chuyến phiêu lưu tiếp theo';

  @override
  String get itineraryReminder => 'Nhắc lịch trình';

  @override
  String get nextActivitySoon => 'Hoạt động tiếp theo của bạn sắp bắt đầu.';

  @override
  String get mapUpdate => 'Cập nhật bản đồ';

  @override
  String get nearbyRecommendationsReady =>
      'Các gợi ý gần bạn đã sẵn sàng để khám phá.';

  @override
  String get albumReminder => 'Nhắc album';

  @override
  String get addTodaysPhotos => 'Thêm ảnh hôm nay vào album chuyến đi.';

  @override
  String timeAgoHours(Object hours) {
    return '$hours giờ trước';
  }

  @override
  String timeAgoDays(Object days) {
    return '$days ngày trước';
  }

  @override
  String get planYourFirstTrip => 'Lên kế hoạch chuyến đi đầu tiên';

  @override
  String get chooseDestination => 'Chọn điểm đến của bạn';

  @override
  String get newStatus => 'Mới';

  @override
  String get action => 'Hành động';

  @override
  String get generateTrip => 'Tạo chuyến đi';

  @override
  String get generateTripDescription =>
      'Tạo lịch trình AI mới từ ngày đi và ngân sách của bạn.';

  @override
  String get currentTrip => 'Chuyến đi hiện tại';

  @override
  String get currentTrips => 'Chuyến đi hiện tại';

  @override
  String get viewMyTrips => 'Xem chuyến đi của tôi';

  @override
  String get viewItinerary => 'Xem lịch trình';

  @override
  String get popularDestinations => 'Điểm đến phổ biến';

  @override
  String get welcomeBack => 'Chào mừng trở lại';

  @override
  String get createAccount => 'Tạo tài khoản';

  @override
  String get signInContinueJourney => 'Đăng nhập để tiếp tục hành trình';

  @override
  String get signUpStartAdventure =>
      'Đăng ký để bắt đầu lên kế hoạch cho chuyến phiêu lưu tiếp theo';

  @override
  String get loginSuccessful => 'Đăng nhập thành công!';

  @override
  String get accountCreatedSuccessfully => 'Tạo tài khoản thành công!';

  @override
  String get resetPassword => 'Đặt lại mật khẩu';

  @override
  String get resetPasswordInstructions =>
      'Nhập email của bạn và chúng tôi sẽ gửi liên kết đặt lại.';

  @override
  String get sendResetLink => 'Gửi liên kết đặt lại';

  @override
  String get passwordResetOtpSent => 'Đã gửi mã OTP đặt lại mật khẩu!';

  @override
  String get fullName => 'Họ và tên';

  @override
  String get fullNameHint => 'John Doe';

  @override
  String get location => 'Vị trí';

  @override
  String get locationHint => 'San Francisco, USA';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get signUp => 'Đăng ký';

  @override
  String get dontHaveAccount => 'Chưa có tài khoản? ';

  @override
  String get alreadyHaveAccount => 'Đã có tài khoản? ';

  @override
  String get yourName => 'tên của bạn';

  @override
  String get yourLocation => 'vị trí của bạn';

  @override
  String get displayName => 'Tên hiển thị';

  @override
  String get editProfile => 'Chỉnh sửa hồ sơ';

  @override
  String get profileUpdated => 'Đã cập nhật hồ sơ!';

  @override
  String get saveChanges => 'Lưu thay đổi';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

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
    return 'Đã đổi ngôn ngữ sang $language';
  }

  @override
  String get notificationsEnabled => 'Đã bật thông báo';

  @override
  String get notificationsDisabled => 'Đã tắt thông báo';

  @override
  String get privacy => 'Quyền riêng tư';

  @override
  String get privacySetting => 'Cài đặt quyền riêng tư';

  @override
  String privacySetTo(Object privacy) {
    return 'Quyền riêng tư đặt thành $privacy';
  }

  @override
  String get changePassword => 'Đổi mật khẩu';

  @override
  String get newPassword => 'Mật khẩu mới';

  @override
  String get passwordUpdatedSuccessfully => 'Cập nhật mật khẩu thành công!';

  @override
  String get updatePassword => 'Cập nhật mật khẩu';

  @override
  String get failedSignOut => 'Không thể đăng xuất. Vui lòng thử lại.';

  @override
  String get signOut => 'Đăng xuất';

  @override
  String get signOutConfirmation => 'Bạn có chắc muốn đăng xuất không?';

  @override
  String get traveler => 'Du khách';

  @override
  String get unknown => 'Không rõ';

  @override
  String get unknownDestination => 'Điểm đến không rõ';

  @override
  String get countries => 'Quốc gia';

  @override
  String get trips => 'Chuyến đi';

  @override
  String get locations => 'Địa điểm';

  @override
  String get days => 'Ngày';

  @override
  String get tripHistory => 'Lịch sử chuyến đi';

  @override
  String get enabled => 'Đã bật';

  @override
  String get disabled => 'Đã tắt';

  @override
  String get public => 'Công khai';

  @override
  String get friendsOnly => 'Chỉ bạn bè';

  @override
  String get private => 'Riêng tư';

  @override
  String get planned => 'Đã lên kế hoạch';

  @override
  String get unknownTrip => 'Chuyến đi không rõ';

  @override
  String get aiTripPlanner => 'Trình lập kế hoạch AI';

  @override
  String get planYourJourney => 'Lên kế hoạch hành trình';

  @override
  String get aiCreatePerfectItinerary => 'Để AI tạo lịch trình hoàn hảo';

  @override
  String get selectDate => 'Chọn ngày';

  @override
  String get pleaseSelectDates => 'Vui lòng chọn ngày bắt đầu và kết thúc';

  @override
  String get endDateAfterStartDate => 'Ngày kết thúc phải sau ngày bắt đầu';

  @override
  String get tripGeneratedSuccessfully => 'Tạo chuyến đi thành công!';

  @override
  String get generateTripFailed => 'Không thể tạo chuyến đi. Vui lòng thử lại.';

  @override
  String get aiGeneratedTrip => 'Chuyến đi do AI tạo';

  @override
  String get fallbackItineraryUsed => 'Đã dùng lịch trình dự phòng';

  @override
  String get budgetUsd => 'Ngân sách (USD)';

  @override
  String get enterYourBudget => 'Nhập ngân sách của bạn';

  @override
  String get numberOfTravelers => 'Số du khách';

  @override
  String get travelPreferences => 'Sở thích du lịch';

  @override
  String get additionalPreferences => 'Sở thích bổ sung';

  @override
  String get additionalPreferencesHint =>
      'Cho chúng tôi biết thêm điều bạn thích (ví dụ: điểm ẩn, chợ địa phương, khởi hành muộn...)';

  @override
  String get generating => 'Đang tạo...';

  @override
  String get generatingTrip => 'Đang tạo chuyến đi...';

  @override
  String get generateAiItinerary => 'Tạo lịch trình AI';

  @override
  String get soloTraveler => 'Đi một mình (1 người)';

  @override
  String get coupleTravelers => 'Cặp đôi (2 người)';

  @override
  String get smallGroupTravelers => 'Nhóm nhỏ (3-5)';

  @override
  String get largeGroupTravelers => 'Nhóm lớn (6+)';

  @override
  String get cultural => 'Văn hóa';

  @override
  String get adventure => 'Phiêu lưu';

  @override
  String get relaxation => 'Thư giãn';

  @override
  String get food => 'Ẩm thực';

  @override
  String get nature => 'Thiên nhiên';

  @override
  String get shopping => 'Mua sắm';

  @override
  String get tripDay => 'Ngày trong chuyến đi';

  @override
  String get tripItinerary => 'Lịch trình chuyến đi';

  @override
  String get tripSavedSuccessfully => 'Đã lưu chuyến đi!';

  @override
  String get newActivity => 'Hoạt động mới';

  @override
  String get customActivity => 'Hoạt động tùy chỉnh';

  @override
  String get editDayTitle => 'Sửa tiêu đề ngày';

  @override
  String get dayTitle => 'Tiêu đề ngày';

  @override
  String get previewYourPlan => 'Xem trước kế hoạch';

  @override
  String get tripProgress => 'Tiến độ chuyến đi';

  @override
  String completedCount(Object completed, Object total) {
    return 'Đã hoàn thành $completed/$total';
  }

  @override
  String get confirmSavePlan => 'Xác nhận và lưu kế hoạch';

  @override
  String dayNumber(Object day) {
    return 'NGÀY $day';
  }

  @override
  String get addActivity => 'Thêm hoạt động';

  @override
  String get arrivalLocalDiscovery => 'Đến nơi & khám phá địa phương';

  @override
  String get cityLandmarkVisit => 'Thăm biểu tượng thành phố';

  @override
  String get localFoodExperience => 'Trải nghiệm ẩm thực địa phương';

  @override
  String get culturalSite => 'Điểm văn hóa';

  @override
  String get eveningWalk => 'Dạo buổi tối';

  @override
  String get adventureExploration => 'Phiêu lưu & khám phá';

  @override
  String get morningExcursion => 'Chuyến đi buổi sáng';

  @override
  String get lunchBreak => 'Nghỉ ăn trưa';

  @override
  String get outdoorActivity => 'Hoạt động ngoài trời';

  @override
  String get dinnerRelaxation => 'Ăn tối & thư giãn';

  @override
  String get relaxedFinalDay => 'Ngày cuối thư thái';

  @override
  String get slowMorning => 'Buổi sáng chậm rãi';

  @override
  String get souvenirShopping => 'Mua quà lưu niệm';

  @override
  String get finalPhotoSpot => 'Điểm chụp ảnh cuối';

  @override
  String get exploringSaigon => 'Khám phá Sài Gòn';

  @override
  String get mockLandmarkDescription =>
      'Bắt đầu chuyến đi với một biểu tượng địa phương nổi tiếng.';

  @override
  String get mockFoodDescription =>
      'Thử món ăn địa phương chính gốc gần trung tâm thành phố.';

  @override
  String get mockCulturalDescription =>
      'Thăm bảo tàng, đền chùa hoặc điểm văn hóa.';

  @override
  String get mockEveningDescription =>
      'Tận hưởng không khí thành phố vào buổi tối.';

  @override
  String get mockExcursionDescription =>
      'Đi một chuyến ngắn tới điểm tham quan gần đó.';

  @override
  String get mockLunchDescription =>
      'Nạp năng lượng tại một nhà hàng địa phương được gợi ý.';

  @override
  String get mockOutdoorDescription =>
      'Khám phá thiên nhiên, chợ hoặc những điểm ẩn.';

  @override
  String get mockDinnerDescription => 'Kết thúc ngày bằng bữa tối thư giãn.';

  @override
  String get mockSlowMorningDescription =>
      'Bắt đầu chậm rãi hơn với cà phê hoặc bữa sáng.';

  @override
  String get mockSouvenirDescription =>
      'Mua quà lưu niệm hoặc ghé chợ địa phương.';

  @override
  String get mockPhotoDescription => 'Ghi lại kỷ niệm cuối trước khi rời đi.';

  @override
  String get scanDemoResult =>
      'Đang hiển thị kết quả demo cho đến khi API kiểm tra giá khả dụng.';

  @override
  String get estimatedLocalPrice => 'Giá địa phương ước tính';

  @override
  String get detectedPrice => 'Giá phát hiện';

  @override
  String get advice => 'Lời khuyên';

  @override
  String get cameraPreview => 'Xem trước camera';

  @override
  String get cameraPreviewHint =>
      'Hướng vào món đồ, hóa đơn hoặc giá trên menu.';

  @override
  String get checkingPrice => 'Đang kiểm tra giá...';

  @override
  String get scanItemMenu => 'Quét món đồ hoặc menu';

  @override
  String get takePhoto => 'Chụp ảnh';

  @override
  String get upload => 'Tải lên';

  @override
  String get priceCheckInfo =>
      'Kiểm tra giá so sánh giá phát hiện với mức giá địa phương khi backend scanner được kết nối.';

  @override
  String get scannedItem => 'Mục đã quét';

  @override
  String get pending => 'Đang chờ';

  @override
  String get unknownWarning => 'Không rõ';

  @override
  String get scanAdviceDefault =>
      'Hãy đối chiếu giá với tham khảo địa phương trước khi thanh toán.';

  @override
  String get menuItem => 'Món trên menu';

  @override
  String get apiPending => 'API đang chờ';

  @override
  String get demo => 'Demo';

  @override
  String get scanBackendPending =>
      'Backend scanner chưa được kết nối. Dùng bố cục này làm bề mặt kết quả tương lai.';

  @override
  String get usingOfflinePlaces => 'Đang dùng địa điểm ngoại tuyến.';

  @override
  String zoomPercent(Object percent) {
    return 'Thu phóng: $percent%';
  }

  @override
  String get centeringLocation => 'Đang căn giữa vị trí của bạn...';

  @override
  String get searchPlaces => 'Tìm địa điểm...';

  @override
  String get mapExplorer => 'Khám phá bản đồ';

  @override
  String get myLocation => 'Vị trí của tôi';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get zoomIn => 'Phóng to';

  @override
  String get zoomOut => 'Thu nhỏ';

  @override
  String get nearbyPlaces => 'Địa điểm gần đây';

  @override
  String foundCount(Object count) {
    return 'Tìm thấy $count';
  }

  @override
  String get noPlacesFound => 'Không tìm thấy địa điểm';

  @override
  String get place => 'Địa điểm';

  @override
  String get unknownPlace => 'Địa điểm không rõ';

  @override
  String get nearby => 'Gần đây';

  @override
  String get coffeeShop => 'Quán cà phê';

  @override
  String get vietnameseRestaurant => 'Nhà hàng Việt Nam';

  @override
  String get market => 'Chợ';

  @override
  String get aiTravelAssistant => 'Trợ lý du lịch AI';

  @override
  String get alwaysHereToHelp => 'Luôn sẵn sàng hỗ trợ';

  @override
  String get askMeAnything => 'Hỏi tôi bất cứ điều gì...';

  @override
  String get suggestedQuestions => 'Câu hỏi gợi ý';

  @override
  String get assistantGreeting =>
      'Xin chào! Tôi là trợ lý du lịch AI của bạn. Tôi có thể giúp bạn với gợi ý địa phương, dịch thuật, mẹo văn hóa và câu hỏi du lịch. Hôm nay tôi có thể giúp gì?';

  @override
  String get assistantFallback =>
      'Tôi có thể giúp việc đó. Bạn có thể cung cấp thêm chi tiết không?';

  @override
  String get assistantConnectionError =>
      'Xin lỗi, tôi không thể kết nối tới trợ lý AI.';

  @override
  String get suggestionBestTimeHaLong =>
      'Thời điểm tốt nhất để thăm Ha Long Bay là khi nào?';

  @override
  String get suggestionVietnameseRestaurants =>
      'Gợi ý nhà hàng Việt Nam chính gốc';

  @override
  String get suggestionHanoiToSapa => 'Làm sao đi từ Hanoi đến Sapa?';

  @override
  String get suggestionLocalCustoms => 'Tôi nên biết phong tục địa phương nào?';

  @override
  String get completeYourPurchase => 'Hoàn tất mua hàng';

  @override
  String get paymentInformation => 'Thông tin thanh toán';

  @override
  String get choosePlanUnlock =>
      'Chọn gói và mở khóa trải nghiệm du lịch cá nhân hóa';

  @override
  String get mostPopular => 'Phổ biến nhất';

  @override
  String get perTrip => ' /chuyến';

  @override
  String get selected => 'Đã chọn';

  @override
  String get selectPlan => 'Chọn gói';

  @override
  String continueToPayment(Object price) {
    return 'Tiếp tục thanh toán - $price';
  }

  @override
  String get purchaseSuccessful => 'Mua hàng thành công!';

  @override
  String get planActiveEnjoyTrip =>
      'Gói của bạn đã kích hoạt. Chúc bạn có chuyến đi vui vẻ!';

  @override
  String get openItinerary => 'Mở lịch trình';

  @override
  String get goToHome => 'Về trang chủ';

  @override
  String get required => 'Bắt buộc';

  @override
  String get cardNumber => 'Số thẻ';

  @override
  String get cardholderName => 'Tên chủ thẻ';

  @override
  String get cardholderNameHint => 'John Doe';

  @override
  String get expiryDate => 'Ngày hết hạn';

  @override
  String get expiryDateHint => 'MM/YY';

  @override
  String get cvv => 'CVV';

  @override
  String get demoPaymentWarning =>
      'Đây là thanh toán demo. Không nhập thông tin thẻ thật.';

  @override
  String get processing => 'Đang xử lý...';

  @override
  String completePurchase(Object price) {
    return 'Hoàn tất mua - $price';
  }

  @override
  String get basicPlan => 'Gói cơ bản';

  @override
  String get premiumPlan => 'Gói cao cấp';

  @override
  String get proPlan => 'Gói Pro';

  @override
  String get sevenDays => '7 ngày';

  @override
  String get fourteenDays => '14 ngày';

  @override
  String get thirtyDays => '30 ngày';

  @override
  String get unlimitedPlanning => 'Lập kế hoạch không giới hạn';

  @override
  String get fullMapAccess => 'Truy cập bản đồ đầy đủ';

  @override
  String get smartAiSuggestions => 'Gợi ý AI thông minh';

  @override
  String get premiumFeatures => 'Tính năng cao cấp';

  @override
  String get prioritySupport => 'Hỗ trợ ưu tiên';

  @override
  String get plan => 'Gói';

  @override
  String get tripAlbums => 'Album chuyến đi';

  @override
  String get newAlbum => 'Album mới';

  @override
  String get createNewAlbum => 'Tạo album mới';

  @override
  String get albumName => 'Tên album';

  @override
  String get albumNameHint => 'ví dụ: Phiêu lưu Hanoi';

  @override
  String get description => 'Mô tả';

  @override
  String get publicAlbum => 'Album công khai';

  @override
  String get albumCreated => 'Đã tạo album!';

  @override
  String get noAlbumsYet => 'Chưa có album';

  @override
  String get createFirstAlbum => 'Tạo album đầu tiên của bạn';

  @override
  String get createAlbum => 'Tạo album';

  @override
  String get untitledAlbum => 'Album chưa đặt tên';

  @override
  String get tripCamera => 'Camera chuyến đi';

  @override
  String get savePhoto => 'Lưu ảnh';

  @override
  String get caption => 'Chú thích';

  @override
  String get captionHint => 'Viết điều gì đó về bức ảnh này...';

  @override
  String get photoLocationHint => 'ví dụ: Da Lat, Vietnam';

  @override
  String get cameraSource => 'camera';

  @override
  String get gallerySource => 'thư viện';

  @override
  String get mustLoginUploadPhotos =>
      'Bạn phải đăng nhập trước khi tải ảnh lên.';

  @override
  String get photoReadyUploadUnavailable =>
      'Ảnh đã sẵn sàng. Backend tải lên chưa khả dụng.';

  @override
  String get photoSaveFailed => 'Không thể lưu ảnh. Vui lòng thử lại.';

  @override
  String photoSaveFailedWithMessage(Object message) {
    return 'Không thể lưu ảnh: $message';
  }

  @override
  String tripCameraPermissionDenied(Object source) {
    return 'Quyền bị từ chối. Vui lòng cho phép truy cập $source và thử lại.';
  }

  @override
  String couldNotOpenSource(Object source, Object message) {
    return 'Không thể mở $source. $message';
  }

  @override
  String get couldNotSelectPhoto => 'Không thể chọn ảnh. Vui lòng thử lại.';

  @override
  String get viewAlbums => 'Xem album';

  @override
  String get readyCaptureMoment => 'Sẵn sàng ghi lại khoảnh khắc?';

  @override
  String get tapOpenCamera => 'Nhấn bên dưới để mở camera';

  @override
  String get openCamera => 'Mở camera';

  @override
  String get uploadFromGallery => 'Tải lên từ thư viện';

  @override
  String get photoUploadBackendInfo =>
      'Tải ảnh lên sẽ được bật khi backend thêm lưu trữ album';

  @override
  String get emergencySupport => 'Hỗ trợ khẩn cấp';

  @override
  String playingPhrase(Object phrase) {
    return 'Đang phát: $phrase';
  }

  @override
  String get quickTalk => 'Câu nói nhanh';

  @override
  String get emergencyContacts => 'Liên hệ khẩn cấp';

  @override
  String get emergency => 'Khẩn cấp';

  @override
  String get police => 'Cảnh sát';

  @override
  String get fire => 'Cứu hỏa';

  @override
  String get ambulance => 'Cấp cứu';

  @override
  String get general => 'Chung';

  @override
  String get medical => 'Y tế';

  @override
  String get incident => 'Sự cố';

  @override
  String get security => 'An ninh';

  @override
  String get navigation => 'Điều hướng';

  @override
  String get communication => 'Giao tiếp';

  @override
  String get call => 'Gọi';

  @override
  String get quickTips => 'Mẹo nhanh';

  @override
  String get tipHotelAddress =>
      'Luôn mang theo địa chỉ khách sạn bằng tiếng Việt.';

  @override
  String get tipPhoneBattery => 'Kiểm tra pin điện thoại trước khi ra ngoài.';

  @override
  String get tipSaveEmergencyContacts =>
      'Lưu số liên hệ khẩn cấp trong điện thoại.';

  @override
  String get phraseHelpMe => 'Làm ơn giúp tôi!';

  @override
  String get phraseHospital => 'Bệnh viện gần nhất ở đâu?';

  @override
  String get phraseLostWalletPassport => 'Tôi bị mất ví/hộ chiếu.';

  @override
  String get phraseCallPolice => 'Tôi cần gọi cảnh sát.';

  @override
  String get phraseLost => 'Tôi bị lạc.';

  @override
  String get phraseSpeakEnglish => 'Bạn có nói tiếng Anh không?';

  @override
  String get aboutSMate => 'Giới thiệu S-Mate';

  @override
  String get aboutSMateDescription =>
      'S-Mate là người bạn đồng hành du lịch tất cả trong một, giúp mọi hành trình mượt mà và đáng nhớ.';

  @override
  String get aiTripPlanning => 'Lập kế hoạch AI';

  @override
  String get aiTripPlanningDescription =>
      'Tạo lịch trình cá nhân hóa bằng AI. Chỉ cần nhập điểm đến, ngày đi và sở thích.';

  @override
  String get interactiveMaps => 'Bản đồ tương tác';

  @override
  String get interactiveMapsDescription =>
      'Khám phá điểm đến với bản đồ thời gian thực, địa điểm gần bạn và hỗ trợ điều hướng.';

  @override
  String get assistant247 => 'Trợ lý AI 24/7';

  @override
  String get assistant247Description =>
      'Nhận câu trả lời tức thì về phong tục địa phương, dịch thuật, nhà hàng và mẹo du lịch.';

  @override
  String get tripAlbumsFeatureDescription =>
      'Ghi lại và sắp xếp kỷ niệm du lịch bằng ảnh và album.';

  @override
  String get emergencySupportDescription =>
      'Truy cập liên hệ khẩn cấp, câu nói nhanh và mẹo an toàn cho mọi tình huống.';

  @override
  String get smartTips => 'Mẹo thông minh';

  @override
  String get smartTipsDescription =>
      'Nhận gợi ý du lịch cá nhân hóa cho kế hoạch và điểm đến của bạn.';

  @override
  String get getStarted => 'Bắt đầu';

  @override
  String get welcomeToSMate => 'Chào mừng đến với S-Mate';

  @override
  String get introSubtitle =>
      'Người bạn đồng hành thông minh để khám phá, lên kế hoạch và trải nghiệm những hành trình khó quên';

  @override
  String get smartItineraries => 'Lịch trình thông minh';

  @override
  String get exploreDestinations => 'Khám phá điểm đến';

  @override
  String get instantAnswers => 'Câu trả lời tức thì';

  @override
  String get saveMemories => 'Lưu kỷ niệm';

  @override
  String get localLaws => 'Luật địa phương';

  @override
  String get staySafe => 'Giữ an toàn';

  @override
  String get personalized => 'Cá nhân hóa';

  @override
  String get learnMore => 'Tìm hiểu thêm';

  @override
  String get copyright => '© 2026 S-Mate. Đã đăng ký bản quyền.';

  @override
  String validationRequiredField(String fieldName) {
    return 'Vui lòng nhập $fieldName';
  }

  @override
  String get validationEmailRequired => 'Vui lòng nhập email của bạn';

  @override
  String get validationEmailInvalid => 'Nhập địa chỉ email hợp lệ';

  @override
  String get validationPasswordRequired => 'Vui lòng nhập mật khẩu';

  @override
  String validationPasswordMinLength(int min) {
    return 'Mật khẩu phải có ít nhất $min ký tự';
  }

  @override
  String get validationPasswordTooLong => 'Mật khẩu quá dài';

  @override
  String get validationPasswordComplexity =>
      'Mật khẩu phải có chữ hoa, số và ký tự đặc biệt';

  @override
  String get validationConfirmPasswordRequired => 'Vui lòng xác nhận mật khẩu';

  @override
  String get validationPasswordsDoNotMatch => 'Mật khẩu không khớp';

  @override
  String validationNumberInvalid(String fieldName) {
    return '$fieldName phải là số hợp lệ';
  }

  @override
  String validationNumberNegative(String fieldName) {
    return '$fieldName không được âm';
  }

  @override
  String validationMinLength(String fieldName, int min) {
    return '$fieldName phải có ít nhất $min ký tự';
  }

  @override
  String validationMaxLength(String fieldName, int max) {
    return '$fieldName phải ít hơn $max ký tự';
  }

  @override
  String get validationPhoneRequired => 'Vui lòng nhập số điện thoại';

  @override
  String get validationPhoneInvalid => 'Số điện thoại không hợp lệ';

  @override
  String get validationBudgetTooLow => 'Ngân sách quá thấp';

  @override
  String get validationUsernameRequired => 'Vui lòng nhập tên người dùng';

  @override
  String validationUsernameMinLength(int min) {
    return 'Tên người dùng phải có ít nhất $min ký tự';
  }

  @override
  String get validationUsernameTooLong => 'Tên người dùng quá dài';

  @override
  String get validationUsernameInvalid =>
      'Tên người dùng chỉ được chứa chữ cái, số và dấu gạch dưới';

  @override
  String validationDescriptionMaxLength(int maxLength) {
    return 'Mô tả phải ít hơn $maxLength ký tự';
  }

  @override
  String get continueTrip => 'Tiếp tục chuyến đi';
}
