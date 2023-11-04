import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/features/people/models/person_image.dart';
import 'package:movies_app/features/people/providers/person_images_provider.dart';
import 'package:movies_app/features/people/repositories/people_repository.dart';
import 'package:movies_app/features/tmdb-configs/providers/tmdb_configs_provider.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';
import '../../../test-utils/dummy-data/dummy_people.dart';
import '../../../test-utils/mocks.dart';

void main() {
  final PeopleRepository mockPeopleRepository = MockPeopleRepository();

  setUp(() {
    when(
      () => mockPeopleRepository.getPersonImages(
        DummyPeople.person1.id!,
        forceRefresh: false,
        imageConfigs: DummyConfigs.imageConfigs,
      ),
    ).thenAnswer((_) async => DummyPeople.personImages);
  });

  test('fetches paginated popular people', () async {
    final personImagesListener = Listener<AsyncValue<List<PersonImage>>>();

    final providerContainer = ProviderContainer(
      overrides: [
        peopleRepositoryProvider.overrideWithValue(mockPeopleRepository),
        tmdbConfigsProvider.overrideWithProvider(dummyTmdbConfigsProvider),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen<AsyncValue<List<PersonImage>>>(
      personImagesProvider(DummyPeople.person1.id!),
      personImagesListener,
      fireImmediately: true,
    );

    // Perform first reading, expects loading state
    final firstReading =
        providerContainer.read(personImagesProvider(DummyPeople.person1.id!));
    expect(firstReading, const AsyncValue<List<PersonImage>>.loading());

    // Listener was fired from `null` to loading AsyncValue
    verify(
      () => personImagesListener(
        null,
        const AsyncValue<List<PersonImage>>.loading(),
      ),
    ).called(1);

    // Perform second reading, by waiting for the request, expects fetched data
    final secondReading = await providerContainer
        .read(personImagesProvider(DummyPeople.person1.id!).future);
    expect(secondReading, DummyPeople.personImages);

    // Listener was fired from loading to fetched values
    verify(
      () => personImagesListener(
        const AsyncValue<List<PersonImage>>.loading(),
        AsyncValue<List<PersonImage>>.data(DummyPeople.personImages),
      ),
    ).called(1);

    // No more further listener events fired
    verifyNoMoreInteractions(personImagesListener);
  });
}
