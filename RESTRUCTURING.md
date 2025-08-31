# 🏗️ Taukeet Architecture Migration Strategy

## Current State Analysis

### Current Structure
```
lib/src/
├── entities/           # ✅ Domain models (good)
├── services/           # ⚠️ Abstract interfaces (needs repositorization)
├── implementations/    # ⚠️ Concrete services (needs layering)
├── providers/          # ⚠️ State management (needs use cases)
├── screens/           # ⚠️ UI pages (needs feature grouping)
├── widgets/           # ⚠️ UI components (needs feature grouping)
├── utils/             # ⚠️ Mixed utilities (needs core organization)
├── exceptions/        # ⚠️ Error handling (needs core organization)
└── app.dart           # ✅ App configuration (good)
```

### Issues Identified
1. **No clear layer separation** - Business logic mixed with UI and data layers
2. **Monolithic structure** - All features mixed together
3. **Tight coupling** - Direct dependencies between layers
4. **No use cases** - Business logic scattered in providers
5. **Mixed responsibilities** - Utils and exceptions not properly organized

## Target Architecture

### Clean Architecture + Feature-Based Structure

```
lib/
├── main.dart
├── app/                          # Application layer
│   ├── app.dart                  # App widget configuration
│   ├── router/                   # Navigation configuration
│   │   ├── app_router.dart
│   │   └── route_paths.dart
│   └── theme/                    # App theming
│       ├── app_theme.dart
│       └── theme_constants.dart
├── core/                         # Shared core functionality
│   ├── constants/                # App-wide constants
│   │   ├── app_constants.dart
│   │   └── prayer_constants.dart
│   ├── errors/                   # Error handling
│   │   ├── failures.dart
│   │   ├── exceptions.dart
│   │   └── error_handler.dart
│   ├── network/                  # Network utilities
│   │   ├── network_info.dart
│   │   └── api_client.dart
│   ├── storage/                  # Local storage utilities
│   │   ├── storage_service.dart
│   │   └── cache_manager.dart
│   ├── utils/                    # Utility functions
│   │   ├── extensions.dart
│   │   ├── formatters.dart
│   │   └── validators.dart
│   ├── usecases/                 # Base use case classes
│   │   ├── usecase.dart
│   │   └── params.dart
│   └── di/                       # Dependency injection
│       └── injection.dart
├── features/                     # Feature modules
│   ├── prayer_times/            # Prayer times feature
│   │   ├── domain/              # Business logic layer
│   │   │   ├── entities/        # Domain models
│   │   │   │   ├── prayer_time.dart
│   │   │   │   ├── prayer_name.dart
│   │   │   │   └── adjustments.dart
│   │   │   ├── repositories/    # Repository interfaces
│   │   │   │   └── prayer_repository.dart
│   │   │   └── usecases/        # Business use cases
│   │   │       ├── get_prayer_times.dart
│   │   │       ├── get_current_prayer.dart
│   │   │       └── adjust_prayer_times.dart
│   │   ├── data/                # Data access layer
│   │   │   ├── datasources/     # Data sources
│   │   │   │   ├── prayer_local_datasource.dart
│   │   │   │   └── prayer_remote_datasource.dart
│   │   │   ├── models/          # Data transfer objects
│   │   │   │   ├── prayer_time_model.dart
│   │   │   │   └── adjustments_model.dart
│   │   │   └── repositories/    # Repository implementations
│   │   │       └── prayer_repository_impl.dart
│   │   └── presentation/        # UI layer
│   │       ├── providers/       # State management
│   │       │   ├── prayer_times_provider.dart
│   │       │   └── adjustments_provider.dart
│   │       ├── pages/           # Full-screen pages
│   │       │   ├── home_page.dart
│   │       │   └── adjustments_page.dart
│   │       └── widgets/         # Reusable components
│   │           ├── prayer_card.dart
│   │           ├── prayer_list.dart
│   │           └── time_adjuster.dart
│   ├── location/                # Location feature
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── address.dart
│   │   │   ├── repositories/
│   │   │   │   └── location_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_current_location.dart
│   │   │       └── get_address_from_coordinates.dart
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── location_local_datasource.dart
│   │   │   │   └── location_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── address_model.dart
│   │   │   └── repositories/
│   │   │       └── location_repository_impl.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── location_provider.dart
│   │       └── widgets/
│   │           └── location_selector.dart
│   ├── settings/                # Settings feature
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── settings.dart
│   │   │   ├── repositories/
│   │   │   │   └── settings_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_settings.dart
│   │   │       ├── update_settings.dart
│   │   │       └── reset_settings.dart
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── settings_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── settings_model.dart
│   │   │   └── repositories/
│   │   │       └── settings_repository_impl.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── settings_provider.dart
│   │       ├── pages/
│   │       │   └── settings_page.dart
│   │       └── widgets/
│   │           ├── setting_tile.dart
│   │           └── method_selector.dart
│   └── onboarding/              # Onboarding feature
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       └── presentation/
│           ├── providers/
│           ├── pages/
│           │   ├── splash_page.dart
│           │   └── intro_page.dart
│           └── widgets/
└── shared/                       # Shared UI components
    ├── widgets/                  # Common widgets
    │   ├── buttons/
    │   │   ├── primary_button.dart
    │   │   └── secondary_button.dart
    │   ├── dialogs/
    │   │   ├── selection_dialog.dart
    │   │   └── warning_dialog.dart
    │   └── inputs/
    │       └── text_form_input.dart
    ├── theme/                    # Theme utilities
    │   ├── colors.dart
    │   ├── typography.dart
    │   └── spacing.dart
    └── l10n/                     # Localization
        ├── l10n_constants.dart
        └── locale_helper.dart
```

