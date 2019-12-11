

import 'package:flutter_mvp/app/application.dart';
import 'package:flutter_mvp/net/network/api_service.dart';

import 'base_contract.dart';

class BaseModel implements IBaseModel {
  ApiService apiService = Application.getIt.get<ApiService>();
}