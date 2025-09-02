// Import all test files here to run them together
// This file can be used as an entry point for running all tests

// Unit Tests - Entities
import 'features/location/domain/entities/address_test.dart' as address_tests;
import 'features/prayer_times/domain/entities/adjustments_test.dart'
    as adjustments_tests;
import 'features/prayer_times/domain/entities/prayer_time_test.dart'
    as prayer_time_tests;

// Widget Tests
import 'shared/widgets/primary_button_test.dart' as primary_button_widget_tests;

void main() {
  // Entity Tests
  address_tests.main();
  adjustments_tests.main();
  prayer_time_tests.main();

  // Widget Tests
  primary_button_widget_tests.main();
}
