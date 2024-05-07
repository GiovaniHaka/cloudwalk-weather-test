import 'package:cloudwalk/shared/services/languages/dictionary.dart';

/// [EnglishDictionary] implements the [Dictionary] to provide the English language.
class EnglishDictionary implements Dictionary {
  const EnglishDictionary();

  @override
  String get helloWorld => 'Hello, World!';

  @override
  String get failureMessage => 'Something went wrong.';

  @override
  String get currentWeather => 'Current Weather';

  @override
  String get buttonTryAgain => 'Try Again';

  @override
  String get concerts => 'Concerts';

  @override
  String get concert => 'Concert';

  @override
  String get emptyConcerts => 'No concerts available at the moment.';

  @override
  String get hintSearchCity => 'Search by city';

  @override
  String get toGetStartedChooseConcert =>
      'To get started, choose a concert.';

  @override
  String get welcomeToCloudwalkWeather => 'Let\'s go with Cloudwalk';

  @override
  String get buttonChoose => 'Choose';

  @override
  String get now => 'Now';

  @override
  String get noneConnection => 'No connection';

  @override
  String get verifyYourConnection =>
      'It seems that you are not connected to the internet. Please check your connection and try again.';

  @override
  String get lastUpdate => 'Last update';

  @override
  String get today => 'Today';

  @override
  String get noLocalWeatherData => 'No local weather data.';

  @override
  String get connectToInternetAndTryAgain => 'Connect to the internet and try again.';
}
