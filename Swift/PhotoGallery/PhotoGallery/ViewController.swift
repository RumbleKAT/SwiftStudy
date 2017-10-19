//
//  ViewController.swift
//  PhotoGallery
//
//  Created by 송명진 on 2017. 10. 19..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker: UIImagePickerController=UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func tapImageView(_ sender: UITapGestureRecognizer){
        
        print("이미지 뷰 탭 탭")
        let alert:UIAlertController
        alert=UIAlertController(title:"사진 소스를 선택해주세요",
                                message: nil,
                                preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelAction)
        
        
        //사진첩 액션 추가
        let photoLibraryAction: UIAlertAction=UIAlertAction(title: "사진앨범", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction) in
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(self.imagePicker,animated: true,completion: {
                print("이미지 피커 나타남 - 사진앨범")
            })
        })
        alert.addAction(photoLibraryAction)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.delegate=self
        self.imagePicker.sourceType=UIImagePickerControllerSourceType.photoLibrary
        self.imagePicker.allowsEditing = false
        //사진이 업로드가 안됨
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit //모드에 맞게 설정 늘리기
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("사용자가 취소함")
        self.dismiss(animated: true){
            print("이미지 피커 사라짐")}
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        defer{
            self.dismiss(animated: true)
            {
                print("이미지 피커 사라짐")
            }
        }
        
        /*
        guard let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage
        else  {
            print("이미지 정보 없음")
            return
        }
        */
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.imageView.image = editedImage
        }else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            //aspect fit은 사진에 맞게 설정
            self.imageView.image = originalImage
        }
    }
    
    
    
}

