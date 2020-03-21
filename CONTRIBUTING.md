# Contributing

All contributors are welcome. Please use issues and pull requests to contribute to the project. And update [CHANGELOG.md](https://github.com/koznobikhin/OzStringKit/blob/master/CHANGELOG.md) when committing.

## Making a change

When you commit a change, please add a note to [CHANGELOG.md](https://github.com/koznobikhin/OzStringKit/blob/master/CHANGELOG.md).

## Release process

1. Confirm the build is [passing in travis](https://travis-ci.org/koznobikhin/OzStringKit)
   1. This automatically checks the Podfile is building
2. Push a release commit
   1. Create a new Master section at the top
   2. Rename the old Master section like:
          ## [1.0.5](https://github.com/koznobikhin/OzStringKit/releases/tag/1.0.5)
          Released on 2019-10-15.
   3. Update the Podspec version number
3. Create a GitHub release
   1. Tag the release (like `1.0.5`)
   2. Paste notes from [CHANGELOG.md](https://github.com/koznobikhin/OzStringKit/blob/master/CHANGELOG.md)
3. Push the Podspec to CocoaPods
   1. `pod trunk push`
