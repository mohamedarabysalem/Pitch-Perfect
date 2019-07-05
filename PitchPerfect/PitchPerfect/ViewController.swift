//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Mohamed El-Naggar on 12/4/18.
//  Copyright © 2018 Mohamed Elaraby. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingSoundsViewController: UIViewController {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    var audioRecorder: AVAudioRecorder!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: Any) {
        
        print("Recording Button is Pressed")
        recordingLabel.text = "Recording in Progress"
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()

        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        
        print("Recording Button is Pressed")
        recordingLabel.text = "Tap to Record"
        stopButton.isEnabled = false
        recordButton.isEnabled = true

    }

    
}

