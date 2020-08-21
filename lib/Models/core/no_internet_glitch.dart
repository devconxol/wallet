import 'package:wallet/models/core/glitch.dart';

class NoInternetGlitch extends Glitch {
  NoInternetGlitch()
      : super(message: "Veillez vérifier votre connection internet");
}
