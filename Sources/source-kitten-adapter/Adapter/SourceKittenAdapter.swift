//
//  File.swift
//  source-kitten-adapter
//
//  Created by incetro on 11/22/20.
//

import Files
import Foundation

// MARK: - SourceKittenAdapter

public protocol SourceKittenAdapter {

    /// Transform the given file to SourceKitten dictionary
    /// - Parameter url: target file url
    func dictionary(forFileAt url: String) throws -> JSONDictionary
}

// MARK: - Helpers

public extension SourceKittenAdapter {

    func dictionaries(forFolder url: String) throws -> [JSONDictionary] {
        let targetFolder = try Folder(path: url)
        let swiftFiles = targetFolder.files.recursive.filter { $0.extension == Constants.swiftExtension }
        print(swiftFiles.map(\.path))
        let dictionaries = try swiftFiles.map(\.path).map(dictionary)
        return dictionaries
    }
}
