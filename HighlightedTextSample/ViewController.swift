//
//  ViewController.swift
//  HighlightedTextSample
//
//  Created by 高井　翔太 on 2018/06/07.
//  Copyright © 2018年 Medley, inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    var selectedText: String = ""
    var selectedRange: NSRange?

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        textView.isSelectable = true
        textView.isEditable = false
        textView.tintColor = UIColor.red
        
    }

    @IBAction func clickHighlightButton(_ sender: UIButton) {
        guard let text = textView.attributedText, let range = selectedRange else {
            return
        }
        setHightlight(text, range: range)
    }

    private func setHightlight(_ text: NSAttributedString, range: NSRange) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5

        if range.length > 0 {
            let attributedString = NSMutableAttributedString(attributedString: text)
            attributedString.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.yellow, range: range)
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            textView.attributedText = attributedString
            textView.selectedRange = NSRange()
        }
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        let range = textView.selectedRange
        let text = textView.text ?? ""
        let from = text.index(text.startIndex, offsetBy: range.location)
        let to = text.index(from, offsetBy: range.length)
        let selected = textView.text[from..<to]
        selectedText = String(selected)
        selectedRange = range
        print(selected)
        print(range)
    }
}
