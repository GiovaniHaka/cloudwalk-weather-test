import 'package:cloudwalk/shared/services/languages/dictionary.dart';

/// Brazilian Portuguese dictionary
class BrazilianPortugueseDictionary implements Dictionary {
  const BrazilianPortugueseDictionary();

  @override
  String get helloWorld => 'Olá, Mundo!';

  @override
  String get failureMessage => 'Algo deu errado.';

  @override
  String get currentWeather => 'Clima Atual';

  @override
  String get buttonTryAgain => 'Tentar Novamente';

  @override
  String get concerts => 'Concertos';

  @override
  String get concert => 'Concerto';

  @override
  String get emptyConcerts => 'Por enquanto, não há concertos disponíveis.';

  @override
  String get hintSearchCity => 'Busque por cidade';

  @override
  String get toGetStartedChooseConcert =>
      'Para começar a experiência, escolha um concerto.';

  @override
  String get welcomeToCloudwalkWeather => 'Vamos de Cloudwalk';

  @override
  String get buttonChoose => 'Escolher';
  
  @override
  String get now => 'Agora';
}
