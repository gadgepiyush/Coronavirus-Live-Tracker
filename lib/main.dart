import 'package:coronatracker/repositories/data_repositories.dart';
import 'package:coronatracker/services/api_service.dart';
import 'package:coronatracker/services/dataCache.dart';
import 'package:coronatracker/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/api.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_IN';
  await initializeDateFormatting();
  final sharedPreferenes = await SharedPreferences.getInstance();
  return runApp(MyApp(sharedPreferences: sharedPreferenes,));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  MyApp({@required this.sharedPreferences});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_)=>DataRepository(
          apiService: APIService(API.sandbox()),
          dataCacheService: DataCacheService(sharedPreferences: sharedPreferences),
      ),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222)
        ),
        home: DashBoard(),
      ),
    );
  }
}
