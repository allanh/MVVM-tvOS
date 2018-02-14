#!/bin/bash -l
# Make a report directory
mkdir reports

# Run test with Xcode CLI xcodebuild
xcodebuild \
  -configuration Debug \
  -workspace PlayformTVOS.xcworkspace \
  -scheme PlayformTVOS \
  -enableCodeCoverage YES \
  -destination 'platform=tvOS Simulator,name=Apple TV 1080p' \
  ONLY_ACTIVE_ARCH=YES \
  test

# Convert profdatas to html format
slather coverage \
  --html \
  --output-directory reports \
  --scheme PlayformTVOS \
  --workspace PlayformTVOS.xcworkspace \
  PlayformTVOS.xcodeproj
