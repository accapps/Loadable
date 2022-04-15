# Loadable

![SPM](https://github.com/umutonat/Loadable/actions/workflows/swift.yml/badge.svg)

 Loadable simplifies the REST-API Calls and utilizes Swift 5 syntax

### Usage

Pass struct that inherits Codable protocol

``` swift
struct Cat: Codable {
let fact: String
let length: Int
}
let url = URL(string: "https://catfact.ninja/fact")!
let fileUrl = Bundle.module.url(forResource: "Lorem_ipsum", withExtension:"pdf")!
let users: Cat? = await Loadable(url: url).request()
let (users: Cat?, urlResponse: URLResponse?) = await Loadable(url: url).request()
let (users: Cat?, statusCode: Int?) = await Loadable(url: url).request()
let (url, urlResponse) = await Loadable(url: url).download()
let (data, urlResponse) = await Loadable(url: url, httpMethod: .post).upload(fileUrl: fileUrl)
```
