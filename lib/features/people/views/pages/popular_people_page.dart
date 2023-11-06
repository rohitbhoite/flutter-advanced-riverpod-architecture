import 'package:flutter/material.dart';
import 'package:movies_app/features/activity/views/pages/activity_page.dart';
import 'package:movies_app/features/people/views/widgets/popular_people_app_bar.dart';
import 'package:movies_app/features/people/views/widgets/popular_people_list.dart';

/// Widget for the popular people page
class PopularPeoplePage extends StatelessWidget {
  /// Creates a new instance of [PopularPeoplePage]
  const PopularPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PopularPeopleAppBar(),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ActivityPage()));
        }, icon: Icon(Icons.info))],
      ),
      body: const PopularPeopleList(),
    );
  }
}
