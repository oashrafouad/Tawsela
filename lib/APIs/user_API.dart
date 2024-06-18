import 'package:get_it/get_it.dart';
import 'package:tawsela_app/models/passenger_bloc/server.dart';

abstract class UserAPI {
  final String url = GetIt.instance.get<Server>().url;
}
