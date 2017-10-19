//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let ste2:Any = "시"

print(str)

//closure
/*
 코드의 블럭
 일급 객체
     *전달인자, 변수 , 상수 등으로 저장, 전달이 가능
 */

func backwards(left:String, right:String) -> Bool{
    print("\(left)\(right)비교중")
    return left > right
}
/*
let names:[String] = ["hana","eric","yagom","kim"]
let reversed:[String] = names.sorted(by:backwards) //names Array의 이름을 비교 방법 대로 정렬
print(reversed)
*/
let names:[String] = ["hana","eric","yagom","kim"]
/*
let reversed:[String] = names.sorted(by: {
    (left:String, right:String) -> Bool in return left > right
})
//이름 없는 함수 블럭을 실행하여 사용
*/
//print(reversed)
/*
let reversed: [String] = names.sorted() {
    (left:String, right:String) -> Bool in return left > right
} //return 값이 하나라면 ()도 지울 수 있음

print(reversed)
*/
/*
let reversed: [String] = names.sorted{
    (left,right) in return left > right
}
//컴파일 속도도 늦어질수 있음
print(reversed)
*/

//단축 인자를 사용

let reversed: [String] = names.sorted{$0 > $1}
print(reversed)

//회사 마다 클로저 단계가 있음





















