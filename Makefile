
# Code Generation
generate_code:
	flutter packages pub run build_runner build --delete-conflicting-outputs

# Code Generation continuously
watch_generate_code:
	flutter packages pub run build_runner watch --delete-conflicting-outputs
