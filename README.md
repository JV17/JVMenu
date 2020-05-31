# JVMenu

Simple iOS Menu written in Swift. Currently only supports portrait mode, might look into to enhance it to support landscape as well. Decided to shared it, as I'm using in one of my apps.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<!--![screenshot-1](Resources/demo-screen.gif)-->
<img src="https://github.com/JV17/JVMenu/blob/master/Resources/demo-screen.gif" width="300">

## Usage

You can make any of your objects to conform to the **JVMenuProtocol** like shown in the **BaseMenuViewController**. Then, you will simply will need to conform the protocol functions. 

```swift
extension BaseMenuViewController: JVMenuProtocol {

    func selectedMenuItem(row: Int) {
        // push or do any work based on menu selection...
        print(row)
    }
    
    var data: JVMenuDataModel {
        return JVMenuDataModel(items)
    }
}
```

The first function **selectedMenuItem** will get called indicating which menu object was selected based on the row. Then, the variable **data** of type **JVMenuDataModel** will provide all the customization for the menu, like: menu items, background color, row height, font, text color and the table separator color. 
You could use the default implementation and just specified the menu items as shown on the **BaseMenuViewController**...

```swift
private var items: [JVMenuItem] {
	return [JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "First Menu 1"),
			JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Second Menu 2"),
			JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Third Menu 3"),
			JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Forth Menu 4"),
			JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Fifth Menu 5"),
			JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Sixth Menu 6")]
}
```

This array of **JVMenuItem** will contain each icon to be used an title for the menu.

Finally, you can call some of the default implementations like **showMenu()** or **hideMenu** (if needed as the menu hides automatically after a menu option is selected or if it's dismissed by the gestures). 

Note: This menu gets added to the UIWindown and also is a singleton instance.

## Requirements

Currently, only supporting latest iOS 13.4. Sorry! :/

## Installation

JVMenu is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JVMenu'
```

## Author

JV17, jorge.valbuena@jorgedeveloper.com

## License

JVMenu is available under the MIT license. See the LICENSE file for more info.
