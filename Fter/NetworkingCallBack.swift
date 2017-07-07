//
//  NetworkingCallBack.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 24..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

protocol NetworkingCallBack{
    
    func networkResult(resultData : Any, code:String)
    func networkFailed()

}
    

  
