//
//  ViewController.swift
//  Practice
//
//  Created by 송명진 on 2017. 10. 17..
//  Copyright © 2017년 송명진. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController : UIViewController, AVAudioPlayerDelegate{
    //AVAudioPlayerDelegate java의 인터페이스랑 비슷 프로토콜
    
    var player :AVAudioPlayer!
    var playbutton : UIButton!
    var slider : UISlider!
    var timer :Timer!
    var volumeLabel: UILabel!
    var volumeStepper: UIStepper!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initalizePlayer()
        self.makePlayButton()
        self.makeSlider()

    }
    
    //MARK:- Custom Method
    func initalizePlayer(){
        guard let soundAsset : NSDataAsset = NSDataAsset(name: "sound")
            else {
                print("음원 파일 에셋을 가져올 수 없습니다.")
                return
        }
        
        do{
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self
        }catch let error as NSError{
            print("플레이어 초기화 실패")
            print("코드 : \(error.code),메시지 :\(error.localizedDescription)")
        }
    }
    
    
    func makePlayButton() {
        
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        button.setImage(UIImage(named: "button_play"), for: UIControlState.normal)
        button.setImage(UIImage(named: "button_pause"), for: UIControlState.selected)
        
        button.addTarget(self, action: #selector(self.clickPlaybutton(sender:)), for: UIControlEvents.touchUpInside)

        let safeAreaGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        
        let centerX: NSLayoutConstraint
        centerX = button.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor) //safeArea에 그림
        
        let top: NSLayoutConstraint
        top = button.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant:50)
        
        let width: NSLayoutConstraint
        width = button.widthAnchor.constraint(equalToConstant:80)
        
        let height:NSLayoutConstraint
        height = button.heightAnchor.constraint(equalToConstant: 80)
        
        centerX.isActive = true
        top.isActive = true
        width.isActive = true
        height.isActive = true
        
        self.playbutton = button
    }
    
    func makeSlider(){
 
        let slider :UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(slider)
        
        slider.addTarget(self, action: #selector(self.sliderValueChanged(sender:)), for: UIControlEvents.valueChanged)
        //메서드 이름을 힌트로 다이나믹하게 찾음
        
        let safeAreaGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        
        let centerX: NSLayoutConstraint
        centerX = slider.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = slider.topAnchor.constraint(equalTo: self.playbutton.bottomAnchor, constant:10)
        
        let width: NSLayoutConstraint
        width = slider.widthAnchor.constraint(equalTo: safeAreaGuide.widthAnchor, multiplier:0.8,constant:0)
        //전체 넓이의 80퍼센트
        
        centerX.isActive = true
        top.isActive = true
        width.isActive = true
        
        self.slider = slider
    }
    
    func makeAndFireTimer(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {[unowned self](timer:Timer)in
            if self.slider.isTracking{return}
            self.slider.value = Float(self.player.currentTime)
        })
        self.timer.fire()
    }
    
    func invalidateTimer(){
        self.timer.invalidate()
        self.timer = nil
    }
    
    @objc func sliderValueChanged (sender: UISlider){
        if sender.isTracking { return }
        self.player.currentTime = TimeInterval(slider.value)
    }
    
    @objc func clickPlaybutton (sender: UIButton){
        sender.isSelected = !sender.isSelected
        if(sender.isSelected){
            self.player?.play()
        }else{
            self.player?.pause()
        }
        self.slider.maximumValue = Float(self.player.duration)
        self.slider.minimumValue = 0;
        self.slider.value = Float(self.player.currentTime)
        
        if(sender.isSelected){
            self.makeAndFireTimer()
        }else{
            self.invalidateTimer()
        }
    }
    
    
    // MARK:- EndAudio
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("플레이어 재생이 끝났습니다")
        self.playbutton.isSelected = false
        self.slider.value = 0;
        self.invalidateTimer()
    }
}
