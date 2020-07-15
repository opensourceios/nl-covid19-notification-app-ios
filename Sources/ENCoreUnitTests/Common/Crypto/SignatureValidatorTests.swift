/*
 * Copyright (c) 2020 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
 *  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
 *
 *  SPDX-License-Identifier: EUPL-1.2
 */

@testable import ENCore
import XCTest

final class SignatureValidatorTests: XCTestCase {
    private let signatureValidator = SignatureValidator()

    func test_signatureValidator() {
        XCTAssertTrue(signatureValidator.validate(signature: signatureExample, content: contentExample))
    }

    // MARK: - Private

    private var contentExample: Data {
        return "Hello World!".data(using: .utf8)!
    }

    private var signatureExample: Data {
        return Data(base64Encoded: """
        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
        """)!
    }
}