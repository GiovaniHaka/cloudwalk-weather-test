/// [Dictionary] is an abstract class that contains all the strings used in the application. 
/// This methodology is used to separate the strings from the code, making it easier to maintain and change them.
abstract class Dictionary {
  String get helloWorld;

  /// [Failures]
  String get failureMessage;
}