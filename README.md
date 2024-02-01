# Flutter Boilerplate Project

A boilerplate project created in flutter using Bloc, Retrofit. Depend on code generation.

## Features

- State management and examples
- Api integration and examples
- Local database and examples
- Code generation
- Local storage
- Logging
- Routing
- Dependency Injection
- Crashlytics template
- DarkTheme
- Multi languages
- Unit tests
- Integration test
- Clean architecture
- Flutter CI

Some packages:

- [Freezed](https://pub.dev/packages/freezed)
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- [Flutter gen](https://pub.dev/packages/flutter_gen)
- [Retrofit](https://pub.dev/packages/retrofit)
- [Dio](https://pub.dev/packages/retrofit)
- [Bloc test](https://pub.dev/packages/bloc_test)
- [Mockito](https://pub.dev/packages/mockito)
- [Go router](https://pub.dev/packages/go_router)
- [Dependency Injection](https://github.com/fluttercommunity/get_it)
- [Logger](https://pub.dev/packages/logger)
- [Floor](https://pub.dev/packages/floor)
- [SharedPreferences](https://pub.dev/packages/shared_preferences)

## Getting Started

The Boilerplate contains the minimal implementation required to create a new library or project. The repository code is preloaded with some basic components like basic app architecture, app theme, constants and required dependencies to create a new project. By using boiler plate code as standard initializer, we can have same patterns in all the projects that will inherit it. This will also help in reducing setup & development time by allowing you to use same code pattern and avoid re-writing from scratch.

### Up-Coming Features:

- Handle multi bloc event in the same time by bloc concurrency example
- Load more infinite list using bloc example
- Authentication template

## Architecture

<img src="https://raw.githubusercontent.com/zeref278/flutter_boilerplate/main/readme_attach/architecture.png" width="700"/>

## How to Use

**Step 1:**

Fork, download or clone this repo by using the link below:

```
git clone https://github.com/hberkayozdemir/high_level_flutter_app_design.git
```

**Step 2:**
Go to project root and execute the following command in terminal to get the required dependencies and generate languages, freezed, flutter gen:

```cmd
melos bootstrap
melos i18n
melos generate
```

## Folder structure

```
flutter_boilerplate/
|- assets/                    (assets)
|- lib/
  |- configs/                 (flavor config)
  |- core/                    (bloc observer, theme,...)
  |- data/                    (repository)
  |- features/                (features page)
  |- generated/               (code generation includes localization and assets generation)
  |- injector/                (dependencies injector)
  |- l10n/                    (localization resources
  |- router/                  (routing)
  |- services/                (app services)
  |- utils/                   (app utils)
|- packages/
  |- rest_client/             (api client)
  |- local_database/          (local database)
|- integration_test
|- test/
  |- dependencies/                (mock dependencies)
  |- features/                (bloc test features)

```

## Mockito and Bloc tests:

If a bloc that you want to test have a required dependencies, you must add it into annotations `@GenerateMocks` in `/test/app_test/app_test.dart`:

```dart
@GenerateMocks([
  DogImageRandomRepository,
  LogService,

  /// TODO
])
void main() {}
```

Run the following command to generate a mock dependency

```cmd
flutter pub run build_runner build --delete-conflicting-outputs
```

Write a test file:

```dart
setUp(() {
    bloc = DogImageRandomBloc(
      dogImageRandomRepository: repository,
      logService: logService,
    );
  });

  group('test add event [DogImageRandomRandomRequested]', () {
    blocTest(
      'emit state when success',
      setUp: () {
        when(repository.getDogImageRandom())
            .thenAnswer((_) => Future<DogImage>.value(image));
      },
      build: () => bloc,
      act: (_) => bloc.add(
        const DogImageRandomRandomRequested(),
      ),
      expect: () => [
        isA<DogImageRandomState>().having(
          (state) => state.status,
          'status',
          UIStatus.loading,
        ),
        isA<DogImageRandomState>()
            .having(
              (state) => state.status,
              'status',
              UIStatus.loadSuccess,
            )
            .having(
              (state) => state.dogImage,
              'image',
              image,
            ),
      ],
    );

    blocTest(
      'emit state when failed',
      setUp: () {
        when(repository.getDogImageRandom()).thenThrow(Exception('error'));
      },
      build: () => bloc,
      seed: () => const DogImageRandomState(dogImage: image),
      act: (_) => bloc.add(
        const DogImageRandomRandomRequested(),
      ),
      expect: () => [
        isA<DogImageRandomState>().having(
          (state) => state.status,
          'status',
          UIStatus.loading,
        ),
        isA<DogImageRandomState>()
            .having(
              (state) => state.status,
              'status',
              UIStatus.actionFailed,
            )
            .having(
              (state) => state.dogImage,
              'image',
              image,
            ),
      ],
    );
  });
```

## Source

This project forked and upgraded from @zeref278:

```
https://github.com/zeref278/flutter_boilerplate.git
```
