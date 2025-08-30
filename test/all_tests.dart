// Import all test files here to run them together
// This file can be used as an entry point for running all tests

// Unit Tests - Entities
import 'unit/entities/address_test.dart' as address_tests;
import 'unit/entities/adjustments_test.dart' as adjustments_tests;
import 'unit/entities/prayer_time_test.dart' as prayer_time_tests;

// Unit Tests - Implementations
import 'unit/implementations/adhan_impl_test.dart' as adhan_impl_tests;

// Unit Tests - Providers
import 'unit/providers/settings_provider_simple_test.dart' as settings_provider_tests;

// Widget Tests
import 'widget/widgets/primary_button_test.dart' as primary_button_widget_tests;

void main() {
  // Entity Tests
  address_tests.main();
  adjustments_tests.main();
  prayer_time_tests.main();

  // Implementation Tests
  adhan_impl_tests.main();

  // Provider Tests
  settings_provider_tests.main();

  // Widget Tests
  primary_button_widget_tests.main();
}
