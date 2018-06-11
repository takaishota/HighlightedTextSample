//
//  UIPasteboard+attributedString.swift
//  HighlightedTextSample
//
//  Created by 高井　翔太 on 2018/06/11.
//  Copyright © 2018年 Medley, inc. All rights reserved.
//
import UIKit
import MobileCoreServices

// AttirbutedStringをクリップボードへコピーする
public extension UIPasteboard {
    public func set(attributedString: NSAttributedString?) {
        guard let attributedString = attributedString else {
            return
        }
        do {
            let rtf = try attributedString.data(from: NSMakeRange(0, attributedString.length), documentAttributes: [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.rtf])
            items = [[kUTTypeRTF as String: NSString(data: rtf, encoding: String.Encoding.utf8.rawValue)!, kUTTypeUTF8PlainText as String: attributedString.string]]

        } catch {
        }
    }
}
