# RxRover

This is a demo project structured using the Cause-Logic-Effect (CLE) architecture by [@danielt1263][1]. You can find out more about CLE [here][2] and [here][3]. This project uses the NASA Mars Rover Photos API to view images captured by the Opportunity, Spirit and Curiosity rovers.

## Tip

As quoted by Daniel, the key to a clean connector (and therefore clean cause-logic-effet chain) is to have the connector be full of:

```swift
let result = logic(cause)
    .flatMapFirst {
        effect
    }
```

...and...

```swift
logic(cause)
    .bind(to: effect)
    .disposed(by: disposeBag)
```

Checkout [PhotosConnector][4] to see this in action.

[1]: https://github.com/danielt1263
[2]: https://github.com/danielt1263/CLE-Architecture-Tools
[3]: https://github.com/danielt1263/RxEarthquake
[4]: https://github.com/greghive/RxRover/blob/main/RxRover/Scenes/Photos/Photos/PhotosConnector.swift
