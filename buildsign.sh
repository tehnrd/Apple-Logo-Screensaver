#! /bin/bash

# Thank you...https://stackoverflow.com/questions/56307714/how-to-properly-codesign-macos-screensaver

. .env

# Run the build
xcodebuild

# Sign the build
codesign -f -o runtime --timestamp --sign "$KEYCHAIN_CERTNAME" "build/Release/Apple Logo.saver"

# Verify the signature
codesign -vvv --deep --strict "build/Release/Apple Logo.saver"

# Zip the build for notarization
(cd build/Release && zip -r "../Apple Logo.saver.zip" "Apple Logo.saver" && echo "First zip Successful" || echo "Zip FAILED")

# Submit to apple for notarization
xcrun notarytool submit "build/Apple Logo.saver.zip" --team-id $TEAM_ID --apple-id $APPLE_ID --password $APP_SPECIFIC_PASSWORD --wait

# # For debugging failed notarization
# # xcrun notarytool log --team-id $TEAM_ID --apple-id $APPLE_ID --password $APP_SPECIFIC_PASSWORD d5fasdfd-6db9-4e0c-b973-dff3ddfs2b57

# Attach the notarization ticket to the build files
xcrun stapler staple "build/Release/Apple Logo.saver"

# Re-zip the build for distribution
(cd build/Release && zip -r "../Apple Logo.saver.zip" "Apple Logo.saver" && echo "Final zip Successful" || echo "Zip FAILED")

# Clean up, delete all files except the released build zip
find build -type f ! -name "Apple Logo.saver.zip" -delete
find build -type d -empty -delete
