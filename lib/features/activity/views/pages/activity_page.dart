import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/activity.dart';
import '../../providers/activity_provider.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<Activity> activity = ref.watch(activityProvider);
          return Center(

              /// Since network-requests are asynchronous and can fail, we need to
              /// handle both error and loading states. We can use pattern matching for this.
              /// We could alternatively use `if (activity.isLoading) { ... } else if (...)`
              child: activity.when(
                  data: (value) => Text('Activity: ${value.activity}'),
                  error: (e, st) =>
                      const Text('Oops, something unexpected happened'),
                  loading: () => CircularProgressIndicator()));
        },
      ),
    );
  }
}
