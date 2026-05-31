// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get vietnam => 'Vietnam';

  @override
  String get appName => 'S-Mate';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get password => 'Password';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get tripPlanner => 'Trip planner';

  @override
  String get generateItinerary => 'Generate itinerary';

  @override
  String get destination => 'Destination';

  @override
  String get budget => 'Budget';

  @override
  String get peopleCount => 'People count';

  @override
  String get startDate => 'Start date';

  @override
  String get endDate => 'End date';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get logout => 'Logout';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get loading => 'Loading';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get retry => 'Retry';

  @override
  String get myTrip => 'My Trip';

  @override
  String get scan => 'Scan';

  @override
  String get map => 'Map';

  @override
  String get aiChat => 'AI Chat';

  @override
  String get all => 'All';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get inProgress => 'In Progress';

  @override
  String get completed => 'Completed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get couldNotLoadTrips => 'Could not load trips';

  @override
  String get couldNotLoadTripsMessage =>
      'We could not load your trips right now. Please try again.';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get noTripsYet => 'No trips yet';

  @override
  String get noTripsYetMessage =>
      'Create your first AI itinerary and it will appear here.';

  @override
  String get noTripsFoundForFilter => 'No trips found for this filter';

  @override
  String get createNewTrip => 'Create New Trip';

  @override
  String get destinationPending => 'Destination pending';

  @override
  String defaultTripName(Object destination) {
    return '$destination trip';
  }

  @override
  String budgetValue(Object value) {
    return 'Budget: $value';
  }

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get create => 'Create';

  @override
  String get update => 'Update';

  @override
  String get edit => 'Edit';

  @override
  String get done => 'Done';

  @override
  String get customize => 'Customize';

  @override
  String get openMap => 'Open Map';

  @override
  String get createTrip => 'Create Trip';

  @override
  String get welcomeBackTraveler => 'Welcome back, Traveler!';

  @override
  String get planNextAdventure => 'Plan your next adventure';

  @override
  String get itineraryReminder => 'Itinerary Reminder';

  @override
  String get nextActivitySoon => 'Your next activity is coming soon.';

  @override
  String get mapUpdate => 'Map Update';

  @override
  String get nearbyRecommendationsReady =>
      'Nearby recommendations are ready to explore.';

  @override
  String get albumReminder => 'Album Reminder';

  @override
  String get addTodaysPhotos => 'Add today\'s photos to your trip album.';

  @override
  String timeAgoHours(Object hours) {
    return '${hours}h ago';
  }

  @override
  String timeAgoDays(Object days) {
    return '${days}d ago';
  }

  @override
  String get planYourFirstTrip => 'Plan Your First Trip';

  @override
  String get chooseDestination => 'Choose your destination';

  @override
  String get newStatus => 'New';

  @override
  String get action => 'Action';

  @override
  String get generateTrip => 'Generate Trip';

  @override
  String get generateTripDescription =>
      'Create a new AI itinerary from your dates and budget.';

  @override
  String get currentTrip => 'Current Trip';

  @override
  String get currentTrips => 'Current Trips';

  @override
  String get viewMyTrips => 'View My Trips';

  @override
  String get viewItinerary => 'View Itinerary';

  @override
  String get popularDestinations => 'Popular Destinations';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get createAccount => 'Create Account';

  @override
  String get signInContinueJourney => 'Sign in to continue your journey';

  @override
  String get signUpStartAdventure =>
      'Sign up to start planning your next adventure';

  @override
  String get loginSuccessful => 'Login successful!';

  @override
  String get accountCreatedSuccessfully => 'Account created successfully!';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordInstructions =>
      'Enter your email and we will send you a reset link.';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get passwordResetOtpSent => 'Password reset OTP sent!';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameHint => 'John Doe';

  @override
  String get location => 'Location';

  @override
  String get locationHint => 'San Francisco, USA';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get yourName => 'your name';

  @override
  String get yourLocation => 'your location';

  @override
  String get displayName => 'Display Name';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get profileUpdated => 'Profile updated!';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get selectLanguage => 'Select Language';

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
    return 'Language changed to $language';
  }

  @override
  String get notificationsEnabled => 'Notifications enabled';

  @override
  String get notificationsDisabled => 'Notifications disabled';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacySetting => 'Privacy Setting';

  @override
  String privacySetTo(Object privacy) {
    return 'Privacy set to $privacy';
  }

  @override
  String get changePassword => 'Change Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get passwordUpdatedSuccessfully => 'Password updated successfully!';

  @override
  String get updatePassword => 'Update Password';

  @override
  String get failedSignOut => 'Failed to sign out. Please try again.';

  @override
  String get signOut => 'Sign Out';

  @override
  String get signOutConfirmation => 'Are you sure you want to sign out?';

  @override
  String get traveler => 'Traveler';

  @override
  String get unknown => 'Unknown';

  @override
  String get unknownDestination => 'Unknown destination';

  @override
  String get countries => 'Countries';

  @override
  String get trips => 'Trips';

  @override
  String get locations => 'Locations';

  @override
  String get days => 'Days';

  @override
  String get tripHistory => 'Trip History';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get public => 'Public';

  @override
  String get friendsOnly => 'Friends Only';

  @override
  String get private => 'Private';

  @override
  String get planned => 'Planned';

  @override
  String get unknownTrip => 'Unknown trip';

  @override
  String get aiTripPlanner => 'AI Trip Planner';

  @override
  String get planYourJourney => 'Plan Your Journey';

  @override
  String get aiCreatePerfectItinerary => 'Let AI create the perfect itinerary';

  @override
  String get selectDate => 'Select date';

  @override
  String get pleaseSelectDates => 'Please select start and end dates';

  @override
  String get endDateAfterStartDate => 'End date must be after start date';

  @override
  String get tripGeneratedSuccessfully => 'Trip generated successfully!';

  @override
  String get generateTripFailed => 'Could not generate trip. Please try again.';

  @override
  String get aiGeneratedTrip => 'AI-generated trip';

  @override
  String get fallbackItineraryUsed => 'Fallback itinerary used';

  @override
  String get budgetUsd => 'Budget (USD)';

  @override
  String get enterYourBudget => 'Enter your budget';

  @override
  String get numberOfTravelers => 'Number of Travelers';

  @override
  String get travelPreferences => 'Travel Preferences';

  @override
  String get additionalPreferences => 'Additional Preferences';

  @override
  String get additionalPreferencesHint =>
      'Tell us more about what you like (e.g., hidden gems, local markets, late starts...)';

  @override
  String get generating => 'Generating...';

  @override
  String get generatingTrip => 'Generating trip...';

  @override
  String get generateAiItinerary => 'Generate AI Itinerary';

  @override
  String get soloTraveler => 'Solo (1 person)';

  @override
  String get coupleTravelers => 'Couple (2 people)';

  @override
  String get smallGroupTravelers => 'Small Group (3-5)';

  @override
  String get largeGroupTravelers => 'Large Group (6+)';

  @override
  String get cultural => 'Cultural';

  @override
  String get adventure => 'Adventure';

  @override
  String get relaxation => 'Relaxation';

  @override
  String get food => 'Food';

  @override
  String get nature => 'Nature';

  @override
  String get shopping => 'Shopping';

  @override
  String get tripDay => 'Trip Day';

  @override
  String get tripItinerary => 'Trip Itinerary';

  @override
  String get tripSavedSuccessfully => 'Trip saved successfully!';

  @override
  String get newActivity => 'New Activity';

  @override
  String get customActivity => 'Custom activity';

  @override
  String get editDayTitle => 'Edit Day Title';

  @override
  String get dayTitle => 'Day title';

  @override
  String get previewYourPlan => 'Preview Your Plan';

  @override
  String get tripProgress => 'Trip Progress';

  @override
  String completedCount(Object completed, Object total) {
    return '$completed/$total completed';
  }

  @override
  String get confirmSavePlan => 'Confirm and Save Plan';

  @override
  String dayNumber(Object day) {
    return 'DAY $day';
  }

  @override
  String get addActivity => 'Add Activity';

  @override
  String get arrivalLocalDiscovery => 'Arrival & Local Discovery';

  @override
  String get cityLandmarkVisit => 'City Landmark Visit';

  @override
  String get localFoodExperience => 'Local Food Experience';

  @override
  String get culturalSite => 'Cultural Site';

  @override
  String get eveningWalk => 'Evening Walk';

  @override
  String get adventureExploration => 'Adventure & Exploration';

  @override
  String get morningExcursion => 'Morning Excursion';

  @override
  String get lunchBreak => 'Lunch Break';

  @override
  String get outdoorActivity => 'Outdoor Activity';

  @override
  String get dinnerRelaxation => 'Dinner & Relaxation';

  @override
  String get relaxedFinalDay => 'Relaxed Final Day';

  @override
  String get slowMorning => 'Slow Morning';

  @override
  String get souvenirShopping => 'Souvenir Shopping';

  @override
  String get finalPhotoSpot => 'Final Photo Spot';

  @override
  String get exploringSaigon => 'Exploring Saigon';

  @override
  String get mockLandmarkDescription =>
      'Start your trip with a famous local landmark.';

  @override
  String get mockFoodDescription =>
      'Try authentic local food near the city center.';

  @override
  String get mockCulturalDescription =>
      'Visit a museum, temple, or cultural destination.';

  @override
  String get mockEveningDescription =>
      'Enjoy the city atmosphere in the evening.';

  @override
  String get mockExcursionDescription =>
      'Take a short trip to a nearby attraction.';

  @override
  String get mockLunchDescription =>
      'Recharge with a recommended local restaurant.';

  @override
  String get mockOutdoorDescription =>
      'Explore nature, markets, or hidden gems.';

  @override
  String get mockDinnerDescription => 'End your day with a relaxing dinner.';

  @override
  String get mockSlowMorningDescription =>
      'Enjoy a slower start with coffee or breakfast.';

  @override
  String get mockSouvenirDescription =>
      'Buy souvenirs or visit a local market.';

  @override
  String get mockPhotoDescription => 'Capture final memories before leaving.';

  @override
  String get scanDemoResult =>
      'Demo result shown until the price-check API is available.';

  @override
  String get estimatedLocalPrice => 'Estimated local price';

  @override
  String get detectedPrice => 'Detected price';

  @override
  String get advice => 'Advice';

  @override
  String get cameraPreview => 'Camera preview';

  @override
  String get cameraPreviewHint => 'Point at an item, receipt, or menu price.';

  @override
  String get checkingPrice => 'Checking Price...';

  @override
  String get scanItemMenu => 'Scan Item or Menu';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get upload => 'Upload';

  @override
  String get priceCheckInfo =>
      'Price check compares detected prices with local ranges when the backend scanner is connected.';

  @override
  String get scannedItem => 'Scanned item';

  @override
  String get pending => 'Pending';

  @override
  String get unknownWarning => 'Unknown';

  @override
  String get scanAdviceDefault =>
      'Review the price with a local reference before paying.';

  @override
  String get menuItem => 'Menu item';

  @override
  String get apiPending => 'API pending';

  @override
  String get demo => 'Demo';

  @override
  String get scanBackendPending =>
      'Scanner backend is not connected yet. Use this layout as the future result surface.';

  @override
  String get usingOfflinePlaces => 'Using offline places.';

  @override
  String zoomPercent(Object percent) {
    return 'Zoom: $percent%';
  }

  @override
  String get centeringLocation => 'Centering on your location...';

  @override
  String get searchPlaces => 'Search places...';

  @override
  String get mapExplorer => 'Map Explorer';

  @override
  String get myLocation => 'My Location';

  @override
  String get search => 'Search';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get nearbyPlaces => 'Nearby Places';

  @override
  String foundCount(Object count) {
    return '$count found';
  }

  @override
  String get noPlacesFound => 'No places found';

  @override
  String get place => 'Place';

  @override
  String get unknownPlace => 'Unknown Place';

  @override
  String get nearby => 'Nearby';

  @override
  String get coffeeShop => 'Coffee Shop';

  @override
  String get vietnameseRestaurant => 'Vietnamese Restaurant';

  @override
  String get market => 'Market';

  @override
  String get aiTravelAssistant => 'AI Travel Assistant';

  @override
  String get alwaysHereToHelp => 'Always here to help';

  @override
  String get askMeAnything => 'Ask me anything...';

  @override
  String get suggestedQuestions => 'Suggested Questions';

  @override
  String get assistantGreeting =>
      'Hello! I\'m your AI travel assistant. I can help you with local recommendations, translations, cultural tips, and travel questions. How can I help you today?';

  @override
  String get assistantFallback =>
      'I can help with that. Can you provide more details?';

  @override
  String get assistantConnectionError =>
      'Sorry, I could not connect to the AI assistant.';

  @override
  String get suggestionBestTimeHaLong =>
      'What\'s the best time to visit Ha Long Bay?';

  @override
  String get suggestionVietnameseRestaurants =>
      'Recommend authentic Vietnamese restaurants';

  @override
  String get suggestionHanoiToSapa => 'How do I get from Hanoi to Sapa?';

  @override
  String get suggestionLocalCustoms => 'What are local customs I should know?';

  @override
  String get completeYourPurchase => 'Complete Your Purchase';

  @override
  String get paymentInformation => 'Payment Information';

  @override
  String get choosePlanUnlock =>
      'Choose a plan and unlock your personalized travel experience';

  @override
  String get mostPopular => 'Most Popular';

  @override
  String get perTrip => ' /trip';

  @override
  String get selected => 'Selected';

  @override
  String get selectPlan => 'Select Plan';

  @override
  String continueToPayment(Object price) {
    return 'Continue to Payment - $price';
  }

  @override
  String get purchaseSuccessful => 'Purchase Successful!';

  @override
  String get planActiveEnjoyTrip => 'Your plan is now active. Enjoy your trip!';

  @override
  String get openItinerary => 'Open Itinerary';

  @override
  String get goToHome => 'Go to Home';

  @override
  String get required => 'Required';

  @override
  String get cardNumber => 'Card Number';

  @override
  String get cardholderName => 'Cardholder Name';

  @override
  String get cardholderNameHint => 'John Doe';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String get expiryDateHint => 'MM/YY';

  @override
  String get cvv => 'CVV';

  @override
  String get demoPaymentWarning =>
      'This is a demo payment. Do not enter real card information.';

  @override
  String get processing => 'Processing...';

  @override
  String completePurchase(Object price) {
    return 'Complete Purchase - $price';
  }

  @override
  String get basicPlan => 'Basic Plan';

  @override
  String get premiumPlan => 'Premium Plan';

  @override
  String get proPlan => 'Pro Plan';

  @override
  String get sevenDays => '7 Days';

  @override
  String get fourteenDays => '14 Days';

  @override
  String get thirtyDays => '30 Days';

  @override
  String get unlimitedPlanning => 'Unlimited Planning';

  @override
  String get fullMapAccess => 'Full Map Access';

  @override
  String get smartAiSuggestions => 'Smart AI Suggestions';

  @override
  String get premiumFeatures => 'Premium Features';

  @override
  String get prioritySupport => 'Priority Support';

  @override
  String get plan => 'Plan';

  @override
  String get tripAlbums => 'Trip Albums';

  @override
  String get newAlbum => 'New Album';

  @override
  String get createNewAlbum => 'Create New Album';

  @override
  String get albumName => 'Album Name';

  @override
  String get albumNameHint => 'e.g., Hanoi Adventures';

  @override
  String get description => 'Description';

  @override
  String get publicAlbum => 'Public Album';

  @override
  String get albumCreated => 'Album created!';

  @override
  String get noAlbumsYet => 'No Albums Yet';

  @override
  String get createFirstAlbum => 'Create your first album';

  @override
  String get createAlbum => 'Create Album';

  @override
  String get untitledAlbum => 'Untitled Album';

  @override
  String get tripCamera => 'Trip Camera';

  @override
  String get savePhoto => 'Save Photo';

  @override
  String get caption => 'Caption';

  @override
  String get captionHint => 'Write something about this photo...';

  @override
  String get photoLocationHint => 'e.g., Da Lat, Vietnam';

  @override
  String get cameraSource => 'camera';

  @override
  String get gallerySource => 'gallery';

  @override
  String get mustLoginUploadPhotos => 'You must login before uploading photos.';

  @override
  String get photoReadyUploadUnavailable =>
      'Photo ready. Backend upload is not available yet.';

  @override
  String get photoSaveFailed => 'Photo could not be saved. Please try again.';

  @override
  String photoSaveFailedWithMessage(Object message) {
    return 'Photo could not be saved: $message';
  }

  @override
  String tripCameraPermissionDenied(Object source) {
    return 'Permission denied. Please allow $source access and try again.';
  }

  @override
  String couldNotOpenSource(Object source, Object message) {
    return 'Could not open $source. $message';
  }

  @override
  String get couldNotSelectPhoto => 'Could not select photo. Please try again.';

  @override
  String get viewAlbums => 'View Albums';

  @override
  String get readyCaptureMoment => 'Ready to capture the moment?';

  @override
  String get tapOpenCamera => 'Tap below to open your camera';

  @override
  String get openCamera => 'Open Camera';

  @override
  String get uploadFromGallery => 'Upload from Gallery';

  @override
  String get photoUploadBackendInfo =>
      'Photo upload will be enabled when the backend adds album storage';

  @override
  String get emergencySupport => 'Emergency Support';

  @override
  String playingPhrase(Object phrase) {
    return 'Playing: $phrase';
  }

  @override
  String get quickTalk => 'Quick Talk';

  @override
  String get emergencyContacts => 'Emergency Contacts';

  @override
  String get emergency => 'Emergency';

  @override
  String get police => 'Police';

  @override
  String get fire => 'Fire';

  @override
  String get ambulance => 'Ambulance';

  @override
  String get general => 'General';

  @override
  String get medical => 'Medical';

  @override
  String get incident => 'Incident';

  @override
  String get security => 'Security';

  @override
  String get navigation => 'Navigation';

  @override
  String get communication => 'Communication';

  @override
  String get call => 'Call';

  @override
  String get quickTips => 'Quick Tips';

  @override
  String get tipHotelAddress =>
      'Always bring your hotel address in Vietnamese.';

  @override
  String get tipPhoneBattery => 'Check your phone battery before going out.';

  @override
  String get tipSaveEmergencyContacts =>
      'Save emergency contacts in your phone.';

  @override
  String get phraseHelpMe => 'Please help me!';

  @override
  String get phraseHospital => 'Where is the nearest hospital?';

  @override
  String get phraseLostWalletPassport => 'I lost my wallet/passport.';

  @override
  String get phraseCallPolice => 'I need to call the police.';

  @override
  String get phraseLost => 'I am lost.';

  @override
  String get phraseSpeakEnglish => 'Do you speak English?';

  @override
  String get aboutSMate => 'About S-Mate';

  @override
  String get aboutSMateDescription =>
      'S-Mate is your all-in-one travel companion designed to make every journey seamless and memorable.';

  @override
  String get aiTripPlanning => 'AI Trip Planning';

  @override
  String get aiTripPlanningDescription =>
      'Generate personalized itineraries powered by AI. Just enter your destination, dates, and preferences.';

  @override
  String get interactiveMaps => 'Interactive Maps';

  @override
  String get interactiveMapsDescription =>
      'Explore destinations with real-time maps, nearby places, and navigation support.';

  @override
  String get assistant247 => '24/7 AI Assistant';

  @override
  String get assistant247Description =>
      'Get instant answers about local customs, translations, restaurants, and travel tips.';

  @override
  String get tripAlbumsFeatureDescription =>
      'Capture and organize your travel memories with photos and albums.';

  @override
  String get emergencySupportDescription =>
      'Access emergency contacts, quick phrases, and safety tips for any situation.';

  @override
  String get smartTips => 'Smart Tips';

  @override
  String get smartTipsDescription =>
      'Get personalized travel suggestions for your plans and destination.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get welcomeToSMate => 'Welcome to S-Mate';

  @override
  String get introSubtitle =>
      'Your intelligent companion for discovering, planning, and experiencing unforgettable journeys';

  @override
  String get smartItineraries => 'Smart itineraries';

  @override
  String get exploreDestinations => 'Explore destinations';

  @override
  String get instantAnswers => 'Instant answers';

  @override
  String get saveMemories => 'Save memories';

  @override
  String get localLaws => 'Local Laws';

  @override
  String get staySafe => 'Stay safe';

  @override
  String get personalized => 'Personalized';

  @override
  String get learnMore => 'Learn More';

  @override
  String get copyright => '© 2026 S-Mate. All rights reserved.';

  @override
  String validationRequiredField(String fieldName) {
    return 'Please enter $fieldName';
  }

  @override
  String get validationEmailRequired => 'Please enter your email';

  @override
  String get validationEmailInvalid => 'Enter a valid email address';

  @override
  String get validationPasswordRequired => 'Please enter your password';

  @override
  String validationPasswordMinLength(int min) {
    return 'Password must be at least $min characters';
  }

  @override
  String get validationPasswordTooLong => 'Password is too long';

  @override
  String get validationPasswordComplexity =>
      'Password must contain uppercase, number, and special character';

  @override
  String get validationConfirmPasswordRequired =>
      'Please confirm your password';

  @override
  String get validationPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String validationNumberInvalid(String fieldName) {
    return '$fieldName must be a valid number';
  }

  @override
  String validationNumberNegative(String fieldName) {
    return '$fieldName cannot be negative';
  }

  @override
  String validationMinLength(String fieldName, int min) {
    return '$fieldName must be at least $min characters';
  }

  @override
  String validationMaxLength(String fieldName, int max) {
    return '$fieldName must be less than $max characters';
  }

  @override
  String get validationPhoneRequired => 'Please enter phone number';

  @override
  String get validationPhoneInvalid => 'Invalid phone number';

  @override
  String get validationBudgetTooLow => 'Budget too low';

  @override
  String get validationUsernameRequired => 'Please enter username';

  @override
  String validationUsernameMinLength(int min) {
    return 'Username must be at least $min characters';
  }

  @override
  String get validationUsernameTooLong => 'Username is too long';

  @override
  String get validationUsernameInvalid =>
      'Username can only contain letters, numbers, and underscore';

  @override
  String validationDescriptionMaxLength(int maxLength) {
    return 'Description must be less than $maxLength characters';
  }

  @override
  String get continueTrip => 'Continue Trip';
}
