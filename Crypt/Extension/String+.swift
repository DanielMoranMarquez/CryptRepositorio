//
//  String+.swift
//  Crypt
//
//  Created by Daniel Morán on 25/4/23.
//

import Foundation
//Importar libreria
import CommonCrypto

extension String {
    func hmacSha1(key: String) -> String {
         var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
         CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), key, key.count, self, self.count, &digest)
         let data = Data(digest)
         return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
     }
}
