# HyperSpace
A fork of [SweetRouter](https://github.com/alickbass/SweetRouter)

![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Build Status](https://travis-ci.org/thecb4/HyperSpace.svg?branch=master)](https://travis-ci.org/thecb4/HyperSpace)
[![codecov](https://codecov.io/gh/thecb4/HyperSpace/branch/master/graph/badge.svg)](https://codecov.io/gh/thecb4/HyperSpace)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


I like

## Integration


### Carthage

You can use Carthage to install SweetRouter by adding it to your Cartfile:

```swift
github "thecb4/HyperSpace"
```

## Definitions

Imagine that you use the following `URLs` within your App

```
https://myservercom.com:123/api/new/signIn
https://myservercom.com:123/api/new/signOut
https://myservercom.com:123/api/new/posts?date=today&userId=id
```

Every `URL` in the list is called an **`Endpoint`**

### Endpoint

Endpoint has the following structure:

```
Endpoint
┌─────────────────────────────────┴────────────────────────────────────┐
https://myservercom.com:123/api/new/posts?date=today&userId=id#paragraph
└────────────────┬────────────────┘└────────────────┬──────────────────┘
Environment                           Route
```

Endpoint is represented with `EndpointType` `protocol`.

### Environment

Environment has the following structure:

```
Environment
┌────────────────┴─────────────────┐
https://myservercom.com:123/api/new/posts?date=today&userId=id#paragraph
└─┬─┘  └───────┬───────┘└┬┘└─────┬─┘
scheme        host     port default path
```

**Examples of Environment**

```swift
URL.Env(.https, "mytestserver.com").at("api", "new") // https://mytestserver.com/api/new/
URL.Env(IP(127, 0, 0, 1), 8080) // http://127.0.01:8080
URL.Env.localhost(4001) // http://localhost:4001
```

### Route
Route has the following structure:

```
Route
┌─────────────────┴─────────────────┐
https://myservercom.com:123/api/new/posts?date=today&userId=id#paragraph
└──┬──┘└────────┬─────────┘└───┬────┘
path        query         fragment
```

**Example of Route**

```swift
// /api/new/posts?date=today&userId=id#paragraph
URL.Route(at: "api", "new", "posts").query(("date", "today"), ("userId", "id")).fragment("paragraph")
```

## Example of usage

Here is an example of the Router for some back-end `API`:

```swift
enum Api: EndpointType {
enum Environment: EnvironmentType {
case localhost
case test
case production

var value: URL.Env {
switch self {
case .localhost: return .localhost(8080)
case .test: return .init(IP(126, 251, 20, 32))
case .production: return .init(.https, "myproductionserver.com", 3000)
}
}
}

enum Route: RouteType {
case auth, me
case posts(for: Date)

var route: URL.Route {
switch self {
case .me: return .init(at: "me")
case .auth: return .init(at: "auth")
case let .posts(for: date):
return URL.Route(at: "posts").query(("date", date), ("userId", "someId"))
}
}
}

static let current: Environment = .localhost
}
```

## Resolving Endpoints
Endpoints resolve to an EndPointResult that provides the HTTPResponse, Data, and Error you would normally get from a URLSession DataTask. EndPointResult is a struct with helper methods that return [Result](https://github.com/thecb4/Result) and a String version of the HTTPResponse, StatusCode, or JSON decode of the data.


```swift

let ep = Router<Auth>(at: .signIn)

let result = ep.resolve()

let expectedJSON: Result<Example, URL.ResponseError> = result.json()

switch  expectedJSON {

  case let .success(value):
    // do something with the json result

  case .failure( .noDataPresent ):
    print("no data present")
    // gracefully handle no data being present

  case let .failure( .decodeFailure(message) ):
    print(message)
    // gracefully handle decoding errors

}


```



## What if I have only one environment?

It can often happen, that you will be using some third-party `API` and you will have only access to Production environment. So in this case your Router will look something like this:

```swift
struct Auth: EndpointType {
enum Route: RouteType {
case signIn, signOut

var route: URL.Route {
switch self {
case .signIn: return .init(path: ["signIn"])
case .signOut: return .init(path: ["signOut"])
}
}
}

static let current = URL.Env(.https, "auth.server.com", 8080).at("api", "new")
}
```

And use it like this:

```swift
print(Router<Auth>(at: .signIn).url) // https://auth.server.com:8080/api/new/signIn
print(Router<Auth>(at: .signOut).url) // https://auth.server.com:8080/api/new/signOut
```

## How to use with Alamofire?

Add the following code somewhere in your app:

```swift
import Alamofire
import SweetRouter

extension Router: URLConvertible {
public func asURL() throws -> URL {
return url
}
}
```

And then you can use the same Routers like this:

```swift
Alamofire.request(Router<Auth>(at: .signIn))
```

As easy as that 😉
