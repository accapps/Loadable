import XCTest
@testable import Loadable

final class LoadableTests: XCTestCase {
    struct Users: Codable {
        let fact: String
        let length: Int
    }

    func testExample() async {
        let users: Users? = await Loadable<Users>(url: URL(string: "https://catfact.ninja/fact")!).request()
        XCTAssertNotNil(users)
    }
}