## Migration Strategy

### Phase 1: Core Foundation (Week 1)
**Goal**: Establish core infrastructure without breaking existing functionality

#### Step 1.1: Create Core Structure
```bash
# Create new folder structure
mkdir -p lib/core/{constants,errors,network,storage,utils,usecases,di}
mkdir -p lib/app/{router,theme}
mkdir -p lib/shared/{widgets,theme,l10n}
```

#### Step 1.2: Move Core Utilities
```bash
# Move utilities to core
mv lib/src/utils/* lib/core/utils/
mv lib/src/exceptions/* lib/core/errors/
```

#### Step 1.3: Create Base Classes
- `core/usecases/usecase.dart` - Abstract use case class
- `core/errors/failures.dart` - Standardized error handling
- `core/constants/app_constants.dart` - App-wide constants

#### Step 1.4: Update Imports
- Update all existing files to use new core paths
- Test that everything still works

### Phase 2: Feature Structure Setup (Week 2)
**Goal**: Create feature-based folders and start moving entities

#### Step 2.1: Create Feature Folders
```bash
# Create feature structure
mkdir -p lib/features/prayer_times/{domain/{entities,repositories,usecases},data/{datasources,models,repositories},presentation/{providers,pages,widgets}}
mkdir -p lib/features/location/{domain/{entities,repositories,usecases},data/{datasources,models,repositories},presentation/{providers,widgets}}
mkdir -p lib/features/settings/{domain/{entities,repositories,usecases},data/{datasources,models,repositories},presentation/{providers,pages,widgets}}
mkdir -p lib/features/onboarding/{domain/{entities,repositories,usecases},data/{datasources,models,repositories},presentation/{providers,pages,widgets}}
```

#### Step 2.2: Move Entities to Features
```bash
# Move entities to appropriate features
mv lib/src/entities/prayer_time.dart lib/features/prayer_times/domain/entities/
mv lib/src/entities/prayer_name.dart lib/features/prayer_times/domain/entities/
mv lib/src/entities/adjustments.dart lib/features/prayer_times/domain/entities/
mv lib/src/entities/address.dart lib/features/location/domain/entities/
mv lib/src/entities/settings.dart lib/features/settings/domain/entities/
```

#### Step 2.3: Update Entity Imports
- Update all imports throughout the project
- Test that entities are accessible from new locations

### Phase 3: Repository Layer Implementation (Week 3)
**Goal**: Abstract data access behind repository interfaces

