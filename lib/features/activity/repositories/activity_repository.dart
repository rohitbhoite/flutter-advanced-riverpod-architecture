


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/services/http/http_service_provider.dart';
import 'package:movies_app/features/activity/models/activity.dart';

import 'package:movies_app/features/activity/repositories/http_activity_repository.dart';

final activityRepositoryProvider = Provider<ActivityRepository>(
      (ref) {
    final httpService = ref.watch(httpServiceProvider);

    return HttpActivityRepository(httpService);
  },
);

abstract class ActivityRepository {
  /// TMDB Base endpoint path for people requests
  ///
  /// See: https://developers.themoviedb.org/3/people
  String get path;
  /// Request to get a list of person images endpoint
  ///
  /// See: https://developers.themoviedb.org/3/people/get-person-images
  Future<Activity> getActivity();
}