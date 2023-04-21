//
//  Hidding.swift
//  Crypt
//
//  Created by Daniel Morán on 21/4/23.
//

import Foundation

@main
enum Hidding {
    static func main() {
        //1
        guard let infoFile = ProcessInfo.processInfo
          .environment["INFOPLIST_FILE"]
        else {
          return
        }
        guard let projectDir = ProcessInfo.processInfo.environment["SRCROOT"] else {
          return
        }

        //2
        if var dict = NSDictionary(contentsOfFile:
          projectDir + "/" + infoFile) as? [String: Any] {
          guard let _ = dict["Secreto"] as? String else { return }
            
          // 3
            dict["Secreto"] = "tercero"
          // 4
          
          // 5
          (dict as NSDictionary).write(
            toFile: projectDir + "/" + infoFile,
            atomically: true)
        }
    }
}

