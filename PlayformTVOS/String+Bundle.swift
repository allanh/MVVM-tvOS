/*
 * Copyright (C) 2017 Mattel, Inc. All rights reserved.
 *
 * All information and code contained herein is the property of
 * Mattel, Inc.
 *
 * Any unauthorized use, storage, duplication, and redistribution of
 * this material without written permission from Mattel, Inc. is
 * strictly prohibited.
 *
 * String+Bundle.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/30.
 */
import Foundation

extension String {
    /// Reading a text file from Bundle
    ///
    /// - Parameter bundle: Bundle instance
    /// - Returns: The file text
    func readFileFromBundle(_ bundle: Bundle? = Bundle.main) -> String? {
        let pathExtention = (self as NSString).pathExtension
        let pathPrefix = (self as NSString).deletingPathExtension
        
        guard let path = bundle?.path(forResource: pathPrefix, ofType: pathExtention) else {
            return nil
        }
        
        return try? String(contentsOfFile: path, encoding: .utf8)
    }
}
