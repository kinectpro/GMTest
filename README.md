# Test application

Test application requirements:

> Instructions for the test: 
>  		● Create a new IOS app, using swift. 
> 		● The main screen of the app should be a map (using google map SDK) centered on your location with an indicator of where you are 
>		● A side menu containing 2 items (San Francisco and New York) should slide in when tapping on a menu button in the top left corner 
>		● When clicking on any of the 2 items move the map to the selected city and add a marker in the city. 
>		● Any API keys (Google API), must be stored in a config file and documented. 
>		● Once the test completed, host on public repo under your account with instructions on how to run the code if necessary and send link over for us to review. 


### Tech
Application is written with Swift 3.0 requirements.

Used frameworks:
* [GoogleMapsSDK] -  https://developers.google.com/maps/documentation/ios-sdk/


### Code-level comments

Application config contains Google Maps API access key, see ```Settings.swfit```
The core functions are ```MenuViewController.swift``` - side menu, ```MapsViewController.swift``` - maps and pins rendering
```ContainerViewController.swift``` - class that represents slide menu controller.
Data source located at ```City.swift``` - it's a model of a city and list of predefined cities and their locations.

### Adding submenu

In order to add more items to side menu, need to check private extension UIStoryboard at ```ContainerViewController.swift``` file.

```swift
private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    class func menuViewController() -> MenuViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    }
    
    class func mapsViewController() -> MapsViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "MapsViewController") as! MapsViewController
    }
    // add new controllers here
}
```


### References

List of reference articles and SDK docs.

* [https://www.raywenderlich.com/78568/create-slide-out-navigation-panel-swift]
* [https://developers.google.com/maps/documentation/ios-sdk/start?hl=en]