#### Step 3.1: Create Repository Interfaces
Create abstract repository classes in each feature's domain layer:

**Prayer Times Repository:**
```dart
// lib/features/prayer_times/domain/repositories/prayer_repository.dart
abstract class PrayerRepository {
  Future<List<PrayerTime>> getPrayerTimes(DateTime date, Address location);
  Future<PrayerTime> getCurrentPrayer(Address location);
  Future<void> savePrayerAdjustments(Adjustments adjustments);
}
```

#### Step 3.2: Implement Repository Concrete Classes
Move existing service implementations to repository implementations:
```dart
// lib/features/prayer_times/data/repositories/prayer_repository_impl.dart
class PrayerRepositoryImpl implements PrayerRepository {
  // Move AdhanImpl logic here
}
```

#### Step 3.3: Create Data Sources
Extract external dependencies (SharedPreferences, Location services) into data sources:
```dart
// lib/features/settings/data/datasources/settings_local_datasource.dart
abstract class SettingsLocalDataSource {
  Future<SettingsModel> getSettings();
  Future<void> saveSettings(SettingsModel settings);
}
```

### Phase 4: Use Cases Implementation (Week 4)
**Goal**: Extract business logic into dedicated use case classes

#### Step 4.1: Create Use Case Classes
```dart
// lib/features/prayer_times/domain/usecases/get_prayer_times.dart
class GetPrayerTimes extends UseCase<List<PrayerTime>, GetPrayerTimesParams> {
  final PrayerRepository repository;
  
  GetPrayerTimes(this.repository);
  
  @override
  Future<Either<Failure, List<PrayerTime>>> call(GetPrayerTimesParams params) async {
    // Business logic here
  }
}
```

#### Step 4.2: Extract Logic from Providers
Move business logic from providers to use cases:
- Prayer calculation logic → `GetPrayerTimes` use case
- Location fetching logic → `GetCurrentLocation` use case
- Settings management logic → `UpdateSettings` use case

#### Step 4.3: Update Providers to Use Use Cases
Refactor providers to call use cases instead of repositories directly:
```dart
class PrayerTimesProvider extends StateNotifier<PrayerTimesState> {
  final GetPrayerTimes getPrayerTimes;
  final GetCurrentPrayer getCurrentPrayer;
  
  // Use use cases in methods
}
```

### Phase 5: Presentation Layer Restructure (Week 5)
**Goal**: Move UI components to feature-specific presentation layers

#### Step 5.1: Move Screens to Feature Pages
```bash
# Move screens to appropriate features
mv lib/src/screens/home_screen.dart lib/features/prayer_times/presentation/pages/home_page.dart
mv lib/src/screens/settings_screen.dart lib/features/settings/presentation/pages/settings_page.dart
mv lib/src/screens/adjustments_screen.dart lib/features/prayer_times/presentation/pages/adjustments_page.dart
```

#### Step 5.2: Move Feature-Specific Widgets
```bash
# Move widgets to appropriate features or shared
# Feature-specific widgets go to feature/presentation/widgets/
# Generic widgets go to shared/widgets/
```

#### Step 5.3: Move Providers to Features
```bash
# Move providers to feature presentation layers
mv lib/src/providers/prayer_time_provider.dart lib/features/prayer_times/presentation/providers/
mv lib/src/providers/settings_provider.dart lib/features/settings/presentation/providers/
mv lib/src/providers/home_provider.dart lib/features/prayer_times/presentation/providers/
```

### Phase 6: Dependency Injection Setup (Week 6)
**Goal**: Implement proper dependency injection

#### Step 6.1: Add GetIt Dependency
```yaml
# pubspec.yaml
dependencies:
  get_it: ^7.6.0
  injectable: ^2.1.2

dev_dependencies:
  injectable_generator: ^2.1.6
  build_runner: ^2.4.6
```

#### Step 6.2: Setup Injection Container
```dart
// lib/core/di/injection.dart
final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
```

#### Step 6.3: Register Dependencies
- Repositories
- Use cases  
- Data sources
- External services

