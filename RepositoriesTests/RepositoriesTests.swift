//
//  RepositoriesTests.swift
//  RepositoriesTests
//
//  Created by matheus.filipe.bispo on 01/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import Quick
import Nimble
@testable import Repositories

class RepositoriesTests: QuickSpec {
    override func spec() {
        context("Teste") {
            it("Será que funciona?") {
                let teste = Teste()
                expect(teste).toNot(beNil())
            }
        }
    }
}
