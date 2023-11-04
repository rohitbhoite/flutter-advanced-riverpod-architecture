import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/features/people/models/person.dart';
import 'package:movies_app/features/people/providers/person_details_provider.dart';
import 'package:movies_app/features/people/views/pages/person_details_page.dart';

import '../../../../test-utils/dummy-data/dummy_people.dart';
import '../../../../test-utils/pump_app.dart';

void main() {
  testWidgets('renders ErrorView on error', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      PersonDetailsPage(
        personId: DummyPeople.person1.id!,
        personName: DummyPeople.person1.name,
        personAvatar: null,
        personGender: DummyPeople.person1.gender,
      ),
      overrides: [
        personDetailsProvider(DummyPeople.person1.id!).overrideWithProvider(
          FutureProvider<Person>(
            (ref) => throw Exception(),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets('renders person details', (WidgetTester tester) async {
    await tester.pumpProviderApp(
      PersonDetailsPage(
        personId: DummyPeople.person1.id!,
        personName: DummyPeople.person1.name,
        personAvatar: null,
        personGender: DummyPeople.person1.gender,
      ),
      overrides: [
        personDetailsProvider(DummyPeople.person1.id!).overrideWithProvider(
          FutureProvider<Person>(
            (ref) async => Future.value(DummyPeople.person1),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();

    expect(find.text(DummyPeople.person1.knownForDepartment!), findsOneWidget);
  });
}
