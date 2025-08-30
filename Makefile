.PHONY: help test test-unit test-widget test-integration test-coverage test-watch clean deps lint analyze format

# Default target
help:
	@echo "🧪 Taukeet Test Commands"
	@echo "========================"
	@echo ""
	@echo "Available commands:"
	@echo "  make test          - Run all tests"
	@echo "  make test-unit     - Run unit tests only"
	@echo "  make test-widget   - Run widget tests only" 
	@echo "  make test-integration - Run integration tests only"
	@echo "  make test-coverage - Run all tests with coverage"
	@echo "  make test-watch    - Run tests in watch mode"
	@echo "  make clean         - Clean build files"
	@echo "  make deps          - Get dependencies"
	@echo "  make lint          - Run linter"
	@echo "  make analyze       - Run static analysis"
	@echo "  make format        - Format code"
	@echo ""

# Test commands
test:
	@echo "🚀 Running all tests..."
	flutter test

test-unit:
	@echo "🧪 Running unit tests..."
	flutter test test/unit/

test-widget:
	@echo "🎨 Running widget tests..."
	flutter test test/widget/

test-integration:
	@echo "🔗 Running integration tests..."
	flutter test test/integration/

test-coverage:
	@echo "📊 Running tests with coverage..."
	flutter test --coverage
	@echo ""
	@echo "Coverage report generated in coverage/"
	@echo "To generate HTML report: genhtml coverage/lcov.info -o coverage/html"
	@echo "Then open: coverage/html/index.html"

test-watch:
	@echo "👀 Running tests in watch mode..."
	flutter test --watch

# Development commands
clean:
	@echo "🧹 Cleaning build files..."
	flutter clean
	flutter pub get

deps:
	@echo "📦 Getting dependencies..."
	flutter pub get

lint:
	@echo "🔍 Running linter..."
	flutter analyze

analyze:
	@echo "🔬 Running static analysis..."
	flutter analyze --fatal-infos

format:
	@echo "✨ Formatting code..."
	dart format lib/ test/

# Quick development workflow
dev-setup: deps
	@echo "🛠️  Setting up development environment..."
	@echo "✅ Dependencies installed"
	@echo "🧪 Running tests to verify setup..."
	@make test-unit

# CI/CD friendly commands
ci-test: deps analyze test-coverage
	@echo "✅ All CI checks passed!"

# Specific test files (examples)
test-entities:
	flutter test test/unit/entities/

test-providers:
	flutter test test/unit/providers/

test-services:
	flutter test test/unit/implementations/
