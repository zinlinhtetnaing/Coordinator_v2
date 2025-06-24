//
//  Coordinator_v2Tests.swift
//  Coordinator_v2Tests
//
//  Created by Zin Lin Htet Naing on 13/03/2024.
//

import XCTest
import XKeychainService

final class Coordinator_v2Tests: XCTestCase {
    
    let devKeychain = XKeychainService(service: "dev")
    
//    lazy var testData: [Int] = {
//        return (0..<100000).map { Int($0) }
//    }()
//    
//    func testForEachLoop() {
//        measure {
//            var evenNumbers: [Int] = []
//            testData.filter { number in number % 2 == 0}.forEach { number in evenNumbers.append(number) }
//        }
//    }
//    
//    func testForLoop() {
//        measure {
//            var evenNumbers: [Int] = []
//            for number in testData {
//                if number % 2 == 0 {
//                    evenNumbers.append(number)
//                }
//            }
//        }
//    }
    
    private var cIv: String?
    
    var cachedIv: String? {
        get {
            if let iv = cIv {
                return iv
            }
            
            let kIV = self.devKeychain.read(for: .dynamicIV) ?? "can't read"
            cIv = kIV
            return kIV
        }
        set {
            self.devKeychain.set(for: .dynamicIV, item: "dev12345")
        }
    }
    
    func testGetDataFromKeyChainDirectly() {
        measure {
            for i in 0..<1000 {
                let iv = self.devKeychain.read(for: .dynamicIV) ?? "can't read"
                debugPrint(printData(value: iv))
            }
            
        }
    }
    
    func testDataFromCached() {
        measure {
            for i in 0..<1000 {
               debugPrint(printData(value: cachedIv ?? ""))
            }
            
        }
    }
    
    func printData(value: String) -> String {
        return "print Data : ------> \(value)"
    }

}
