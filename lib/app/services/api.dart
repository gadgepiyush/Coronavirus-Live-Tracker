import 'package:flutter/foundation.dart';
import 'package:coronatracker/app/services/api_keys.dart';

class API{
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox()=> API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = 'https://ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
    scheme: 'https',
    host: host,
    path: 'token',
  );
}