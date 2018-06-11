//
//  ViewController.swift
//  HighlightedTextSample
//
//  Created by 高井　翔太 on 2018/06/07.
//  Copyright © 2018年 Medley, inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: CustomMenuTextView!
    var selectedText: String = ""
    var selectedRange: NSRange?

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        textView.customMenuDelegate = self
        textView.isSelectable = true
        textView.isEditable = false
        textView.tintColor = UIColor.red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAllHighlight()
    }

    private func setAllHighlight() {
        guard let results = RealmService.shared.getAll(Highlight.self), let highlights = Array(results) as? [Highlight] else {
            return
        }
        highlights.forEach { highlight in
            self.setHightlight(self.textView.attributedText, range: NSRange(location: highlight.location, length: highlight.length))
        }
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

    private func clearHighlight() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        attributedString.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.clear, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        textView.attributedText = attributedString
        textView.selectedRange = NSRange()
    }

    @IBAction func clickClearButton(_ sender: UIButton) {
        if RealmService.shared.deleteAll() {
        } else {
            print("ハイライトの削除に失敗しました")
        }
        clearHighlight()
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

extension ViewController: CustomMenuTextViewDelegate {
    func didSelectHighlightMenu() {
        guard let text = textView.attributedText, let range = selectedRange else {
            return
        }
        if RealmService.shared.store(Highlight(selectedText, location: range.location, length: range.length)) {
        } else {
            print("ハイライトの保存に失敗しました")
        }
        setHightlight(text, range: range)
    }

    func didSelectShareMenu() {
        let activityViewController = UIActivityViewController(activityItems: [selectedText], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activityType, completed, returnedItems, error) in
            if completed {

            }
        }
        present(activityViewController, animated: true, completion: nil)
    }

    func didSelectCopyMenu() {
        UIPasteboard.general.string = selectedText
    }
}
