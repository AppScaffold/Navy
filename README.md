# Navy

<!-- <p align="center"> -->
<a href="https://cocoapods.org/pods/Navy"><img alt="Version" src="https://img.shields.io/cocoapods/v/Navy.svg?style=flat"></a> 
<a href="https://github.com/AppScaffold/Navy/blob/master/LICENSE"><img alt="Liscence" src="https://img.shields.io/cocoapods/l/Navy.svg?style=flat"></a> 
<a href="https://developer.apple.com/"><img alt="Platform" src="https://img.shields.io/badge/platform-iOS-green.svg"/></a> 
<a href="https://developer.apple.com/swift"><img alt="Swift4.2" src="https://img.shields.io/badge/language-Swift4.2-orange.svg"/></a>
<!-- </p> -->

This is a tool which could easily observe and visualize each route and flow we are tracking on the real time.

![](https://github.com/AppScaffold/Navi/blob/master/Screenshot.png?raw=true)

There will display a tips view when your cursor is floating on a node text if you have configured the info that you want to show.

![](https://github.com/AppScaffold/Navi/blob/master/Screenshot%20TipsView.png?raw=true)

## Intent

For a big App, sometime it's hard to check and debug which route we are using. what reaction will be happened once we click somewhere. in order to easily check those scenario whether or not meet the expectation, this tool is created to tackle this requirement.

## Getting Started

This `Navy` framework has a demo app that you can run it directly following the below steps to see what it looks like and how it runs. But if you want to integrate it into your project, you have to replace the `BundleId` with **your project BundleId** in `run-navy.sh` script and move this script into your project folder.

### Prerequistes

1. Install npm
```
brew install node
```

2. Install Browsersync
```
npm install -g browser-sync
```

### Running Demo App

If you want to run demo app, you just need to `cd` to the `Navy` project path and execute `pod install`
Then you have to run demo app first before you execute the command below.

```
./run-navy.sh
```

### Integration

#### Cocoapods

`Navy` is on Cocoapods! After [setting up Cocoapods in your project](https://guides.cocoapods.org/), simply add the folowing to your Podfile:

```ruby
pod 'Navy'
```

then run `pod install` from the directory containing the Podfile!

Don't forget to import `Navy` when you use it.

#### Conform the `NaviProtocol`

```Swift
class Navigation: NaviProtocol {
    // Return root node name
    func rootNodeName() -> String {
        return "Navy"
    }
    
    // Return tabBar controllers 
    func tabBarViewControllers() -> [String] {
        return ["NavyDemo.FavoriteViewController", "NavyDemo.DownloadViewController", "NavyDemo.HistoryViewController"]
    }

    // Map the business logic document link to corresponding node
    func mapBusinessLogicDocument() -> [String: String] {
        return ["NavyDemo.FavoriteViewController": "https://en.wikipedia.org/wiki/Marie_Curie",
                "NavyDemo.ListViewController": "https://en.wikipedia.org/wiki/Albert_Einstein",
                "NavyDemo.DetailViewController": "https://en.wikipedia.org/wiki/Tu_Youyou",
                "NavyDemo.SettingViewController": "https://en.wikipedia.org/wiki/Alan_Turing",
                "NavyDemo.DownloadViewController": "https://en.wikipedia.org/wiki/Main_Page"]
    }
}
```

**Note**: if you are using custome Navigation, you have to implement the two optional protocols.

```Swift
func currentController() -> UIViewController {
    // Return current controller
}

func previousController() -> UIViewController {
    // Return previous controller
}
```

Last, call the `setup(with:)` method and pass the instance has implemented `NaviProtocol`.


```Swift
NaviHeader.shared.setup(with: Navigation())
```

### Running Your Project

You have to run your project first before you execute the command below.

⚠️ Don't forget to replace `BundleId` and move script into your project.

```
./run-navy.sh
```

## TODO

- [ ] Support dynamic display of call stack on web page
- [x] Support redirect to a new page by clicking the text on a node
- [x] Map business logic documents
- [ ] Show history paths
- [ ] Adapt mobile screen
- [ ] Monitor the network

## Requirements

- Swift 4.2+
- iOS 11.0+

## Contributing

Pull requests, feature requests and bug reports are welcome 🚀