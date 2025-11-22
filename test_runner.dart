import 'dart:io';

void main(List<String> args) async {
  print('🧪 Taukeet Test Runner');
  print('====================');

  // Parse command line arguments
  final runAll = args.isEmpty || args.contains('--all');
  final runUnit = args.contains('--unit') || runAll;
  final runWidget = args.contains('--widget') || runAll;
  final runIntegration = args.contains('--integration') || runAll;
  final coverage = args.contains('--coverage');
  final watch = args.contains('--watch');

  if (args.contains('--help') || args.contains('-h')) {
    printHelp();
    return;
  }

  // Get dependencies first
  print('📦 Getting dependencies...');
  var result = await Process.run('flutter', ['pub', 'get']);
  if (result.exitCode != 0) {
    print('❌ Failed to get dependencies');
    print(result.stderr);
    exit(1);
  }

  final List<String> testCommands = [];

  // Prepare test commands
  if (runUnit) {
    testCommands.add('test/unit/**/*_test.dart');
  }

  if (runWidget) {
    testCommands.add('test/widget/**/*_test.dart');
  }

  if (runIntegration) {
    testCommands.add('test/integration/**/*_test.dart');
  }

  if (testCommands.isEmpty) {
    print('⚠️  No test categories selected');
    printHelp();
    return;
  }

  // Build flutter test command
  final List<String> command = ['flutter', 'test'];

  if (coverage) {
    command.addAll(['--coverage']);
  }

  if (watch) {
    command.add('--watch');
  }

  // Add test paths
  command.addAll(testCommands);

  print('🚀 Running tests...');
  print('Command: ${command.join(' ')}');
  print('');

  // Run tests
  final testProcess = await Process.start(
    command.first,
    command.skip(1).toList(),
    mode: ProcessStartMode.inheritStdio,
  );

  final exitCode = await testProcess.exitCode;

  if (exitCode == 0) {
    print('');
    print('✅ All tests passed!');

    if (coverage) {
      print('📊 Coverage report generated in coverage/');
      print('   Run: genhtml coverage/lcov.info -o coverage/html');
      print('   Then open: coverage/html/index.html');
    }
  } else {
    print('');
    print('❌ Some tests failed');
    exit(exitCode);
  }
}

void printHelp() {
  print('''
Usage: dart test_runner.dart [options]

Options:
  --all           Run all tests (default)
  --unit          Run only unit tests
  --widget        Run only widget tests  
  --integration   Run only integration tests
  --coverage      Generate coverage report
  --watch         Watch mode - rerun tests on file changes
  --help, -h      Show this help message

Examples:
  dart test_runner.dart                    # Run all tests
  dart test_runner.dart --unit             # Run only unit tests
  dart test_runner.dart --coverage         # Run all tests with coverage
  dart test_runner.dart --unit --coverage  # Run unit tests with coverage
  dart test_runner.dart --watch            # Run in watch mode
  ''');
}
