# A SpriteKit Contact Manager
- Rob Anderson
- robb-j
- Jul 2015


## Features
- Use closures for your physics contacts
- Add callbacks different ways; between nodes, categories or both


## Instructions For Setup
#### Using Submodules (Best)
1. Open Terminal
2. Type: `cd to/your/project` (where your .xcodeproj is)
3. Type: `git submodule add git@github.com:robb-j/PhysicsObserver.git`
4. Open your project in Xcode
5. Import the files in PhysicsObserver/Observer to your project (Make sure to deselect 'Copy items if needed')

#### Manually (Dirty)
1. Download the repository
2. Open Xcode
3. Add the files in PhysicsObserver/Observer to your project


## Usage
### Setup
- After you've created your scene set the contact delegate
```swift
myScene.physicsWorld.contactDelegate = ContactManager.shared
```

### Adding an Observation
- There are 3 types of observations you can add: between two nodes, between a node & category and between two categories
- Node you still have to setup the collision categories & contactMasks yourself

##### Between Two Nodes
```swift
ContactManager.shared.add(ContactObserver.betweenNode(node: <#Node A#>,
	andNode: <#Node B#>,
	observation: { (contact, phase) -> Void in
	
	<# Callback #>
}))
```

##### Between A Node and Category
```swift
ContactManager.shared.add(ContactObserver.betweenNode(node: <#Node#>,
	andCategory: <#Category#>,
	observation: { (contact, phase) -> Void in
	
	<# Callback #>
}))
```

##### Between Two Categories
```swift
ContactManager.shared.add(ContactObserver.betweenCategory(category: <#Cat A#>,
	andCategory: <#Cat B#>,
	observation: { (contact, phase) -> Void in
	
	<# Callback #>
}))
```

### Removing an Observer
- There's a way of removing observations for each type of observation, using `ContactType`
```swift
ContactManager.shared.remove(ContactType.Category(<#Cat A#>, <#Cat B#>))
ContactManager.shared.remove(ContactType.Node(<#Node A#>, <#Node B#>))
ContactManager.shared.remove(ContactType.NodeCategory(<#Node#>, <Category##>))
```
- You can also remove any observation on a given SKNode
```swift
ContactManager.shared.remove(ContactType.OnNode(<#Node#>))
```


## Tips
- Remember to call `ContactManager.shared.removeAllContactObservers()` when your scene is removed
- If you copy the code directly into xcode the <# Somthing #> will turn into insertion bubbles that you can tab through
- You can access the swiftdoc on public functions with a 3 finger tap on the function name
- You can use static properties on a struct to provide simpler access to physics categories, see `PhysicsCategories.swift`
