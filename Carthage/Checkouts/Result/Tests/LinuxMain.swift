import XCTest
@testable import ResultUnitTests

XCTMain([
  testCase(AnyErrorTests.allTests),
  testCase(NoErrorTests.allTests),
  testCase(ResultTests.allTests),
])
