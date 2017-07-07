//
//  define.swift
//  0408SOPTWork
//
//  Created by 진호놀이터 on 2017. 4. 12..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Swift
import UIKit


struct  ChangePart {
    
    func  getEngPart(part:String) -> String {
        var engPart :String!
        switch  part {
        case   "개발" :
            
                engPart = "develop"
            break
        case   "디자인" :
            
            engPart = "design"
            break
        case   "경영마케팅" :
                engPart = "bm"
            
            break
            
        default:
            engPart = part
            break
        }
        return engPart

    }
    func  getKoreanPart(part:String) -> String {
        var korPart :String!
        switch  part {
        case   "bm" :
            
            korPart = "경영마케팅"
            break
        case   "design" :
            
            korPart = "디자인"
            break
        case   "develop" :
            korPart = "개발"
            
            break
            
        default:
            korPart = part
            break
        }
        return korPart
        
    }

    
}

struct  ChangeCategory {
    
    func  getKoreanCategory(category:Int) -> String {
        var koreanCategory :String!
        print(category)
        switch  category {
        case   1 :
            
            koreanCategory = "고민있어요"
            break
        case   2 :
            
            koreanCategory = "궁금해요"
            break
        case   3 :
            koreanCategory = "일상이야기"
            
            break
        case  4 :
            koreanCategory = "함께해요"
            
            break
            
        default:
           
            break
        }
        return koreanCategory
        
    }
    func  getNumberCategory(category:String) -> Int {
        var numCategory :Int = 0
        switch  category {
        case   "고민있어요" :
            
            numCategory  = 1
            break
        case   "궁금해요" :
            
            numCategory = 2
            break
        case   "일상이야기" :
            numCategory = 3
            
            break
        case  "함께해요" :
            numCategory = 4
            
            break
            
        default:
            
            break
        }
        return numCategory
        
    }

    
}



/**
 App내에서 공통적으로 자주사용하는 Color를 구조체형식으로 표현
 **/
extension UILabel {
    
    func isTruncated() -> Bool {
        
        if let string = self.text {
            
            let size: CGSize = (string as NSString).boundingRect(
                with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude),
                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                attributes: [NSFontAttributeName: self.font],
                context: nil).size
            
            return (size.height > self.bounds.size.height)
        }
        
        return false
    }
   
    
}


