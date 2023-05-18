//
//  LogbookSpec.swift
//  LogbookTests
//
//  Created by Ryan Goodlett on 5/18/23.
//

import Foundation
import Quick
import Nimble

final class LogbookSpec: QuickSpec {

    override class func spec() {
        var logbook: Logbook!
        var logbookPreviewableMock: Logbook!

        describe("Logbook") {
            beforeEach {
                logbook = .testableMock()
                logbookPreviewableMock = .previewableMock()
            }

            it("should be initialized correctly") {
                expect(logbook.name).to(equal(Logbook._testableName))
                expect(logbook.creationDate.distance(to: .now)).to(beLessThan(0.05))
                expect(logbook.modifiedDate.distance(to: .now)).to(beLessThan(0.05))
            }

            it("should be previewable") {
                expect(logbookPreviewableMock.name).to(equal(Logbook._previewableName))
            }
        }
    }
}
