/// [ConnectivityState] is an abstract class that represents the state of the connectivity.
abstract class ConnectivityState {}

/// [NoneConnection] is a class that represents the state of no connection.
class NoneConnection extends ConnectivityState {}

/// [MobileConnection] is a class that represents the state of a mobile connection.
class MobileConnection extends ConnectivityState {}

/// [WifiConnection] is a class that represents the state of a wifi connection.
class WifiConnection extends ConnectivityState {}