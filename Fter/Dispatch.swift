//
//  Dispatch.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 28..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
extension DispatchQueue {
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
}
//    func tapGesture(gestureRecognizer:UIGestureRecognizer) {
//
//        guard let txt = self.postTextView.text else { return  }
//        let touchPoint = gestureRecognizer.location(in:self.postTextView)
//        let txtStorage = NSTextStorage(attributedString: NSAttributedString(string: moreText))
//        let layoutManager = NSLayoutManager()
//        txtStorage.addLayoutManager(layoutManager)
//        let  txtContainer = NSTextContainer(size: postTextView.frame.size)
//        layoutManager.addTextContainer(txtContainer)
//        txtContainer.lineBreakMode = .byWordWrapping
//        txtContainer.lineFragmentPadding = 0
//            let range = (txt as NSString).range(of:moreText)
//        let toRage = (txt as NSString).range(of: moreText)
//        let glyphRange = layoutManager.glyphRange(forCharacterRange:range, actualCharacterRange: nil)
//        let glyphRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: txtContainer)
//        print(glyphRect)
//        print(touchPoint)
//
//        print(self.Point)
//        let sse = CGFloat(self.postTextView.numberOfLines)
//        let ss = self.postTextView.frame.size.width / sse
//        print(ss)
//
//         let size: CGSize = postTextView.text!.size(attributes: [NSFontAttributeName: UIFont(name: "Helvetica", size: 12.0)!])
//         var seeee = (size.width / sse) - self.postTextView.frame.size.width
//
//
//        var chas: CGFloat
//        if(seeee < 0 ){
//
//         chas =  seeee
//        } else{
//            chas = -seeee
//
//        }
//             print(chas)
//        if(ss + 30   <= touchPoint.x  ){
//
//            print(self.postTextView.frame.size.width)
//            print(touchPoint.x)
//
//            if(self.postTextView.frame.size.width   >= touchPoint.x  ){
//
//
//                if(chas >= 0.0 || self.postTextView.frame.size.width   >= touchPoint.x){
//                      //  print("tap")
//
//                    print(Int(chas))
//                    if(self.postTextView.frame.size.width   >= touchPoint.x - chas - 30  ){
//
//                        print("tap")
//
//                    }
//                }
//            }
//
//        }
//    }
