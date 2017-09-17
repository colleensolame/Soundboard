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
            let basePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            
            // Create settings for the audio recorder
            var settings: [String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            // Create audioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func btnRec(_ sender: Any) {
        if audioRecorder!.isRecording {
            // Stop the recording
            audioRecorder?.stop()
            
            // Change button title to Record
            
        } else {
            // Start the recording
            audioRecorder?.record()
            
            // Change the button title to Stop
            btnRecord.setTitle ("Stop", for: .normal)
        }
    }
    
    @IBAction func btnPlay(_ sender: Any) {
    }
    
    @IBAction func btnAdd(_ sender: Any) {
    }
    
}
