//
//  ReplyWindowCallback.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 6..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//


import Foundation

protocol ReplyWindowCallBack{
    
    func sendReply(content:String)
    func replyWindowDidSelectedUseful(result: Bool)
    func resignWindowKeyBoard(textfield: UITextField)
}
