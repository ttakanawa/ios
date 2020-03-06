# Toggl's iOS app

# Architecture

## Sources

The app architecture is based on different sources, it has some of Redux and some of Elm. It's based on the work of [these guys](https://www.pointfree.co) and [this](https://github.com/ReactiveX/RxSwift), and also a little bit from [this](https://guide.elm-lang.org/architecture/).

It also takes from things learned in the past by using [similar](https://github.com/Odrakir/CachopoDemo) [approaches](https://github.com/toggl/watchos-app).

The approach we took to implement these ideas relies heavily in Rx concepts (speficically in RxSwift for this app)

## Parts

This is a high level overview of the different parts of the architecture. 

![architecture](images/architecture.png)

- **Views** This is anything that can subscribe to the store to be notified of state changes. Normally this happens only from views (UIViews or UIViewControllers), but other elements of the app could also react to state changes.
- **Action** Simple structs that describe an event, normally originated by the user, but also from other sources or in response to other actions (from Effects). The only way to change the state is through actions. Views dispatch actions to the store which handles them in the main thread as they come.
- **Store** The central hub of the application. Contains the whole state of the app, handles the dispatched actions passing them to the reducers and fires Effects. It also handles the app's dependencies (Environment)
- **App State** The single source of truth for the whole app. This will be almost empty when the application start and will be filled after every action. This won't contain any derived state (meaning any state that can be calculated from any other state). This won't be a copy of the DB, it doesn't have to necessarily contain everything in the DB all the time and also, it'll include other stuff not in the DB (like the current route or a flag indicating if the app is in the background, for example). Basically you have to ask yourself what do you need to store here so you can restart the app in the exact same place as it was before shutting it down (even if we are never going to need that)
- **Reducers** Reducers are pure functions that take the state and an action and produce a new state. Simple as that. In our case they also take the environment (just the part they need) and optionally result in an Effect that will asynchronously dispatch further actions. All business logic should reside in them.
- **Effects** As mentioned, Reducers optionally produce these after handling an action. They are just observables that can emit further actions. Those observables are subscribed to in the store and the emitted actions will be dispatched again. These are use as a way to handle asynchronous actions.
- **Environment** This will hold all the dependencies our reducers need, so basically everything in the infrastructure layer. Examples could be the DataBase, the API, a timer service, a location service... This is passed into the store on construction and the store takes care of injecting it into the reducers.

There's one global `Store` and one `AppState`. But we can *view* into the store to get sub-stores that only work on one part of the state. More on that later.

There's also one main `Reducer` but multiple sub-reducers that handle a limited set of actions and only a part of the state. Those reducers are then *pulled back* and *combined* into the main 
reducer.

## Store & State

The `Store` exposes an observable which emits the whole state of the app everytime there's a change and a method to dispatch actions that will modify that state.

In order for it to work it uses the app `Reducer` and the `Environment`. More on these two later.

The `State` is just a struct that contains ALL the state of the application. All properties are `var`, because we are going to mutate it, but don't worry, mutations only happen in reducers. It has an initializer with no parameters which creates the initial state of the app.

It also includes the local state of all the specific modules that need local state. More on this later.

The store is built like this:

```swift
let store: Store<AppState, AppAction> = Store(
    initialState: AppState(),
    reducer: appReducer,
    environment: appEnvironment
)
```

actions are dispatched like this:

```swift
store.dispatch(AppAction.start)
```

and views can subscribe directly to the state or through the select method which takes a closure to map part of the state, and also to not repeat events if the elements are `Equatable`

```swift
store.state
    .subscribe(onNext: { print("The whole state: \($0)") })
    .disposed(by: disposeBag)

// or

store.select({ $0.email })
    .drive(emailTextField.rx.text)
    .disposed(by: disposeBag)
```

The store can be "viewed into", which means that we'll treat a generic store as if it was a more specific one which deals with only part of the app state and a subset of the actions. More on STORE VIEWS.

## Actions

Actions are enums, which makes it easier to discover which actions are available and also add the certainty that we are handling all of them in reducers.

These enums are embeded into each other starting with the `AppAction`

```swift
public enum AppAction
{
    case start

    case onboarding(OnboardingAction)
    case timer(TimerAction)
}
```

So to dispatch an `OnboardingAction` to a store that takes `AppActions` we would do

```swift
store.dispatch(.onboading(.start))
```

But if the store is a view that takes `OnboardingActions` we'd do it like this:

```swift
store.dispatch(.start)
```

## Reducers & Effects

Reducers are functions with this shape:

```swift
(inout StateType, ActionType, Environment) -> Effect<ActionType>
```

The idea is they take the state and an action and modify the state depending on the action and its payload.

Reducers also take an `Environment` which will contain all the dependencies they need to do their tasks (Repository, API, Keychain...).

In order to dispatch actions asynchronously we will use `Effects`. Reducers return an `Effect` which is an observable of actions. The store subscribes to those effects and dispatches whatever actions it emits.

There's a `toEffect` method on `Observable` which will map an `Observable` into an `Effect`.

```swift
let emailLoginReducer = Reducer<OnboardingState, EmailLoginAction, UserAPI> { state, action, api in
    
    switch action {
    
    //...
    
    case .loginTapped:
        state.user = .loading
        return loadUser(email: state.email, password: state.password, api: api)
        
    case let .setUser(user):
        state.user = .loaded(user)
        api.setAuth(token: user.apiToken)
        state.route = AppRoute.main(.timer)
        
    case let .setError(error):
        state.user = .error(error)
    }
    
    return .empty
}

func loadUser(email: String, password: String, api: UserAPI) -> Effect<EmailLoginAction>
{
    return api.loginUser(email: email, password: password)
        .map({ EmailLoginAction.setUser($0) })
        .catchError({ Observable.just(EmailLoginAction.setError($0)) })
        .toEffect()
}
```

## Pullback & Store Views

## High-order reducers

## Local State

## Coordinators

## Features

## Navigation

# Project Structure

## Frameworks & Modules



