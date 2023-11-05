


import 'dart:convert';

import 'package:movies_app/features/activity/models/activity.dart';
import 'package:movies_app/features/activity/repositories/activity_repository.dart';

import '../../../core/services/http/http_service.dart';

class HttpActivityRepository implements ActivityRepository {
  /// Creates a new instance of [HttpPeopleRepository]
  HttpActivityRepository(this.httpService);

  /// Http service used to access an Http client and make calls
  final HttpService httpService;

  @override
  Future<Activity> getActivity() async {
    final responseData = await httpService.get(
        Uri.https('boredapi.com', '/api/activity') as String
    );
    return Activity.fromJson(responseData);
  }

  @override
  // TODO: implement path
  String get path => throw UnimplementedError();
}
