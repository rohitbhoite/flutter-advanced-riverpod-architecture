import 'dart:convert';
import 'package:movies_app/features/activity/repositories/activity_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/activity.dart';

// Necessary for code-generation to work
part 'activity_provider.g.dart';


@Riverpod()
Future<Activity> activity(ActivityRef ref) async {
  final activityRepository = ref.watch(activityRepositoryProvider);
  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  //final json = jsonDecode(response.body) as Map<String, dynamic>;
  // Finally, we convert the Map into an Activity instance.
  return activityRepository.getActivity();
}