# BOMFeedback

A general iOS feedback module, which helps to show most APP informations, get in contact with the user, promote positiv APP ratings and other stuff - think of it as a more elaborated but concise AboutMe dialog.

- Contact module with APP rating and share features including a FAQ
- APPs module with a (downloadable) list of other APPs of you or your liking
- About module with any information about the APP (copyright, history etc.)
- Modules provide legal information about the libraries used in your APP

Features so far:
- every module can be switched on/off in the config file
- selection of "sharing services" (APP Store rating deep link, email, twitter, facebook)
- every text output can be localized
- custom icon font for (tab bar) symbols, zero images used
- DarkMode for a dark-themed mode
- UIAppearance savvy
- runs modally or as a form sheet
- completely in AL with all-rotation support

# Compatibility

Tested and developed under iOS8, it should work under iOS7 as well. Dropping the SpriteKit gimmick BOMFeedback should be compatible down to maybe iOS5 from which I've ported this old module of mine over - but I won't test that anymore.

# Installation

Copy the `BOMFeedback` folder from the `niceapp` sample into your project (no pod jet). BOMFeedback is configured using a property list and uses localizations from different subfiles.

(documentation about config follows...)

# Version

Open features I'd like to integrate
- embed custom sub UIViewController into contact modul (i.e. for custom StoreKit support)
- detect and embed HockeySDK to provide true face2face feedback
- adopt push for UINavigationController
- downloadable FAQ list

# Contact

Oliver Michalak - [oliver@werk01.de](mailto:oliver@werk01.de) - [@omichde](http://twitter.com/omichde)

## Keywords

iOS, feedback, user, contact

## License

BOMFeedback is available under the MIT license:

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
