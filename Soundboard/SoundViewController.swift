//
//  SoundViewController.swift
//  Soundboard
//
//  Created by Colleen Ng on 9/16/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var txtSoundName: UITextField!
    
    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
    }
    
    func setupRecorder() {
        do {
            // Create an audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create URL for audio file
            
            // Create settings for the audio recorder
            
            // Create audioRecorder object
            audioRecorder = AVAudioRecorder(url: <#T##URL#>, settings: <#T##[String : Any]#>)
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func btnRec(_ sender: Any) {
    }
    
    @IBAction func btnPlay(_ sender: Any) {
    }
    
    @IBAction func btnAdd(_ sender: Any) {
    }
    
}
