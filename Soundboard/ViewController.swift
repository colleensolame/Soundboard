//
//  ViewController.swift
//  Soundboard
//
//  Created by Colleen Ng on 9/15/17.
//  Copyright © 2017 ZND Code. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sounds: [Sound] = []
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var soundTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        soundTableView.dataSource = self
        soundTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try sounds = context.fetch(Sound.fetchRequest())
            soundTableView.reloadData()
        } catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let sound = sounds[indexPath.row]
        cell.textLabel?.text = sound.name
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = sounds[indexPath.row]
        do {
            try audioPlayer = AVAudioPlayer(data: sound.audio! as Data)
            audioPlayer!.play()
        } catch {
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sound = sounds[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(sound)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                try sounds = context.fetch(Sound.fetchRequest())
                soundTableView.reloadData()
            } catch {}
            
        }
    }
}

