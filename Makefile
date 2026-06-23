build:
	flutter build apk --release --obfuscate --split-debug-info=hamugay/symbols
	flutter build appbundle --release --obfuscate --split-debug-info=hamugay/symbols
