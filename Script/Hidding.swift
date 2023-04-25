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
        guard let infoFile = ProcessInfo.processInfo.environment["INFOPLIST_FILE"] else { return }
        guard let projectDir = ProcessInfo.processInfo.environment["SRCROOT"] else { return }
        
        //2
        if var infoplist = NSDictionary(contentsOfFile:
          projectDir + "/" + infoFile) as? [String: Any] {
            
          // 3
            let url = URL.init(fileURLWithPath: projectDir + "/Secrets/archivo.txt")
            do {
                let content = try String(contentsOf: url, encoding: .utf8)
                let dict = SecretFactory().process(content: content)
                for entry in dict {
                    infoplist[entry.key] = entry.value
                }
            }
            catch (let error) {
                print(error)
            }
            
            
          // 4
          (infoplist as NSDictionary).write(
            toFile: projectDir + "/" + infoFile,
            atomically: true)
        }
    }
    
}
class SecretFactory {
    public func process(content: String) -> [String: Any] {
        let contentFormated = format(content: content)
        let encrypter = try? AES256(key: "Uc1gU2FsdGVkX19LW0ZSbvKUJT6TnTfI")
        let contentEncrypted = encrypt(content: contentFormated, encrypter: encrypter)
        return contentEncrypted
    }
    
    private func format(content: String) -> [String: String] {
        var dict = [String: String]()
        let entries = content.split(separator: ",")
        for entry in entries {
            let keyValues = entry.split(separator: "=")
            let key = String(keyValues[0])
            let value = String(keyValues[1])
            dict[key] = value
        }
        return dict
    }
    
    private func encrypt(content: [String: String], encrypter: AES256?) -> [String: Any] {
        var encryptedDict = [String: Any]()
        guard let encrypter else { return encryptedDict }
        
        for entry in content {
            encryptedDict[String(entry.key)] = encrypter.encrypt(messageData: entry.value.data(using: .utf8))
        }
        return encryptedDict
    }
    
}


