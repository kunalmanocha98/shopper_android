
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

setupLocator(){
  locator.registerSingletonAsync(() async=> await SharedPreferences.getInstance());
}