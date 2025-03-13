.PHONY: help run profile release build build_release build_ios build_ios_simulator reset reset_ios gen_locale r p rl b br bi bis rs rsi gl

# Project setup
run: ## Run the app
	@flutter run

profile: ## Run the app in profile mode
	@flutter run --profile

release: ## Run the app in release mode
	@flutter run --release

build: ## Build the app
	@flutter build apk

build_release: ## Build the app in release mode
	@flutter build apk --release

build_ios: ## Build the app for iOS
	@flutter build ios

build_ios_simulator: ## Build the app for iOS simulator
	@flutter build ios --simulator

reset: ## Reset dependencies
	@flutter clean && flutter pub get

reset_ios: ## Reset iOS dependencies
	@cd ios && pod deintegrate && cd .. && flutter clean && flutter pub get && cd ios && pod install --repo-update && cd ..

deep_clean: ## Deep clean
	@flutter clean && flutter pub cache repair

gen_locale: ## Generate localization files
	@flutter gen-l10n

# Aliases
r: run ## Alias for run
p: profile ## Alias for profile
rl: release ## Alias for release
b: build ## Alias for build
br: build_release ## Alias for build_release
bi: build_ios ## Alias for build_ios
bis: build_ios_simulator ## Alias for build_ios_simulator
rs: reset ## Alias for reset
rsi: reset_ios ## Alias for reset_ios
d: deep_clean ## Alias for deep_clean
gl: gen_locale ## Alias for gen_locale

# Help command
help:
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'