# eCommerce iOS App

Supports: iOS 13.x and above

Swift: 5.x and above

Architecture Pattern: CleanSwift ([see more on DuckDuckGo](https://duckduckgo.com/?q=clean+swift+ios))

## Branches:

* master - stable app releases
* develop - development branch, merge your feature branches here

## Dependencies:

The project is using Swift Package Manager for managing external libraries.

### Core Dependencies

* Alamofire - Alamofire is an HTTP networking library written in Swift.
* KingFisher - Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web.
* SnapKit - SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.

## Project structure:

* Resources - fonts, images, colors ect.
* Scenes - contains app scenes (UI + Code)
* Network - Endpoint configurations and network requests
* Common -  base models, base views and utility classes