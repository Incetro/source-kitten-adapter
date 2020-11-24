//
//  SourceKittenAdapterImplementation.swift
//  source-kitten-adapter
//
//  Created by incetro on 11/22/20.
//

import Files
import ShellOut
import Foundation

// MARK: - SourceKittenAdapterImplementation

public final class SourceKittenAdapterImplementation {

    // MARK: - Initializers

    public init() {
    }
}

// MARK: - SourceKittenAdapterImplementation

extension SourceKittenAdapterImplementation: SourceKittenAdapter {

    public func dictionary(forFileAt url: String) throws -> JSONDictionary {

        /// Clear environment from previous files if they are eixst
        let workingFolder = Folder.current
        let filesForCleaning = [
            Constants.sourceKittenScriptName,
            Constants.sourceKittenScriptOutputName
        ]
        try filesForCleaning
            .filter {
                workingFolder.containsFile(named: $0)
            }
            .map(File.init)
            .forEach {
                try $0.delete()
            }

        /// Copy target file to working directory
        let targetFile = try File(path: url)
        if workingFolder.containsFile(named: targetFile.name) {
            try workingFolder.file(named: targetFile.name).delete()
        }
        let workingFileCopy = try targetFile.copy(to: workingFolder)

        /// Do SourceKitten work
        let sourceKittenScript = Constants.sourceKittenScript(
            inputFilePathString: targetFile.name,
            outputFilePathString: Constants.sourceKittenScriptOutputName
        )

        let sourceKittenScriptFile = try workingFolder.createFile(named: Constants.sourceKittenScriptName)
        try sourceKittenScriptFile.write("")
        try sourceKittenScriptFile.append(sourceKittenScript)
        try shellOut(to: "sh \(Constants.sourceKittenScriptName)")
        try sourceKittenScriptFile.delete()

        /// Transform SourceKitten output to dictionary
        let sourceKitContentFile = try workingFolder.file(named: Constants.sourceKittenScriptOutputName)
        guard let data = try sourceKitContentFile.readAsString().data(using: .utf8) else {
            fatalError()
        }
        guard let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? JSONDictionary else {
            fatalError()
        }

        /// Clear output files
        try sourceKitContentFile.delete()
        try workingFileCopy.delete()

        return json
    }
}
