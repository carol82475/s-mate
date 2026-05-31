import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('ko'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @vietnam.
  ///
  /// In en, this message translates to:
  /// **'Vietnam'**
  String get vietnam;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'S-Mate'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @tripPlanner.
  ///
  /// In en, this message translates to:
  /// **'Trip planner'**
  String get tripPlanner;

  /// No description provided for @generateItinerary.
  ///
  /// In en, this message translates to:
  /// **'Generate itinerary'**
  String get generateItinerary;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @peopleCount.
  ///
  /// In en, this message translates to:
  /// **'People count'**
  String get peopleCount;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get endDate;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @myTrip.
  ///
  /// In en, this message translates to:
  /// **'My Trip'**
  String get myTrip;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @aiChat.
  ///
  /// In en, this message translates to:
  /// **'AI Chat'**
  String get aiChat;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @couldNotLoadTrips.
  ///
  /// In en, this message translates to:
  /// **'Could not load trips'**
  String get couldNotLoadTrips;

  /// No description provided for @couldNotLoadTripsMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not load your trips right now. Please try again.'**
  String get couldNotLoadTripsMessage;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @noTripsYet.
  ///
  /// In en, this message translates to:
  /// **'No trips yet'**
  String get noTripsYet;

  /// No description provided for @noTripsYetMessage.
  ///
  /// In en, this message translates to:
  /// **'Create your first AI itinerary and it will appear here.'**
  String get noTripsYetMessage;

  /// No description provided for @noTripsFoundForFilter.
  ///
  /// In en, this message translates to:
  /// **'No trips found for this filter'**
  String get noTripsFoundForFilter;

  /// No description provided for @createNewTrip.
  ///
  /// In en, this message translates to:
  /// **'Create New Trip'**
  String get createNewTrip;

  /// No description provided for @destinationPending.
  ///
  /// In en, this message translates to:
  /// **'Destination pending'**
  String get destinationPending;

  /// No description provided for @defaultTripName.
  ///
  /// In en, this message translates to:
  /// **'{destination} trip'**
  String defaultTripName(Object destination);

  /// No description provided for @budgetValue.
  ///
  /// In en, this message translates to:
  /// **'Budget: {value}'**
  String budgetValue(Object value);

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @customize.
  ///
  /// In en, this message translates to:
  /// **'Customize'**
  String get customize;

  /// No description provided for @openMap.
  ///
  /// In en, this message translates to:
  /// **'Open Map'**
  String get openMap;

  /// No description provided for @createTrip.
  ///
  /// In en, this message translates to:
  /// **'Create Trip'**
  String get createTrip;

  /// No description provided for @welcomeBackTraveler.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, Traveler!'**
  String get welcomeBackTraveler;

  /// No description provided for @planNextAdventure.
  ///
  /// In en, this message translates to:
  /// **'Plan your next adventure'**
  String get planNextAdventure;

  /// No description provided for @itineraryReminder.
  ///
  /// In en, this message translates to:
  /// **'Itinerary Reminder'**
  String get itineraryReminder;

  /// No description provided for @nextActivitySoon.
  ///
  /// In en, this message translates to:
  /// **'Your next activity is coming soon.'**
  String get nextActivitySoon;

  /// No description provided for @mapUpdate.
  ///
  /// In en, this message translates to:
  /// **'Map Update'**
  String get mapUpdate;

  /// No description provided for @nearbyRecommendationsReady.
  ///
  /// In en, this message translates to:
  /// **'Nearby recommendations are ready to explore.'**
  String get nearbyRecommendationsReady;

  /// No description provided for @albumReminder.
  ///
  /// In en, this message translates to:
  /// **'Album Reminder'**
  String get albumReminder;

  /// No description provided for @addTodaysPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add today\'s photos to your trip album.'**
  String get addTodaysPhotos;

  /// No description provided for @timeAgoHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String timeAgoHours(Object hours);

  /// No description provided for @timeAgoDays.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String timeAgoDays(Object days);

  /// No description provided for @planYourFirstTrip.
  ///
  /// In en, this message translates to:
  /// **'Plan Your First Trip'**
  String get planYourFirstTrip;

  /// No description provided for @chooseDestination.
  ///
  /// In en, this message translates to:
  /// **'Choose your destination'**
  String get chooseDestination;

  /// No description provided for @newStatus.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newStatus;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @generateTrip.
  ///
  /// In en, this message translates to:
  /// **'Generate Trip'**
  String get generateTrip;

  /// No description provided for @generateTripDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a new AI itinerary from your dates and budget.'**
  String get generateTripDescription;

  /// No description provided for @currentTrip.
  ///
  /// In en, this message translates to:
  /// **'Current Trip'**
  String get currentTrip;

  /// No description provided for @currentTrips.
  ///
  /// In en, this message translates to:
  /// **'Current Trips'**
  String get currentTrips;

  /// No description provided for @viewMyTrips.
  ///
  /// In en, this message translates to:
  /// **'View My Trips'**
  String get viewMyTrips;

  /// No description provided for @viewItinerary.
  ///
  /// In en, this message translates to:
  /// **'View Itinerary'**
  String get viewItinerary;

  /// No description provided for @popularDestinations.
  ///
  /// In en, this message translates to:
  /// **'Popular Destinations'**
  String get popularDestinations;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signInContinueJourney.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your journey'**
  String get signInContinueJourney;

  /// No description provided for @signUpStartAdventure.
  ///
  /// In en, this message translates to:
  /// **'Sign up to start planning your next adventure'**
  String get signUpStartAdventure;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccessful;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreatedSuccessfully;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we will send you a reset link.'**
  String get resetPasswordInstructions;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @passwordResetOtpSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset OTP sent!'**
  String get passwordResetOtpSent;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get fullNameHint;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @locationHint.
  ///
  /// In en, this message translates to:
  /// **'San Francisco, USA'**
  String get locationHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'your name'**
  String get yourName;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'your location'**
  String get yourLocation;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated!'**
  String get profileUpdated;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageVietnamese.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get languageVietnamese;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get languageGerman;

  /// No description provided for @languageKorean.
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get languageKorean;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get languageChinese;

  /// No description provided for @languageChangedTo.
  ///
  /// In en, this message translates to:
  /// **'Language changed to {language}'**
  String languageChangedTo(Object language);

  /// No description provided for @notificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled'**
  String get notificationsEnabled;

  /// No description provided for @notificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications disabled'**
  String get notificationsDisabled;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacySetting.
  ///
  /// In en, this message translates to:
  /// **'Privacy Setting'**
  String get privacySetting;

  /// No description provided for @privacySetTo.
  ///
  /// In en, this message translates to:
  /// **'Privacy set to {privacy}'**
  String privacySetTo(Object privacy);

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @passwordUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully!'**
  String get passwordUpdatedSuccessfully;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @failedSignOut.
  ///
  /// In en, this message translates to:
  /// **'Failed to sign out. Please try again.'**
  String get failedSignOut;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @signOutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmation;

  /// No description provided for @traveler.
  ///
  /// In en, this message translates to:
  /// **'Traveler'**
  String get traveler;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @unknownDestination.
  ///
  /// In en, this message translates to:
  /// **'Unknown destination'**
  String get unknownDestination;

  /// No description provided for @countries.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get countries;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @locations.
  ///
  /// In en, this message translates to:
  /// **'Locations'**
  String get locations;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @tripHistory.
  ///
  /// In en, this message translates to:
  /// **'Trip History'**
  String get tripHistory;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @public.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get public;

  /// No description provided for @friendsOnly.
  ///
  /// In en, this message translates to:
  /// **'Friends Only'**
  String get friendsOnly;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @planned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get planned;

  /// No description provided for @unknownTrip.
  ///
  /// In en, this message translates to:
  /// **'Unknown trip'**
  String get unknownTrip;

  /// No description provided for @aiTripPlanner.
  ///
  /// In en, this message translates to:
  /// **'AI Trip Planner'**
  String get aiTripPlanner;

  /// No description provided for @planYourJourney.
  ///
  /// In en, this message translates to:
  /// **'Plan Your Journey'**
  String get planYourJourney;

  /// No description provided for @aiCreatePerfectItinerary.
  ///
  /// In en, this message translates to:
  /// **'Let AI create the perfect itinerary'**
  String get aiCreatePerfectItinerary;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @pleaseSelectDates.
  ///
  /// In en, this message translates to:
  /// **'Please select start and end dates'**
  String get pleaseSelectDates;

  /// No description provided for @endDateAfterStartDate.
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date'**
  String get endDateAfterStartDate;

  /// No description provided for @tripGeneratedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Trip generated successfully!'**
  String get tripGeneratedSuccessfully;

  /// No description provided for @generateTripFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not generate trip. Please try again.'**
  String get generateTripFailed;

  /// No description provided for @aiGeneratedTrip.
  ///
  /// In en, this message translates to:
  /// **'AI-generated trip'**
  String get aiGeneratedTrip;

  /// No description provided for @fallbackItineraryUsed.
  ///
  /// In en, this message translates to:
  /// **'Fallback itinerary used'**
  String get fallbackItineraryUsed;

  /// No description provided for @budgetUsd.
  ///
  /// In en, this message translates to:
  /// **'Budget (USD)'**
  String get budgetUsd;

  /// No description provided for @enterYourBudget.
  ///
  /// In en, this message translates to:
  /// **'Enter your budget'**
  String get enterYourBudget;

  /// No description provided for @numberOfTravelers.
  ///
  /// In en, this message translates to:
  /// **'Number of Travelers'**
  String get numberOfTravelers;

  /// No description provided for @travelPreferences.
  ///
  /// In en, this message translates to:
  /// **'Travel Preferences'**
  String get travelPreferences;

  /// No description provided for @additionalPreferences.
  ///
  /// In en, this message translates to:
  /// **'Additional Preferences'**
  String get additionalPreferences;

  /// No description provided for @additionalPreferencesHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us more about what you like (e.g., hidden gems, local markets, late starts...)'**
  String get additionalPreferencesHint;

  /// No description provided for @generating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get generating;

  /// No description provided for @generatingTrip.
  ///
  /// In en, this message translates to:
  /// **'Generating trip...'**
  String get generatingTrip;

  /// No description provided for @generateAiItinerary.
  ///
  /// In en, this message translates to:
  /// **'Generate AI Itinerary'**
  String get generateAiItinerary;

  /// No description provided for @soloTraveler.
  ///
  /// In en, this message translates to:
  /// **'Solo (1 person)'**
  String get soloTraveler;

  /// No description provided for @coupleTravelers.
  ///
  /// In en, this message translates to:
  /// **'Couple (2 people)'**
  String get coupleTravelers;

  /// No description provided for @smallGroupTravelers.
  ///
  /// In en, this message translates to:
  /// **'Small Group (3-5)'**
  String get smallGroupTravelers;

  /// No description provided for @largeGroupTravelers.
  ///
  /// In en, this message translates to:
  /// **'Large Group (6+)'**
  String get largeGroupTravelers;

  /// No description provided for @cultural.
  ///
  /// In en, this message translates to:
  /// **'Cultural'**
  String get cultural;

  /// No description provided for @adventure.
  ///
  /// In en, this message translates to:
  /// **'Adventure'**
  String get adventure;

  /// No description provided for @relaxation.
  ///
  /// In en, this message translates to:
  /// **'Relaxation'**
  String get relaxation;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get nature;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @tripDay.
  ///
  /// In en, this message translates to:
  /// **'Trip Day'**
  String get tripDay;

  /// No description provided for @tripItinerary.
  ///
  /// In en, this message translates to:
  /// **'Trip Itinerary'**
  String get tripItinerary;

  /// No description provided for @tripSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Trip saved successfully!'**
  String get tripSavedSuccessfully;

  /// No description provided for @newActivity.
  ///
  /// In en, this message translates to:
  /// **'New Activity'**
  String get newActivity;

  /// No description provided for @customActivity.
  ///
  /// In en, this message translates to:
  /// **'Custom activity'**
  String get customActivity;

  /// No description provided for @editDayTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Day Title'**
  String get editDayTitle;

  /// No description provided for @dayTitle.
  ///
  /// In en, this message translates to:
  /// **'Day title'**
  String get dayTitle;

  /// No description provided for @previewYourPlan.
  ///
  /// In en, this message translates to:
  /// **'Preview Your Plan'**
  String get previewYourPlan;

  /// No description provided for @tripProgress.
  ///
  /// In en, this message translates to:
  /// **'Trip Progress'**
  String get tripProgress;

  /// No description provided for @completedCount.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} completed'**
  String completedCount(Object completed, Object total);

  /// No description provided for @confirmSavePlan.
  ///
  /// In en, this message translates to:
  /// **'Confirm and Save Plan'**
  String get confirmSavePlan;

  /// No description provided for @dayNumber.
  ///
  /// In en, this message translates to:
  /// **'DAY {day}'**
  String dayNumber(Object day);

  /// No description provided for @addActivity.
  ///
  /// In en, this message translates to:
  /// **'Add Activity'**
  String get addActivity;

  /// No description provided for @arrivalLocalDiscovery.
  ///
  /// In en, this message translates to:
  /// **'Arrival & Local Discovery'**
  String get arrivalLocalDiscovery;

  /// No description provided for @cityLandmarkVisit.
  ///
  /// In en, this message translates to:
  /// **'City Landmark Visit'**
  String get cityLandmarkVisit;

  /// No description provided for @localFoodExperience.
  ///
  /// In en, this message translates to:
  /// **'Local Food Experience'**
  String get localFoodExperience;

  /// No description provided for @culturalSite.
  ///
  /// In en, this message translates to:
  /// **'Cultural Site'**
  String get culturalSite;

  /// No description provided for @eveningWalk.
  ///
  /// In en, this message translates to:
  /// **'Evening Walk'**
  String get eveningWalk;

  /// No description provided for @adventureExploration.
  ///
  /// In en, this message translates to:
  /// **'Adventure & Exploration'**
  String get adventureExploration;

  /// No description provided for @morningExcursion.
  ///
  /// In en, this message translates to:
  /// **'Morning Excursion'**
  String get morningExcursion;

  /// No description provided for @lunchBreak.
  ///
  /// In en, this message translates to:
  /// **'Lunch Break'**
  String get lunchBreak;

  /// No description provided for @outdoorActivity.
  ///
  /// In en, this message translates to:
  /// **'Outdoor Activity'**
  String get outdoorActivity;

  /// No description provided for @dinnerRelaxation.
  ///
  /// In en, this message translates to:
  /// **'Dinner & Relaxation'**
  String get dinnerRelaxation;

  /// No description provided for @relaxedFinalDay.
  ///
  /// In en, this message translates to:
  /// **'Relaxed Final Day'**
  String get relaxedFinalDay;

  /// No description provided for @slowMorning.
  ///
  /// In en, this message translates to:
  /// **'Slow Morning'**
  String get slowMorning;

  /// No description provided for @souvenirShopping.
  ///
  /// In en, this message translates to:
  /// **'Souvenir Shopping'**
  String get souvenirShopping;

  /// No description provided for @finalPhotoSpot.
  ///
  /// In en, this message translates to:
  /// **'Final Photo Spot'**
  String get finalPhotoSpot;

  /// No description provided for @exploringSaigon.
  ///
  /// In en, this message translates to:
  /// **'Exploring Saigon'**
  String get exploringSaigon;

  /// No description provided for @mockLandmarkDescription.
  ///
  /// In en, this message translates to:
  /// **'Start your trip with a famous local landmark.'**
  String get mockLandmarkDescription;

  /// No description provided for @mockFoodDescription.
  ///
  /// In en, this message translates to:
  /// **'Try authentic local food near the city center.'**
  String get mockFoodDescription;

  /// No description provided for @mockCulturalDescription.
  ///
  /// In en, this message translates to:
  /// **'Visit a museum, temple, or cultural destination.'**
  String get mockCulturalDescription;

  /// No description provided for @mockEveningDescription.
  ///
  /// In en, this message translates to:
  /// **'Enjoy the city atmosphere in the evening.'**
  String get mockEveningDescription;

  /// No description provided for @mockExcursionDescription.
  ///
  /// In en, this message translates to:
  /// **'Take a short trip to a nearby attraction.'**
  String get mockExcursionDescription;

  /// No description provided for @mockLunchDescription.
  ///
  /// In en, this message translates to:
  /// **'Recharge with a recommended local restaurant.'**
  String get mockLunchDescription;

  /// No description provided for @mockOutdoorDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore nature, markets, or hidden gems.'**
  String get mockOutdoorDescription;

  /// No description provided for @mockDinnerDescription.
  ///
  /// In en, this message translates to:
  /// **'End your day with a relaxing dinner.'**
  String get mockDinnerDescription;

  /// No description provided for @mockSlowMorningDescription.
  ///
  /// In en, this message translates to:
  /// **'Enjoy a slower start with coffee or breakfast.'**
  String get mockSlowMorningDescription;

  /// No description provided for @mockSouvenirDescription.
  ///
  /// In en, this message translates to:
  /// **'Buy souvenirs or visit a local market.'**
  String get mockSouvenirDescription;

  /// No description provided for @mockPhotoDescription.
  ///
  /// In en, this message translates to:
  /// **'Capture final memories before leaving.'**
  String get mockPhotoDescription;

  /// No description provided for @scanDemoResult.
  ///
  /// In en, this message translates to:
  /// **'Demo result shown until the price-check API is available.'**
  String get scanDemoResult;

  /// No description provided for @estimatedLocalPrice.
  ///
  /// In en, this message translates to:
  /// **'Estimated local price'**
  String get estimatedLocalPrice;

  /// No description provided for @detectedPrice.
  ///
  /// In en, this message translates to:
  /// **'Detected price'**
  String get detectedPrice;

  /// No description provided for @advice.
  ///
  /// In en, this message translates to:
  /// **'Advice'**
  String get advice;

  /// No description provided for @cameraPreview.
  ///
  /// In en, this message translates to:
  /// **'Camera preview'**
  String get cameraPreview;

  /// No description provided for @cameraPreviewHint.
  ///
  /// In en, this message translates to:
  /// **'Point at an item, receipt, or menu price.'**
  String get cameraPreviewHint;

  /// No description provided for @checkingPrice.
  ///
  /// In en, this message translates to:
  /// **'Checking Price...'**
  String get checkingPrice;

  /// No description provided for @scanItemMenu.
  ///
  /// In en, this message translates to:
  /// **'Scan Item or Menu'**
  String get scanItemMenu;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @priceCheckInfo.
  ///
  /// In en, this message translates to:
  /// **'Price check compares detected prices with local ranges when the backend scanner is connected.'**
  String get priceCheckInfo;

  /// No description provided for @scannedItem.
  ///
  /// In en, this message translates to:
  /// **'Scanned item'**
  String get scannedItem;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @unknownWarning.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownWarning;

  /// No description provided for @scanAdviceDefault.
  ///
  /// In en, this message translates to:
  /// **'Review the price with a local reference before paying.'**
  String get scanAdviceDefault;

  /// No description provided for @menuItem.
  ///
  /// In en, this message translates to:
  /// **'Menu item'**
  String get menuItem;

  /// No description provided for @apiPending.
  ///
  /// In en, this message translates to:
  /// **'API pending'**
  String get apiPending;

  /// No description provided for @demo.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get demo;

  /// No description provided for @scanBackendPending.
  ///
  /// In en, this message translates to:
  /// **'Scanner backend is not connected yet. Use this layout as the future result surface.'**
  String get scanBackendPending;

  /// No description provided for @usingOfflinePlaces.
  ///
  /// In en, this message translates to:
  /// **'Using offline places.'**
  String get usingOfflinePlaces;

  /// No description provided for @zoomPercent.
  ///
  /// In en, this message translates to:
  /// **'Zoom: {percent}%'**
  String zoomPercent(Object percent);

  /// No description provided for @centeringLocation.
  ///
  /// In en, this message translates to:
  /// **'Centering on your location...'**
  String get centeringLocation;

  /// No description provided for @searchPlaces.
  ///
  /// In en, this message translates to:
  /// **'Search places...'**
  String get searchPlaces;

  /// No description provided for @mapExplorer.
  ///
  /// In en, this message translates to:
  /// **'Map Explorer'**
  String get mapExplorer;

  /// No description provided for @myLocation.
  ///
  /// In en, this message translates to:
  /// **'My Location'**
  String get myLocation;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @zoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom In'**
  String get zoomIn;

  /// No description provided for @zoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom Out'**
  String get zoomOut;

  /// No description provided for @nearbyPlaces.
  ///
  /// In en, this message translates to:
  /// **'Nearby Places'**
  String get nearbyPlaces;

  /// No description provided for @foundCount.
  ///
  /// In en, this message translates to:
  /// **'{count} found'**
  String foundCount(Object count);

  /// No description provided for @noPlacesFound.
  ///
  /// In en, this message translates to:
  /// **'No places found'**
  String get noPlacesFound;

  /// No description provided for @place.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get place;

  /// No description provided for @unknownPlace.
  ///
  /// In en, this message translates to:
  /// **'Unknown Place'**
  String get unknownPlace;

  /// No description provided for @nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get nearby;

  /// No description provided for @coffeeShop.
  ///
  /// In en, this message translates to:
  /// **'Coffee Shop'**
  String get coffeeShop;

  /// No description provided for @vietnameseRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese Restaurant'**
  String get vietnameseRestaurant;

  /// No description provided for @market.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get market;

  /// No description provided for @aiTravelAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Travel Assistant'**
  String get aiTravelAssistant;

  /// No description provided for @alwaysHereToHelp.
  ///
  /// In en, this message translates to:
  /// **'Always here to help'**
  String get alwaysHereToHelp;

  /// No description provided for @askMeAnything.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything...'**
  String get askMeAnything;

  /// No description provided for @suggestedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Suggested Questions'**
  String get suggestedQuestions;

  /// No description provided for @assistantGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello! I\'m your AI travel assistant. I can help you with local recommendations, translations, cultural tips, and travel questions. How can I help you today?'**
  String get assistantGreeting;

  /// No description provided for @assistantFallback.
  ///
  /// In en, this message translates to:
  /// **'I can help with that. Can you provide more details?'**
  String get assistantFallback;

  /// No description provided for @assistantConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I could not connect to the AI assistant.'**
  String get assistantConnectionError;

  /// No description provided for @suggestionBestTimeHaLong.
  ///
  /// In en, this message translates to:
  /// **'What\'s the best time to visit Ha Long Bay?'**
  String get suggestionBestTimeHaLong;

  /// No description provided for @suggestionVietnameseRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Recommend authentic Vietnamese restaurants'**
  String get suggestionVietnameseRestaurants;

  /// No description provided for @suggestionHanoiToSapa.
  ///
  /// In en, this message translates to:
  /// **'How do I get from Hanoi to Sapa?'**
  String get suggestionHanoiToSapa;

  /// No description provided for @suggestionLocalCustoms.
  ///
  /// In en, this message translates to:
  /// **'What are local customs I should know?'**
  String get suggestionLocalCustoms;

  /// No description provided for @completeYourPurchase.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Purchase'**
  String get completeYourPurchase;

  /// No description provided for @paymentInformation.
  ///
  /// In en, this message translates to:
  /// **'Payment Information'**
  String get paymentInformation;

  /// No description provided for @choosePlanUnlock.
  ///
  /// In en, this message translates to:
  /// **'Choose a plan and unlock your personalized travel experience'**
  String get choosePlanUnlock;

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get mostPopular;

  /// No description provided for @perTrip.
  ///
  /// In en, this message translates to:
  /// **' /trip'**
  String get perTrip;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @selectPlan.
  ///
  /// In en, this message translates to:
  /// **'Select Plan'**
  String get selectPlan;

  /// No description provided for @continueToPayment.
  ///
  /// In en, this message translates to:
  /// **'Continue to Payment - {price}'**
  String continueToPayment(Object price);

  /// No description provided for @purchaseSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Purchase Successful!'**
  String get purchaseSuccessful;

  /// No description provided for @planActiveEnjoyTrip.
  ///
  /// In en, this message translates to:
  /// **'Your plan is now active. Enjoy your trip!'**
  String get planActiveEnjoyTrip;

  /// No description provided for @openItinerary.
  ///
  /// In en, this message translates to:
  /// **'Open Itinerary'**
  String get openItinerary;

  /// No description provided for @goToHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goToHome;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @cardholderName.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get cardholderName;

  /// No description provided for @cardholderNameHint.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get cardholderNameHint;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @expiryDateHint.
  ///
  /// In en, this message translates to:
  /// **'MM/YY'**
  String get expiryDateHint;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @demoPaymentWarning.
  ///
  /// In en, this message translates to:
  /// **'This is a demo payment. Do not enter real card information.'**
  String get demoPaymentWarning;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @completePurchase.
  ///
  /// In en, this message translates to:
  /// **'Complete Purchase - {price}'**
  String completePurchase(Object price);

  /// No description provided for @basicPlan.
  ///
  /// In en, this message translates to:
  /// **'Basic Plan'**
  String get basicPlan;

  /// No description provided for @premiumPlan.
  ///
  /// In en, this message translates to:
  /// **'Premium Plan'**
  String get premiumPlan;

  /// No description provided for @proPlan.
  ///
  /// In en, this message translates to:
  /// **'Pro Plan'**
  String get proPlan;

  /// No description provided for @sevenDays.
  ///
  /// In en, this message translates to:
  /// **'7 Days'**
  String get sevenDays;

  /// No description provided for @fourteenDays.
  ///
  /// In en, this message translates to:
  /// **'14 Days'**
  String get fourteenDays;

  /// No description provided for @thirtyDays.
  ///
  /// In en, this message translates to:
  /// **'30 Days'**
  String get thirtyDays;

  /// No description provided for @unlimitedPlanning.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Planning'**
  String get unlimitedPlanning;

  /// No description provided for @fullMapAccess.
  ///
  /// In en, this message translates to:
  /// **'Full Map Access'**
  String get fullMapAccess;

  /// No description provided for @smartAiSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Smart AI Suggestions'**
  String get smartAiSuggestions;

  /// No description provided for @premiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Premium Features'**
  String get premiumFeatures;

  /// No description provided for @prioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority Support'**
  String get prioritySupport;

  /// No description provided for @plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plan;

  /// No description provided for @tripAlbums.
  ///
  /// In en, this message translates to:
  /// **'Trip Albums'**
  String get tripAlbums;

  /// No description provided for @newAlbum.
  ///
  /// In en, this message translates to:
  /// **'New Album'**
  String get newAlbum;

  /// No description provided for @createNewAlbum.
  ///
  /// In en, this message translates to:
  /// **'Create New Album'**
  String get createNewAlbum;

  /// No description provided for @albumName.
  ///
  /// In en, this message translates to:
  /// **'Album Name'**
  String get albumName;

  /// No description provided for @albumNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Hanoi Adventures'**
  String get albumNameHint;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @publicAlbum.
  ///
  /// In en, this message translates to:
  /// **'Public Album'**
  String get publicAlbum;

  /// No description provided for @albumCreated.
  ///
  /// In en, this message translates to:
  /// **'Album created!'**
  String get albumCreated;

  /// No description provided for @noAlbumsYet.
  ///
  /// In en, this message translates to:
  /// **'No Albums Yet'**
  String get noAlbumsYet;

  /// No description provided for @createFirstAlbum.
  ///
  /// In en, this message translates to:
  /// **'Create your first album'**
  String get createFirstAlbum;

  /// No description provided for @createAlbum.
  ///
  /// In en, this message translates to:
  /// **'Create Album'**
  String get createAlbum;

  /// No description provided for @untitledAlbum.
  ///
  /// In en, this message translates to:
  /// **'Untitled Album'**
  String get untitledAlbum;

  /// No description provided for @tripCamera.
  ///
  /// In en, this message translates to:
  /// **'Trip Camera'**
  String get tripCamera;

  /// No description provided for @savePhoto.
  ///
  /// In en, this message translates to:
  /// **'Save Photo'**
  String get savePhoto;

  /// No description provided for @caption.
  ///
  /// In en, this message translates to:
  /// **'Caption'**
  String get caption;

  /// No description provided for @captionHint.
  ///
  /// In en, this message translates to:
  /// **'Write something about this photo...'**
  String get captionHint;

  /// No description provided for @photoLocationHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Da Lat, Vietnam'**
  String get photoLocationHint;

  /// No description provided for @cameraSource.
  ///
  /// In en, this message translates to:
  /// **'camera'**
  String get cameraSource;

  /// No description provided for @gallerySource.
  ///
  /// In en, this message translates to:
  /// **'gallery'**
  String get gallerySource;

  /// No description provided for @mustLoginUploadPhotos.
  ///
  /// In en, this message translates to:
  /// **'You must login before uploading photos.'**
  String get mustLoginUploadPhotos;

  /// No description provided for @photoReadyUploadUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Photo ready. Backend upload is not available yet.'**
  String get photoReadyUploadUnavailable;

  /// No description provided for @photoSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Photo could not be saved. Please try again.'**
  String get photoSaveFailed;

  /// No description provided for @photoSaveFailedWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Photo could not be saved: {message}'**
  String photoSaveFailedWithMessage(Object message);

  /// No description provided for @tripCameraPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied. Please allow {source} access and try again.'**
  String tripCameraPermissionDenied(Object source);

  /// No description provided for @couldNotOpenSource.
  ///
  /// In en, this message translates to:
  /// **'Could not open {source}. {message}'**
  String couldNotOpenSource(Object source, Object message);

  /// No description provided for @couldNotSelectPhoto.
  ///
  /// In en, this message translates to:
  /// **'Could not select photo. Please try again.'**
  String get couldNotSelectPhoto;

  /// No description provided for @viewAlbums.
  ///
  /// In en, this message translates to:
  /// **'View Albums'**
  String get viewAlbums;

  /// No description provided for @readyCaptureMoment.
  ///
  /// In en, this message translates to:
  /// **'Ready to capture the moment?'**
  String get readyCaptureMoment;

  /// No description provided for @tapOpenCamera.
  ///
  /// In en, this message translates to:
  /// **'Tap below to open your camera'**
  String get tapOpenCamera;

  /// No description provided for @openCamera.
  ///
  /// In en, this message translates to:
  /// **'Open Camera'**
  String get openCamera;

  /// No description provided for @uploadFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from Gallery'**
  String get uploadFromGallery;

  /// No description provided for @photoUploadBackendInfo.
  ///
  /// In en, this message translates to:
  /// **'Photo upload will be enabled when the backend adds album storage'**
  String get photoUploadBackendInfo;

  /// No description provided for @emergencySupport.
  ///
  /// In en, this message translates to:
  /// **'Emergency Support'**
  String get emergencySupport;

  /// No description provided for @playingPhrase.
  ///
  /// In en, this message translates to:
  /// **'Playing: {phrase}'**
  String playingPhrase(Object phrase);

  /// No description provided for @quickTalk.
  ///
  /// In en, this message translates to:
  /// **'Quick Talk'**
  String get quickTalk;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get emergencyContacts;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @police.
  ///
  /// In en, this message translates to:
  /// **'Police'**
  String get police;

  /// No description provided for @fire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get fire;

  /// No description provided for @ambulance.
  ///
  /// In en, this message translates to:
  /// **'Ambulance'**
  String get ambulance;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @medical.
  ///
  /// In en, this message translates to:
  /// **'Medical'**
  String get medical;

  /// No description provided for @incident.
  ///
  /// In en, this message translates to:
  /// **'Incident'**
  String get incident;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @navigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigation;

  /// No description provided for @communication.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get communication;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @quickTips.
  ///
  /// In en, this message translates to:
  /// **'Quick Tips'**
  String get quickTips;

  /// No description provided for @tipHotelAddress.
  ///
  /// In en, this message translates to:
  /// **'Always bring your hotel address in Vietnamese.'**
  String get tipHotelAddress;

  /// No description provided for @tipPhoneBattery.
  ///
  /// In en, this message translates to:
  /// **'Check your phone battery before going out.'**
  String get tipPhoneBattery;

  /// No description provided for @tipSaveEmergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Save emergency contacts in your phone.'**
  String get tipSaveEmergencyContacts;

  /// No description provided for @phraseHelpMe.
  ///
  /// In en, this message translates to:
  /// **'Please help me!'**
  String get phraseHelpMe;

  /// No description provided for @phraseHospital.
  ///
  /// In en, this message translates to:
  /// **'Where is the nearest hospital?'**
  String get phraseHospital;

  /// No description provided for @phraseLostWalletPassport.
  ///
  /// In en, this message translates to:
  /// **'I lost my wallet/passport.'**
  String get phraseLostWalletPassport;

  /// No description provided for @phraseCallPolice.
  ///
  /// In en, this message translates to:
  /// **'I need to call the police.'**
  String get phraseCallPolice;

  /// No description provided for @phraseLost.
  ///
  /// In en, this message translates to:
  /// **'I am lost.'**
  String get phraseLost;

  /// No description provided for @phraseSpeakEnglish.
  ///
  /// In en, this message translates to:
  /// **'Do you speak English?'**
  String get phraseSpeakEnglish;

  /// No description provided for @aboutSMate.
  ///
  /// In en, this message translates to:
  /// **'About S-Mate'**
  String get aboutSMate;

  /// No description provided for @aboutSMateDescription.
  ///
  /// In en, this message translates to:
  /// **'S-Mate is your all-in-one travel companion designed to make every journey seamless and memorable.'**
  String get aboutSMateDescription;

  /// No description provided for @aiTripPlanning.
  ///
  /// In en, this message translates to:
  /// **'AI Trip Planning'**
  String get aiTripPlanning;

  /// No description provided for @aiTripPlanningDescription.
  ///
  /// In en, this message translates to:
  /// **'Generate personalized itineraries powered by AI. Just enter your destination, dates, and preferences.'**
  String get aiTripPlanningDescription;

  /// No description provided for @interactiveMaps.
  ///
  /// In en, this message translates to:
  /// **'Interactive Maps'**
  String get interactiveMaps;

  /// No description provided for @interactiveMapsDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore destinations with real-time maps, nearby places, and navigation support.'**
  String get interactiveMapsDescription;

  /// No description provided for @assistant247.
  ///
  /// In en, this message translates to:
  /// **'24/7 AI Assistant'**
  String get assistant247;

  /// No description provided for @assistant247Description.
  ///
  /// In en, this message translates to:
  /// **'Get instant answers about local customs, translations, restaurants, and travel tips.'**
  String get assistant247Description;

  /// No description provided for @tripAlbumsFeatureDescription.
  ///
  /// In en, this message translates to:
  /// **'Capture and organize your travel memories with photos and albums.'**
  String get tripAlbumsFeatureDescription;

  /// No description provided for @emergencySupportDescription.
  ///
  /// In en, this message translates to:
  /// **'Access emergency contacts, quick phrases, and safety tips for any situation.'**
  String get emergencySupportDescription;

  /// No description provided for @smartTips.
  ///
  /// In en, this message translates to:
  /// **'Smart Tips'**
  String get smartTips;

  /// No description provided for @smartTipsDescription.
  ///
  /// In en, this message translates to:
  /// **'Get personalized travel suggestions for your plans and destination.'**
  String get smartTipsDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @welcomeToSMate.
  ///
  /// In en, this message translates to:
  /// **'Welcome to S-Mate'**
  String get welcomeToSMate;

  /// No description provided for @introSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your intelligent companion for discovering, planning, and experiencing unforgettable journeys'**
  String get introSubtitle;

  /// No description provided for @smartItineraries.
  ///
  /// In en, this message translates to:
  /// **'Smart itineraries'**
  String get smartItineraries;

  /// No description provided for @exploreDestinations.
  ///
  /// In en, this message translates to:
  /// **'Explore destinations'**
  String get exploreDestinations;

  /// No description provided for @instantAnswers.
  ///
  /// In en, this message translates to:
  /// **'Instant answers'**
  String get instantAnswers;

  /// No description provided for @saveMemories.
  ///
  /// In en, this message translates to:
  /// **'Save memories'**
  String get saveMemories;

  /// No description provided for @localLaws.
  ///
  /// In en, this message translates to:
  /// **'Local Laws'**
  String get localLaws;

  /// No description provided for @staySafe.
  ///
  /// In en, this message translates to:
  /// **'Stay safe'**
  String get staySafe;

  /// No description provided for @personalized.
  ///
  /// In en, this message translates to:
  /// **'Personalized'**
  String get personalized;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 S-Mate. All rights reserved.'**
  String get copyright;

  /// No description provided for @validationRequiredField.
  ///
  /// In en, this message translates to:
  /// **'Please enter {fieldName}'**
  String validationRequiredField(String fieldName);

  /// No description provided for @validationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get validationEmailRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get validationPasswordRequired;

  /// No description provided for @validationPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {min} characters'**
  String validationPasswordMinLength(int min);

  /// No description provided for @validationPasswordTooLong.
  ///
  /// In en, this message translates to:
  /// **'Password is too long'**
  String get validationPasswordTooLong;

  /// No description provided for @validationPasswordComplexity.
  ///
  /// In en, this message translates to:
  /// **'Password must contain uppercase, number, and special character'**
  String get validationPasswordComplexity;

  /// No description provided for @validationConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validationConfirmPasswordRequired;

  /// No description provided for @validationPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordsDoNotMatch;

  /// No description provided for @validationNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} must be a valid number'**
  String validationNumberInvalid(String fieldName);

  /// No description provided for @validationNumberNegative.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} cannot be negative'**
  String validationNumberNegative(String fieldName);

  /// No description provided for @validationMinLength.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} must be at least {min} characters'**
  String validationMinLength(String fieldName, int min);

  /// No description provided for @validationMaxLength.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} must be less than {max} characters'**
  String validationMaxLength(String fieldName, int max);

  /// No description provided for @validationPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get validationPhoneRequired;

  /// No description provided for @validationPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get validationPhoneInvalid;

  /// No description provided for @validationBudgetTooLow.
  ///
  /// In en, this message translates to:
  /// **'Budget too low'**
  String get validationBudgetTooLow;

  /// No description provided for @validationUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter username'**
  String get validationUsernameRequired;

  /// No description provided for @validationUsernameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least {min} characters'**
  String validationUsernameMinLength(int min);

  /// No description provided for @validationUsernameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Username is too long'**
  String get validationUsernameTooLong;

  /// No description provided for @validationUsernameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Username can only contain letters, numbers, and underscore'**
  String get validationUsernameInvalid;

  /// No description provided for @validationDescriptionMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Description must be less than {maxLength} characters'**
  String validationDescriptionMaxLength(int maxLength);

  /// No description provided for @continueTrip.
  ///
  /// In en, this message translates to:
  /// **'Continue Trip'**
  String get continueTrip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'fr',
        'ko',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ko':
      return AppLocalizationsKo();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
