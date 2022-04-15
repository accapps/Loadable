import XCTest
@testable import Loadable

final class LoadableTests: XCTestCase {
    struct Cat: Codable {
        let fact: String
        let length: Int
    }

    func testRequest() async {
        let users: Cat? = await Loadable(url: URL(string: "https://catfact.ninja/fact")!).request()
        XCTAssertNotNil(users)

    }

    func testDownload() async {
        let (url, urlResponse) = await Loadable(url: URL(string: "https://www.buds.com.ua/images/Lorem_ipsum.pdf")!).download()
        XCTAssertNotNil(url)
        XCTAssert(urlResponse?.mimeType == "application/pdf")
    }

    func testUpload () async {
        let (data, urlResponse) = await Loadable(url: URL(string: "https://httpbin.org/post")!, httpMethod: .post).upload(fileUrl: Bundle.module.url(forResource: "Lorem_ipsum", withExtension:"pdf")!)
        XCTAssertNotNil(data)
        XCTAssert((urlResponse! as! HTTPURLResponse).statusCode == 200)
    }
}
