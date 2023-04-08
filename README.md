![Swift](https://github.com/stuedev/StateMachine/actions/workflows/swift.yml/badge.svg)

# StateMachine

**StateMachine** is a *Property Wrapper* you can use on *state properties* to prevent your code from performing **invalid state changes**.

Invalid state changes will lead to the program exiting with a **fatal error**.

# Example

Let's say we have an Image which is loaded from an URL. We define an enum *ImageState* to reflect the current state of the image. 

Initially, the state will be `.notLoaded`. Once we have sent the request to retrieve the image data from the web, the state will change to `.loading`. Depending on success or failure of the request, the state will finally change to either `.loaded` or `.failed(Error)`.

```swift
enum ImageState: ImplementsStateMachine
{
    case notLoaded

    case loading

    case loaded

    case failed(Error)


    static
    func canTransition(from fromValue: Self, to toValue: Self) -> Bool
    {
        switch (fromValue, toValue)
        {
            case 
                (.notLoaded, .loading),
                (.loading, .loaded),
                (.loading, .failed):

                return true

            default:

                return false
        }
    }
}
```

Our *ImageState* enum conforms to the *ImplementsStateMachine* protocol and implements the `canTransition(from:to:)` static function. This function controls whether a **state transition** from `fromValue` to `toValue` is valid. In the example, this is done via a *switch-case* statement.

Now we define the *state property* in the *Image* using the **StateMachine** *Property Wrapper*.

> **Note**<br>
> For more information on **Property Wrapper** see [here](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Wrappers).

```swift
class LoadableImage
{
    @StateMachine
    var state: ImageState = .notLoaded

    // ...

    func load()
    {
        self.state = .loading

        // ...
    }
}
```

The **StateMachine** *Property Wrapper* will be able to decide what should happen to the *state* property everytime its value is changed.

## Valid transition

```swift
let image = LoadableImage(from: url)

// image.state is .notLoaded

image.load()    

// image.state is .loading
```

In the `load()` method, the *state* of the image is set from the initial state `.notLoaded` to `.loading`. This is a valid transition, everything is fine.

## Invalid transition

Now let's assume there is some "misbehaving" code that wants to set the image's state.

```swift
let image = LoadableImage(from: url)

// image .state is .notLoaded

image.state = .loaded   // invalid state transition

// Fatal error: invalid transition for type `ImageState` from: `notLoaded` to: `loaded`
```

The **StateMachine** *Property Wrapper* tested the *state transition* with the *ImageState* type and found that it was invalid. As a consequence, the program is exited with a **fatal error**.