#### Step 6.4: Update Providers
Replace manual dependency creation with GetIt injection

## Implementation Details

### SOLID Principles Application

#### Single Responsibility Principle (SRP)
- **Use Cases**: Each use case handles one specific business operation
- **Repositories**: Each repository manages one data entity
- **Providers**: Each provider manages one piece of UI state
- **Widgets**: Each widget has one UI responsibility

#### Open/Closed Principle (OCP)
- **Repository Interfaces**: Open for extension, closed for modification
- **Use Case Base Class**: New use cases extend without changing base
- **Provider Structure**: New providers follow same pattern

#### Liskov Substitution Principle (LSP)
- **Repository Implementations**: Any implementation should be substitutable
- **Data Sources**: Local/Remote sources are interchangeable
- **Use Cases**: All use cases follow same contract

#### Interface Segregation Principle (ISP)
- **Repository Interfaces**: Specific to feature needs, not bloated
- **Data Source Interfaces**: Focused on specific data operations
- **Use Case Interfaces**: Single method contracts

#### Dependency Inversion Principle (DIP)
- **High-level modules depend on abstractions** (Repository interfaces)
- **Low-level modules implement abstractions** (Repository implementations)
- **Dependency injection** inverts control flow

### Testing Strategy Updates

#### Test Structure Alignment
```
test/
├── core/
│   ├── utils_test.dart
│   ├── constants_test.dart
│   └── errors_test.dart
├── features/
│   ├── prayer_times/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   └── usecases/
│   │   ├── data/
│   │   │   ├── repositories/
│   │   │   └── datasources/
│   │   └── presentation/
│   │       ├── providers/
│   │       └── widgets/
│   ├── location/
│   └── settings/
└── app/
    └── app_test.dart
```

#### Test Migration Strategy
1. **Keep existing tests working** during migration
2. **Gradually move tests** to match new structure
3. **Add new tests** for use cases and repositories
4. **Update mocks** to match new interfaces

## Benefits of New Architecture

### Development Benefits
- ✅ **Clear separation of concerns** - Each layer has specific responsibility
- ✅ **Feature isolation** - Work on features independently  
- ✅ **Easier testing** - Mock interfaces instead of implementations
- ✅ **Better maintainability** - Changes isolated to specific layers
- ✅ **Scalable structure** - Add new features without affecting existing ones

### Team Benefits  
- ✅ **Parallel development** - Multiple developers can work on different features
- ✅ **Consistent patterns** - Same structure across all features
- ✅ **Easy onboarding** - Clear architecture guidelines
- ✅ **Code reviews** - Focused on specific layers/features

### Technical Benefits
- ✅ **Testable code** - Dependencies injected and mockable
- ✅ **Reusable components** - Use cases can be reused across features
- ✅ **Performance** - Lazy loading of features possible
- ✅ **Hot reload friendly** - Changes don't break entire app

## Risk Mitigation

### Migration Risks & Solutions

#### Risk: Breaking Changes During Migration
**Solution**: 
- Migrate incrementally, one phase at a time
- Keep duplicate structures during transition
- Run tests after each phase

#### Risk: Import Hell
**Solution**:
- Use barrel exports (`index.dart` files)
- Create import aliases for commonly used paths
- Use IDE refactoring tools for bulk updates

#### Risk: Over-Engineering
**Solution**:
- Start with current features, don't add new complexity
- Focus on moving existing code to proper layers
- Add abstractions only where they provide clear value

#### Risk: Team Confusion
**Solution**:
- Document each migration step clearly
- Provide training on new architecture patterns  
- Create code examples and templates

## Next Steps

### Immediate Actions
1. **Review and approve** this migration strategy
2. **Set timeline** for each phase (suggested 6 weeks)
3. **Create feature branch** for migration work
4. **Start with Phase 1** - Core foundation

### Success Metrics
- ✅ All existing tests pass after each phase
- ✅ No breaking changes to existing functionality
- ✅ Improved code coverage with new testable structure
- ✅ Faster development velocity after migration complete

This migration will transform your Taukeet project into a professional, scalable, and maintainable codebase following industry best practices! 🚀
