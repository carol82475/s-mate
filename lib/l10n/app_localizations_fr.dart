// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get vietnam => 'Vietnam';

  @override
  String get appName => 'S-Mate';

  @override
  String get login => 'Connexion';

  @override
  String get register => 'Inscription';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get password => 'Mot de passe';

  @override
  String get home => 'Accueil';

  @override
  String get profile => 'Profil';

  @override
  String get tripPlanner => 'Planificateur de voyage';

  @override
  String get generateItinerary => 'Générer un itinéraire';

  @override
  String get destination => 'Destination';

  @override
  String get budget => 'Budget';

  @override
  String get peopleCount => 'Nombre de personnes';

  @override
  String get startDate => 'Date de début';

  @override
  String get endDate => 'Date de fin';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get logout => 'Déconnexion';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get loading => 'Chargement';

  @override
  String get error => 'Erreur';

  @override
  String get success => 'Succès';

  @override
  String get retry => 'Réessayer';

  @override
  String get myTrip => 'Mon voyage';

  @override
  String get scan => 'Scanner';

  @override
  String get map => 'Carte';

  @override
  String get aiChat => 'Chat IA';

  @override
  String get all => 'Tous';

  @override
  String get upcoming => 'À venir';

  @override
  String get inProgress => 'En cours';

  @override
  String get completed => 'Terminé';

  @override
  String get cancelled => 'Annulé';

  @override
  String get couldNotLoadTrips => 'Impossible de charger les voyages';

  @override
  String get couldNotLoadTripsMessage =>
      'Nous ne pouvons pas charger vos voyages pour le moment. Veuillez réessayer.';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get noTripsYet => 'Aucun voyage pour le moment';

  @override
  String get noTripsYetMessage =>
      'Créez votre premier itinéraire IA et il apparaîtra ici.';

  @override
  String get noTripsFoundForFilter => 'Aucun voyage trouvé pour ce filtre';

  @override
  String get createNewTrip => 'Créer un nouveau voyage';

  @override
  String get destinationPending => 'Destination en attente';

  @override
  String defaultTripName(Object destination) {
    return 'Voyage à $destination';
  }

  @override
  String budgetValue(Object value) {
    return 'Budget : $value';
  }

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Retour';

  @override
  String get create => 'Créer';

  @override
  String get update => 'Mettre à jour';

  @override
  String get edit => 'Modifier';

  @override
  String get done => 'Terminé';

  @override
  String get customize => 'Personnaliser';

  @override
  String get openMap => 'Ouvrir la carte';

  @override
  String get createTrip => 'Créer un voyage';

  @override
  String get welcomeBackTraveler => 'Bon retour, voyageur !';

  @override
  String get planNextAdventure => 'Planifiez votre prochaine aventure';

  @override
  String get itineraryReminder => 'Rappel d’itinéraire';

  @override
  String get nextActivitySoon => 'Votre prochaine activité arrive bientôt.';

  @override
  String get mapUpdate => 'Mise à jour de la carte';

  @override
  String get nearbyRecommendationsReady =>
      'Les recommandations à proximité sont prêtes à explorer.';

  @override
  String get albumReminder => 'Rappel d’album';

  @override
  String get addTodaysPhotos =>
      'Ajoutez les photos d’aujourd’hui à votre album de voyage.';

  @override
  String timeAgoHours(Object hours) {
    return 'il y a $hours h';
  }

  @override
  String timeAgoDays(Object days) {
    return 'il y a $days j';
  }

  @override
  String get planYourFirstTrip => 'Planifiez votre premier voyage';

  @override
  String get chooseDestination => 'Choisissez votre destination';

  @override
  String get newStatus => 'Nouveau';

  @override
  String get action => 'Action';

  @override
  String get generateTrip => 'Générer un voyage';

  @override
  String get generateTripDescription =>
      'Créez un nouvel itinéraire IA à partir de vos dates et de votre budget.';

  @override
  String get currentTrip => 'Voyage actuel';

  @override
  String get currentTrips => 'Voyages en cours';

  @override
  String get viewMyTrips => 'Voir mes voyages';

  @override
  String get viewItinerary => 'Voir l’itinéraire';

  @override
  String get popularDestinations => 'Destinations populaires';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get signInContinueJourney =>
      'Connectez-vous pour continuer votre voyage';

  @override
  String get signUpStartAdventure =>
      'Inscrivez-vous pour commencer à planifier votre prochaine aventure';

  @override
  String get loginSuccessful => 'Connexion réussie !';

  @override
  String get accountCreatedSuccessfully => 'Compte créé avec succès !';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordInstructions =>
      'Saisissez votre email et nous vous enverrons un lien de réinitialisation.';

  @override
  String get sendResetLink => 'Envoyer le lien';

  @override
  String get passwordResetOtpSent => 'OTP de réinitialisation envoyé !';

  @override
  String get fullName => 'Nom complet';

  @override
  String get fullNameHint => 'John Doe';

  @override
  String get location => 'Lieu';

  @override
  String get locationHint => 'San Francisco, USA';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get signUp => 'S’inscrire';

  @override
  String get dontHaveAccount => 'Vous n’avez pas de compte ? ';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ? ';

  @override
  String get yourName => 'votre nom';

  @override
  String get yourLocation => 'votre lieu';

  @override
  String get displayName => 'Nom affiché';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get profileUpdated => 'Profil mis à jour !';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get selectLanguage => 'Choisir la langue';

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
    return 'Langue changée en $language';
  }

  @override
  String get notificationsEnabled => 'Notifications activées';

  @override
  String get notificationsDisabled => 'Notifications désactivées';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get privacySetting => 'Paramètre de confidentialité';

  @override
  String privacySetTo(Object privacy) {
    return 'Confidentialité définie sur $privacy';
  }

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get passwordUpdatedSuccessfully =>
      'Mot de passe mis à jour avec succès !';

  @override
  String get updatePassword => 'Mettre à jour le mot de passe';

  @override
  String get failedSignOut => 'Échec de la déconnexion. Veuillez réessayer.';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get signOutConfirmation => 'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get traveler => 'Voyageur';

  @override
  String get unknown => 'Inconnu';

  @override
  String get unknownDestination => 'Destination inconnue';

  @override
  String get countries => 'Pays';

  @override
  String get trips => 'Voyages';

  @override
  String get locations => 'Lieux';

  @override
  String get days => 'Jours';

  @override
  String get tripHistory => 'Historique des voyages';

  @override
  String get enabled => 'Activé';

  @override
  String get disabled => 'Désactivé';

  @override
  String get public => 'Public';

  @override
  String get friendsOnly => 'Amis seulement';

  @override
  String get private => 'Privé';

  @override
  String get planned => 'Planifié';

  @override
  String get unknownTrip => 'Voyage inconnu';

  @override
  String get aiTripPlanner => 'Planificateur IA';

  @override
  String get planYourJourney => 'Planifiez votre trajet';

  @override
  String get aiCreatePerfectItinerary =>
      'Laissez l’IA créer l’itinéraire parfait';

  @override
  String get selectDate => 'Choisir une date';

  @override
  String get pleaseSelectDates =>
      'Veuillez choisir les dates de début et de fin';

  @override
  String get endDateAfterStartDate =>
      'La date de fin doit être après la date de début';

  @override
  String get tripGeneratedSuccessfully => 'Voyage généré avec succès !';

  @override
  String get generateTripFailed =>
      'Impossible de générer le voyage. Veuillez réessayer.';

  @override
  String get aiGeneratedTrip => 'Voyage généré par IA';

  @override
  String get fallbackItineraryUsed => 'Itinéraire de secours utilisé';

  @override
  String get budgetUsd => 'Budget (USD)';

  @override
  String get enterYourBudget => 'Saisissez votre budget';

  @override
  String get numberOfTravelers => 'Nombre de voyageurs';

  @override
  String get travelPreferences => 'Préférences de voyage';

  @override
  String get additionalPreferences => 'Préférences supplémentaires';

  @override
  String get additionalPreferencesHint =>
      'Dites-nous ce que vous aimez (p. ex. lieux cachés, marchés locaux, départs tardifs...)';

  @override
  String get generating => 'Génération...';

  @override
  String get generatingTrip => 'Génération du voyage...';

  @override
  String get generateAiItinerary => 'Générer l’itinéraire IA';

  @override
  String get soloTraveler => 'Solo (1 personne)';

  @override
  String get coupleTravelers => 'Couple (2 personnes)';

  @override
  String get smallGroupTravelers => 'Petit groupe (3-5)';

  @override
  String get largeGroupTravelers => 'Grand groupe (6+)';

  @override
  String get cultural => 'Culture';

  @override
  String get adventure => 'Aventure';

  @override
  String get relaxation => 'Détente';

  @override
  String get food => 'Cuisine';

  @override
  String get nature => 'Nature';

  @override
  String get shopping => 'Shopping';

  @override
  String get tripDay => 'Jour du voyage';

  @override
  String get tripItinerary => 'Itinéraire du voyage';

  @override
  String get tripSavedSuccessfully => 'Voyage enregistré avec succès !';

  @override
  String get newActivity => 'Nouvelle activité';

  @override
  String get customActivity => 'Activité personnalisée';

  @override
  String get editDayTitle => 'Modifier le titre du jour';

  @override
  String get dayTitle => 'Titre du jour';

  @override
  String get previewYourPlan => 'Aperçu de votre plan';

  @override
  String get tripProgress => 'Progression du voyage';

  @override
  String completedCount(Object completed, Object total) {
    return '$completed/$total terminés';
  }

  @override
  String get confirmSavePlan => 'Confirmer et enregistrer le plan';

  @override
  String dayNumber(Object day) {
    return 'JOUR $day';
  }

  @override
  String get addActivity => 'Ajouter une activité';

  @override
  String get arrivalLocalDiscovery => 'Arrivée et découverte locale';

  @override
  String get cityLandmarkVisit => 'Visite d’un monument de la ville';

  @override
  String get localFoodExperience => 'Expérience culinaire locale';

  @override
  String get culturalSite => 'Site culturel';

  @override
  String get eveningWalk => 'Promenade du soir';

  @override
  String get adventureExploration => 'Aventure et exploration';

  @override
  String get morningExcursion => 'Excursion du matin';

  @override
  String get lunchBreak => 'Pause déjeuner';

  @override
  String get outdoorActivity => 'Activité en plein air';

  @override
  String get dinnerRelaxation => 'Dîner et détente';

  @override
  String get relaxedFinalDay => 'Dernier jour détendu';

  @override
  String get slowMorning => 'Matinée tranquille';

  @override
  String get souvenirShopping => 'Achat de souvenirs';

  @override
  String get finalPhotoSpot => 'Dernier point photo';

  @override
  String get exploringSaigon => 'Explorer Saigon';

  @override
  String get mockLandmarkDescription =>
      'Commencez votre voyage par un monument local célèbre.';

  @override
  String get mockFoodDescription =>
      'Goûtez une cuisine locale authentique près du centre-ville.';

  @override
  String get mockCulturalDescription =>
      'Visitez un musée, un temple ou une destination culturelle.';

  @override
  String get mockEveningDescription =>
      'Profitez de l’ambiance de la ville le soir.';

  @override
  String get mockExcursionDescription =>
      'Faites une courte sortie vers une attraction proche.';

  @override
  String get mockLunchDescription =>
      'Rechargez vos batteries dans un restaurant local recommandé.';

  @override
  String get mockOutdoorDescription =>
      'Explorez la nature, les marchés ou des trésors cachés.';

  @override
  String get mockDinnerDescription =>
      'Terminez la journée par un dîner détendu.';

  @override
  String get mockSlowMorningDescription =>
      'Commencez plus doucement avec un café ou un petit-déjeuner.';

  @override
  String get mockSouvenirDescription =>
      'Achetez des souvenirs ou visitez un marché local.';

  @override
  String get mockPhotoDescription =>
      'Capturez vos derniers souvenirs avant de partir.';

  @override
  String get scanDemoResult =>
      'Résultat de démonstration affiché jusqu’à ce que l’API de vérification des prix soit disponible.';

  @override
  String get estimatedLocalPrice => 'Prix local estimé';

  @override
  String get detectedPrice => 'Prix détecté';

  @override
  String get advice => 'Conseil';

  @override
  String get cameraPreview => 'Aperçu caméra';

  @override
  String get cameraPreviewHint =>
      'Visez un article, un reçu ou un prix de menu.';

  @override
  String get checkingPrice => 'Vérification du prix...';

  @override
  String get scanItemMenu => 'Scanner un article ou un menu';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get upload => 'Téléverser';

  @override
  String get priceCheckInfo =>
      'La vérification des prix compare les prix détectés aux fourchettes locales lorsque le scanner backend est connecté.';

  @override
  String get scannedItem => 'Article scanné';

  @override
  String get pending => 'En attente';

  @override
  String get unknownWarning => 'Inconnu';

  @override
  String get scanAdviceDefault =>
      'Comparez le prix avec une référence locale avant de payer.';

  @override
  String get menuItem => 'Article de menu';

  @override
  String get apiPending => 'API en attente';

  @override
  String get demo => 'Démo';

  @override
  String get scanBackendPending =>
      'Le backend du scanner n’est pas encore connecté. Utilisez cette interface comme future surface de résultat.';

  @override
  String get usingOfflinePlaces => 'Utilisation des lieux hors ligne.';

  @override
  String zoomPercent(Object percent) {
    return 'Zoom : $percent%';
  }

  @override
  String get centeringLocation => 'Centrage sur votre position...';

  @override
  String get searchPlaces => 'Rechercher des lieux...';

  @override
  String get mapExplorer => 'Explorateur de carte';

  @override
  String get myLocation => 'Ma position';

  @override
  String get search => 'Rechercher';

  @override
  String get zoomIn => 'Zoom avant';

  @override
  String get zoomOut => 'Zoom arrière';

  @override
  String get nearbyPlaces => 'Lieux à proximité';

  @override
  String foundCount(Object count) {
    return '$count trouvés';
  }

  @override
  String get noPlacesFound => 'Aucun lieu trouvé';

  @override
  String get place => 'Lieu';

  @override
  String get unknownPlace => 'Lieu inconnu';

  @override
  String get nearby => 'À proximité';

  @override
  String get coffeeShop => 'Café';

  @override
  String get vietnameseRestaurant => 'Restaurant vietnamien';

  @override
  String get market => 'Marché';

  @override
  String get aiTravelAssistant => 'Assistant de voyage IA';

  @override
  String get alwaysHereToHelp => 'Toujours là pour aider';

  @override
  String get askMeAnything => 'Demandez-moi n’importe quoi...';

  @override
  String get suggestedQuestions => 'Questions suggérées';

  @override
  String get assistantGreeting =>
      'Bonjour ! Je suis votre assistant de voyage IA. Je peux vous aider avec des recommandations locales, des traductions, des conseils culturels et des questions de voyage. Comment puis-je vous aider aujourd’hui ?';

  @override
  String get assistantFallback =>
      'Je peux vous aider avec cela. Pouvez-vous donner plus de détails ?';

  @override
  String get assistantConnectionError =>
      'Désolé, je n’ai pas pu me connecter à l’assistant IA.';

  @override
  String get suggestionBestTimeHaLong =>
      'Quelle est la meilleure période pour visiter Ha Long Bay ?';

  @override
  String get suggestionVietnameseRestaurants =>
      'Recommandez des restaurants vietnamiens authentiques';

  @override
  String get suggestionHanoiToSapa => 'Comment aller de Hanoi à Sapa ?';

  @override
  String get suggestionLocalCustoms =>
      'Quelles coutumes locales devrais-je connaître ?';

  @override
  String get completeYourPurchase => 'Finaliser votre achat';

  @override
  String get paymentInformation => 'Informations de paiement';

  @override
  String get choosePlanUnlock =>
      'Choisissez un forfait et débloquez votre expérience de voyage personnalisée';

  @override
  String get mostPopular => 'Le plus populaire';

  @override
  String get perTrip => ' /voyage';

  @override
  String get selected => 'Sélectionné';

  @override
  String get selectPlan => 'Choisir le forfait';

  @override
  String continueToPayment(Object price) {
    return 'Continuer vers le paiement - $price';
  }

  @override
  String get purchaseSuccessful => 'Achat réussi !';

  @override
  String get planActiveEnjoyTrip =>
      'Votre forfait est maintenant actif. Bon voyage !';

  @override
  String get openItinerary => 'Ouvrir l’itinéraire';

  @override
  String get goToHome => 'Aller à l’accueil';

  @override
  String get required => 'Obligatoire';

  @override
  String get cardNumber => 'Numéro de carte';

  @override
  String get cardholderName => 'Nom du titulaire';

  @override
  String get cardholderNameHint => 'John Doe';

  @override
  String get expiryDate => 'Date d’expiration';

  @override
  String get expiryDateHint => 'MM/YY';

  @override
  String get cvv => 'CVV';

  @override
  String get demoPaymentWarning =>
      'Ceci est un paiement de démonstration. N’entrez pas de vraies informations de carte.';

  @override
  String get processing => 'Traitement...';

  @override
  String completePurchase(Object price) {
    return 'Finaliser l’achat - $price';
  }

  @override
  String get basicPlan => 'Forfait de base';

  @override
  String get premiumPlan => 'Forfait Premium';

  @override
  String get proPlan => 'Forfait Pro';

  @override
  String get sevenDays => '7 jours';

  @override
  String get fourteenDays => '14 jours';

  @override
  String get thirtyDays => '30 jours';

  @override
  String get unlimitedPlanning => 'Planification illimitée';

  @override
  String get fullMapAccess => 'Accès complet à la carte';

  @override
  String get smartAiSuggestions => 'Suggestions IA intelligentes';

  @override
  String get premiumFeatures => 'Fonctionnalités premium';

  @override
  String get prioritySupport => 'Support prioritaire';

  @override
  String get plan => 'Forfait';

  @override
  String get tripAlbums => 'Albums de voyage';

  @override
  String get newAlbum => 'Nouvel album';

  @override
  String get createNewAlbum => 'Créer un nouvel album';

  @override
  String get albumName => 'Nom de l’album';

  @override
  String get albumNameHint => 'p. ex., Aventures à Hanoi';

  @override
  String get description => 'Description';

  @override
  String get publicAlbum => 'Album public';

  @override
  String get albumCreated => 'Album créé !';

  @override
  String get noAlbumsYet => 'Aucun album pour le moment';

  @override
  String get createFirstAlbum => 'Créez votre premier album';

  @override
  String get createAlbum => 'Créer un album';

  @override
  String get untitledAlbum => 'Album sans titre';

  @override
  String get tripCamera => 'Caméra de voyage';

  @override
  String get savePhoto => 'Enregistrer la photo';

  @override
  String get caption => 'Légende';

  @override
  String get captionHint => 'Écrivez quelque chose à propos de cette photo...';

  @override
  String get photoLocationHint => 'p. ex., Da Lat, Vietnam';

  @override
  String get cameraSource => 'caméra';

  @override
  String get gallerySource => 'galerie';

  @override
  String get mustLoginUploadPhotos =>
      'Vous devez vous connecter avant de téléverser des photos.';

  @override
  String get photoReadyUploadUnavailable =>
      'Photo prête. Le téléversement backend n’est pas encore disponible.';

  @override
  String get photoSaveFailed =>
      'La photo n’a pas pu être enregistrée. Veuillez réessayer.';

  @override
  String photoSaveFailedWithMessage(Object message) {
    return 'La photo n’a pas pu être enregistrée : $message';
  }

  @override
  String tripCameraPermissionDenied(Object source) {
    return 'Autorisation refusée. Veuillez autoriser l’accès à $source et réessayer.';
  }

  @override
  String couldNotOpenSource(Object source, Object message) {
    return 'Impossible d’ouvrir $source. $message';
  }

  @override
  String get couldNotSelectPhoto =>
      'Impossible de sélectionner la photo. Veuillez réessayer.';

  @override
  String get viewAlbums => 'Voir les albums';

  @override
  String get readyCaptureMoment => 'Prêt à capturer le moment ?';

  @override
  String get tapOpenCamera => 'Appuyez ci-dessous pour ouvrir la caméra';

  @override
  String get openCamera => 'Ouvrir la caméra';

  @override
  String get uploadFromGallery => 'Téléverser depuis la galerie';

  @override
  String get photoUploadBackendInfo =>
      'Le téléversement de photos sera activé lorsque le backend ajoutera le stockage d’albums';

  @override
  String get emergencySupport => 'Assistance d’urgence';

  @override
  String playingPhrase(Object phrase) {
    return 'Lecture : $phrase';
  }

  @override
  String get quickTalk => 'Phrases rapides';

  @override
  String get emergencyContacts => 'Contacts d’urgence';

  @override
  String get emergency => 'Urgence';

  @override
  String get police => 'Police';

  @override
  String get fire => 'Pompiers';

  @override
  String get ambulance => 'Ambulance';

  @override
  String get general => 'Général';

  @override
  String get medical => 'Médical';

  @override
  String get incident => 'Incident';

  @override
  String get security => 'Sécurité';

  @override
  String get navigation => 'Navigation';

  @override
  String get communication => 'Communication';

  @override
  String get call => 'Appeler';

  @override
  String get quickTips => 'Conseils rapides';

  @override
  String get tipHotelAddress =>
      'Emportez toujours l’adresse de votre hôtel en vietnamien.';

  @override
  String get tipPhoneBattery =>
      'Vérifiez la batterie de votre téléphone avant de sortir.';

  @override
  String get tipSaveEmergencyContacts =>
      'Enregistrez les contacts d’urgence dans votre téléphone.';

  @override
  String get phraseHelpMe => 'Aidez-moi, s’il vous plaît !';

  @override
  String get phraseHospital => 'Où est l’hôpital le plus proche ?';

  @override
  String get phraseLostWalletPassport =>
      'J’ai perdu mon portefeuille/passeport.';

  @override
  String get phraseCallPolice => 'Je dois appeler la police.';

  @override
  String get phraseLost => 'Je suis perdu.';

  @override
  String get phraseSpeakEnglish => 'Parlez-vous anglais ?';

  @override
  String get aboutSMate => 'À propos de S-Mate';

  @override
  String get aboutSMateDescription =>
      'S-Mate est votre compagnon de voyage tout-en-un, conçu pour rendre chaque trajet fluide et mémorable.';

  @override
  String get aiTripPlanning => 'Planification de voyage IA';

  @override
  String get aiTripPlanningDescription =>
      'Générez des itinéraires personnalisés grâce à l’IA. Entrez simplement votre destination, vos dates et vos préférences.';

  @override
  String get interactiveMaps => 'Cartes interactives';

  @override
  String get interactiveMapsDescription =>
      'Explorez les destinations avec des cartes en temps réel, des lieux à proximité et une aide à la navigation.';

  @override
  String get assistant247 => 'Assistant IA 24/7';

  @override
  String get assistant247Description =>
      'Obtenez des réponses instantanées sur les coutumes locales, les traductions, les restaurants et les conseils de voyage.';

  @override
  String get tripAlbumsFeatureDescription =>
      'Capturez et organisez vos souvenirs de voyage avec des photos et des albums.';

  @override
  String get emergencySupportDescription =>
      'Accédez aux contacts d’urgence, aux phrases rapides et aux conseils de sécurité pour toute situation.';

  @override
  String get smartTips => 'Conseils intelligents';

  @override
  String get smartTipsDescription =>
      'Recevez des suggestions de voyage personnalisées pour vos plans et votre destination.';

  @override
  String get getStarted => 'Commencer';

  @override
  String get welcomeToSMate => 'Bienvenue sur S-Mate';

  @override
  String get introSubtitle =>
      'Votre compagnon intelligent pour découvrir, planifier et vivre des voyages inoubliables';

  @override
  String get smartItineraries => 'Itinéraires intelligents';

  @override
  String get exploreDestinations => 'Explorer les destinations';

  @override
  String get instantAnswers => 'Réponses instantanées';

  @override
  String get saveMemories => 'Sauver les souvenirs';

  @override
  String get localLaws => 'Lois locales';

  @override
  String get staySafe => 'Restez en sécurité';

  @override
  String get personalized => 'Personnalisé';

  @override
  String get learnMore => 'En savoir plus';

  @override
  String get copyright => '© 2026 S-Mate. Tous droits réservés.';

  @override
  String validationRequiredField(String fieldName) {
    return 'Veuillez saisir $fieldName';
  }

  @override
  String get validationEmailRequired => 'Veuillez saisir votre email';

  @override
  String get validationEmailInvalid => 'Saisissez une adresse email valide';

  @override
  String get validationPasswordRequired => 'Veuillez saisir votre mot de passe';

  @override
  String validationPasswordMinLength(int min) {
    return 'Le mot de passe doit contenir au moins $min caractères';
  }

  @override
  String get validationPasswordTooLong => 'Le mot de passe est trop long';

  @override
  String get validationPasswordComplexity =>
      'Le mot de passe doit contenir une majuscule, un chiffre et un caractère spécial';

  @override
  String get validationConfirmPasswordRequired =>
      'Veuillez confirmer votre mot de passe';

  @override
  String get validationPasswordsDoNotMatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String validationNumberInvalid(String fieldName) {
    return '$fieldName doit être un nombre valide';
  }

  @override
  String validationNumberNegative(String fieldName) {
    return '$fieldName ne peut pas être négatif';
  }

  @override
  String validationMinLength(String fieldName, int min) {
    return '$fieldName doit contenir au moins $min caractères';
  }

  @override
  String validationMaxLength(String fieldName, int max) {
    return '$fieldName doit contenir moins de $max caractères';
  }

  @override
  String get validationPhoneRequired =>
      'Veuillez saisir un numéro de téléphone';

  @override
  String get validationPhoneInvalid => 'Numéro de téléphone invalide';

  @override
  String get validationBudgetTooLow => 'Budget trop faible';

  @override
  String get validationUsernameRequired =>
      'Veuillez saisir un nom d’utilisateur';

  @override
  String validationUsernameMinLength(int min) {
    return 'Le nom d’utilisateur doit contenir au moins $min caractères';
  }

  @override
  String get validationUsernameTooLong => 'Le nom d’utilisateur est trop long';

  @override
  String get validationUsernameInvalid =>
      'Le nom d’utilisateur ne peut contenir que des lettres, des chiffres et un tiret bas';

  @override
  String validationDescriptionMaxLength(int maxLength) {
    return 'La description doit contenir moins de $maxLength caractères';
  }

  @override
  String get continueTrip => 'Continuer le voyage';
}
