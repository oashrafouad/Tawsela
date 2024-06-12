import 'package:get_it/get_it.dart';
import 'package:tawsela_app/models/data_models/server.dart';

abstract class UserAPI {
  final String url = GetIt.instance.get<Server>().url;
}
