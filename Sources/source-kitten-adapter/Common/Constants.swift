//
//  File.swift
//  source-kitten-adapter
//
//  Created by incetro on 11/22/20.
//

import Foundation

// MARK: - Constants

public enum Constants {

    static let sourceKittenScriptName = "sk.sh"
    static let swiftExtension = "swift"
    static let interlayerFolderName = "incetro-working-directory"
    static let outputFileExtension = "txt"

    static var sourceKittenScriptOutputName: String {
        sourceKittenScriptName + "." + outputFileExtension
    }

    static func sourceKittenScript(
        inputFilePathString: String,
        outputFilePathString: String
    ) -> String {
        "sourcekitten doc --single-file \(inputFilePathString) -- -j4 -sdk $(xcrun --show-sdk-path -sdk macosx) $(pwd)/\(inputFilePathString) > \(outputFilePathString)"
    }
}
