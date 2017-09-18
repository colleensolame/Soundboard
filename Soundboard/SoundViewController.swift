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
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var txtSoundName: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var audioURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        playButton.isEnabled = false
        addButton.isEnabled = false
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
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            // Create settings for the audio recorder
            var settings: [String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            // Create audioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
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
            btnRecord.setTitle ("Record", for: .normal)
            
            playButton.isEnabled = true
            addButton.isEnabled = true
            
        } else {
            // Start the recording
            audioRecorder?.record()
            
            // Change the button title to Stop
            btnRecord.setTitle ("Stop", for: .normal)
        }
    }
    
    @IBAction func btnPlay(_ sender: Any) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch {
            
        }
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let sound = Sound(context: context)
        sound.name = txtSoundName.text
        sound.audio = NSData(contentsOf: audioURL!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
}
