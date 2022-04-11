# Loadable

 Loadable simplifies the REST-API Calls and utilizes Swift 5 syntax

### Usage

Pass struct that inherits Codable protocol

``` swift
let url = URL(string: "https://catfact.ninja/fact")!
let users: Users? = await Loadable<Users>(url: url).request()
let (users: Users?, urlResponse: URLResponse?) = await Loadable<Users>(url: url).request()
let (users: Users?, statusCode: Int?) = await Loadable<Users>(url: url).request()
```