struct AppColors {
    static let PupleColor = UIColor.init(red: 137/255.0, green: 158.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    static let GrayColor = UIColor.init(red: 123.0/255.0, green: 123.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    static let GrayColor2 = UIColor.init(red: 203.0/255.0, green: 203.0/255.0, blue: 203.0/255.0, alpha: 1.0)
     static let GrayColor3 = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
     static let pinkColor = UIColor.init(red: 237/255.0, green: 59.0/255.0, blue: 162.0/255.0, alpha: 1.0)
}

/**
 Login 정보를 전역적으로 사용하기 위해서UserDefault에 저장할
 
 key값들을 상수로 표현한 구조체
 **/
struct UserDefaultString {
    static let ID: String = "id"
    static let PW: String = "pw"
    static let NAME: String = "name"
    static let AGE: String = "age"
    //나중에 쓸때
    static let IsAutoLogin: String = "isAutoLogin"
    
}

/** DefaultAlert class 내에  basicAlert에 필요한
 
 - OneButtonStyle : 기본적인 스타일로 확인버튼 누를시 alert없어짐
 - TwoButtonStyle : 확인버튼외에 취소버튼을 추가 확인버튼 누를 시 dismiss메서드 실행
 ---
 추후에 2개추가 예정
 ---
 **/
enum AlertButtonStyle {
    case  OneButtonStyle
    case  TwoButtonStyle
    case  FourButtonStyle
}




class Utility {
    
    func myLog<T>(object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        let info = "\(function)[\(line)]:\(object)"
        print(info)
    }
    static  func dateString(date inputdate: Date, inputFomat:String) -> String {
        
        let date = inputdate
        let formatter = DateFormatter()
        formatter.dateFormat = inputFomat
        
        return   formatter.string(from: date)
    }
    
    static func genderOptString(string optString: String?) -> String{
        
        guard let string = optString else { return "" }
        
        return string
    }
    
}
// typealias AlertTypeHandler = ((UIAlertAction) ->Void)
class DefaultAlert {
    
    
    /**
     프로젝트 내에서 공통적으로 사용할 커스텀Alert입니다.
     
     - parameters:
     - title: Alert의 상단 가운데 제목
     - inputMessage: 제목 외에 추가적인 내용
     - viewController: action을 사용할 VC(주로 self)
     - alertButtonStyle: OneButton 기본형식과 TwoButton 동작포함형식
     
     closure를 파라미터로 추가예정
     ---
     **/
    
    private var completeHandler: ((Void) -> Void)?
    
    func basicAlert(title:String, inputMessage:String, viewController: UIViewController ,alertButtonStyle:AlertButtonStyle,complete:((Void) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: inputMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        if(alertButtonStyle == AlertButtonStyle.OneButtonStyle){
            
            alert.addAction(UIAlertAction(title: "공유하기", style: UIAlertActionStyle.default, handler:nil))
            alert.addAction(UIAlertAction(title: "취소하기", style: UIAlertActionStyle.default, handler:nil))
            
        } else if(alertButtonStyle == AlertButtonStyle.TwoButtonStyle){
            
//            alert.addAction(UIAlertAction(title: "삭제하기", style: UIAlertActionStyle.destructive, handler: {
//                
//                //부모뷰찾는거해야함
//                alertAction in
//                if let vc = viewController.presentationController {
//                    viewController.dismiss(animated: true, completion:nil)
//                    guard let cpl = complete else{
//                        
//                        return
//                    }
//                    cpl()
//                }
//                
//                viewController.navigationController?.popViewController(animated: true)
//            }))
            alert.addAction(UIAlertAction(title: "삭제하기", style: UIAlertActionStyle.default, handler: {
                
                //부모뷰찾는거해야함
                alertAction in
                
                complete!()

             //   viewController.navigationController?.popViewController(animated: true)
            }))

            
            
            
            alert.addAction(UIAlertAction(title: "취소하기", style: UIAlertActionStyle.destructive, handler:nil))
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}


class DefaultAlert2 {
    
    
    /**
     프로젝트 내에서 공통적으로 사용할 커스텀Alert입니다.
     
     - parameters:
     - title: Alert의 상단 가운데 제목
     - inputMessage: 제목 외에 추가적인 내용
     - viewController: action을 사용할 VC(주로 self)
     - alertButtonStyle: OneButton 기본형식과 TwoButton 동작포함형식
     
     closure를 파라미터로 추가예정
     ---
     **/
    
    private var completeHandler: ((Void) -> Void)?
    
    func basicAlert(title:String, inputMessage:String, viewController: UIViewController ,alertButtonStyle:AlertButtonStyle,complete:((Void) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: inputMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        if(alertButtonStyle == AlertButtonStyle.OneButtonStyle){
            
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler:nil))
            
        } else if(alertButtonStyle == AlertButtonStyle.TwoButtonStyle){
            
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: {
                
                //부모뷰찾는거해야함
                alertAction in
                if let vc = viewController.presentationController {
                   // viewController.dismiss(animated: true, completion:nil)
                    guard let cpl = complete else{
                        
                        return
                    }
                    cpl()
                    
                }
                
              //  viewController.navigationController?.popViewController(animated: true)
                
            }))
            
            alert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.destructive, handler:nil))
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
}




class CustomPickerView {
    
    private var completeHandler: ((Void) -> Void)?
    
    /**
     프로젝트 내에서 공통적으로 사용할 커스텀Alert입니다.
     
     - parameters:
     - vc: toolbar의 크기를 지정 할 수 있는 현재VC
     - completeHandler: 확인버튼을 누른 후의 행동을 함수형태롤 지정
     **/
    func toolbarForpickerView(vc :UIViewController,completeHandler: ((Void) -> Void)?) -> UIToolbar{
        
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: vc.view.frame.size.height/4, width: vc.view.frame.size.width, height: 40.0))
        
        let doneButton = BlockBarButtonItem(title: "확인", style: UIBarButtonItemStyle.plain, actionHandler:completeHandler)
        
        toolBar.setItems([doneButton], animated: true)
        
        
        return toolBar
    }
}



class BlockBarButtonItem: UIBarButtonItem {
    private var actionHandler: ((Void) -> Void)?
    
    
    /**
     버튼을 생성하는 생성함수
     
     - parameters:
     - title: doneButton의 title 지정
     - style: UIBarButtonItemStyle을 커스텀지정 기본 .plain
     - completeHandler: 매개변수로 넘어온 complete함수를  1차로 받는 함수에서 호출 할 수 있도록 넘겨줌
     
     **/
    convenience init(title: String?, style: UIBarButtonItemStyle, actionHandler: ((Void) -> Void)?) {
        
        
        self.init(title: title, style: style, target: nil, action: #selector(barButtonItemPressed))
        //        self.init(barButtonSystemItem:style, target:nil, action:#selector(barButtonItemPressed))
        
        self.target = self
        self.title = title
        self.actionHandler = actionHandler
    }
    /*
     - barButtonItemPressed: 확인버튼을 누른후 버튼에서 맨처음 호출하는 함수 이곳에서 다시 complete 함수 호출
     */
    func barButtonItemPressed(sender: UIBarButtonItem) {
        actionHandler?()
    }
    
    
    
}


class ImageResizing:NSObject{




    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}




