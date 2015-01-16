# A Simple SpriteKit Contact Manager
- Rob Anderson
- robb-j
- Jan 2015


## Features
- Use closures for your physics contacts


## Instructions For Setup
#### Using Submodules (Best)
1. Open Terminal
2. Type: `cd to/your/project` (where your .xcodeproj is)
3. Type: `git submodule add git@github.com:robb-j/PhysicsObserver.git`
4. Open your project in Xcode
5. Import the files in PhysicsObserver/Observer to your project

#### Manually (Dirty)
1. Download the repository
2. Open Xcode
3. Add the files in GameScheduler/Observer to your project

#### Final Step (Required)
In your SKScene subclass:
- Override `didMoveToView` and add `self.physicsWorld.contactDelegate = ContactManager()`
- Override `willMoveFromView:` and add `ContactManager.shared?.sceneWasRemoved()`



## Usage
### Adding an Observation
- Just use `ContactManager.shared?.addContactObservation(self, on: <#Node#>, with: PhysicsCategory.<#Name#>) { node, category, contact, type in <#Code#> }`


## Tips
- Remember to call `ContactManager.shared?.sceneWasRemoved()` when your scene is removed