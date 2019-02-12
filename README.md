This is a tool which could easily observe and visualize each route and flow we are tracking on the real time.

![](https://github.com/AppScaffold/Navi/blob/master/Screenshot.png?raw=true)

There will display a tips view when your cursor is floating on a node text if you have configured the info that you want to show.

![](https://github.com/AppScaffold/Navi/blob/master/Screenshot%20TipsView.png?raw=true)

## Intent

For a big App, sometime it's hard to check and debug which route we are using. what reaction will be happened once we click somewhere. in order to easily check those scenario whether or not meet the expectation, this tool is created to tackle this requirement.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequistes

What things you need to install the software and how to install them

1. Install npm
```
brew install node
```

2. Install Browsersync
```
npm install -g browser-sync
```

### Running

You have to run your project first before you execute the command below.

```
./run-navi.sh
```

## TODO

- [ ] Add more cases in demo
- [x] Support redirecting to a new page by clicking the text on a node
- [x] Map business logic documents
- [ ] Show history paths
- [ ] Adapt mobile screen
- [ ] Monitor the network