# BOMFeedback

A general iOS feedback modul, which helps to show most APP informations, get in contact with the user, promote positiv APP ratings and other stuff - think of it as a more elaborated but concise AboutMe dialog.

The idea behind this package is to free you as a developer from those tedious administrative areas within your APP (about, copyright, user contact) and at the same time motivate users to positive reviews: it starts with a simple question, wether the user like that APP (and hence could give a positiv review or like to share it) by providing a FAQ in case of problems or engage sharing in case they like it.

# Features

- every modul can be switched on/off in the config file
- selection of "sharing services" (APP Store rating deep link, email, twitter, facebook)
- every text output can be localized
- custom icon font for (tab bar) symbols, zero images used
- DarkMode for a dark-themed mode
- UIAppearance savvy
- runs modally or as a form sheet
- self-contained, no extra dependancies
- one storyboard, all AutoLayout, full rotation support

# Installation

Copy the `BOMFeedback` folder from the `niceapp` sample into your project (no pod jet). BOMFeedback is configured using a property list file and uses localizations from different subfiles.

# Documentation

`APPId` - the number of your APP in the APP store (123456789)
`ITMSURL` - the Link to your APP in the APP store (http://itunes.apple.com/de/app/id12345678?mt=8)
`WebURL` - the Link to your website for this APP (http://getniceapp.com)
`darkMode` - switch to use a dark mode, default NO, optional

## Contact modul

This is the core and initial modul. It simply starts with the question if the user likes the APP or not. In case he likes it, he'll be invited to submit a review in the APP store and/or share an APP link to others. In case there is a problem, a FAQ is displayed and an email button to get in contact with you.

`submodule` - classname of a custom subviewcontroller, optional. If you want to display further information about your APP in the contact modul or an APP store purchase restoring feature, this might be the right place.
`email` - email address to be used in the contact sheet (info@getniceapp.com)
`services` - comma separated list of services: store, email, twitter, facebook
`faq` - in case the user has a problem, a FAQ will be displayed which either comes locally  preinstalled or is loaded from your server
`faq/file` - local filename containing your FAQ, optional (FeedbackFAQ.plist)
`faq/URL`- remote URL to load the FAQ from, optional (http://getniceapp.com/faq.plist)
`faq/updateLimit` - update interval in days to fetch a FAQ update (7)

You have to either provide a local file for your FAQs or an URL + updateLimit where to load the FAQs from. For the latter, some GET parameters are sent as well:

`locale` - the locale of the APP
`src` - the CFBundleName of the APP

## APPs modul

This modul loads and displays a HTML page from your server. Your page should contain other APPs or recommendations of you.

`URL` - the URL to load (http://getallniceapps.com)

Following GET parameters are sent to the server:

`locale` - the locale of the APP
`src` - the CFBundleName of the APP

## About modul

A local and hence localized HTML page is displayed. It is a good idea the collect basic information about the APP and you in this page, maybe including address, copyright and APP history information.

`file` - the name of the HTML file to be displayed (FeedbackAbout.html)

## Modules modul

A small acknoledgement page to those who built frameworks, libraries, code or graphics you are using in this APP.

`files` - a list of files to be displayed. HTML, RTF or PDF is supported

# Compatibility

Tested and developed under iOS8, it should work under iOS7 as well. Dropping the SpriteKit gimmick it should be compatible down to maybe iOS5 - but I won't test that anymore.

# Version

Open features I'd like to integrate
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
