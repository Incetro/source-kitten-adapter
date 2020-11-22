import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(source_kitten_adapterTests.allTests),
    ]
}
#endif
