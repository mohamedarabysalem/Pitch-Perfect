//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Mohamed El-Naggar on 12/4/18.
//  Copyright © 2018 Mohamed Elaraby. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingSoundsViewController: UIViewController , AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func recordAudio(_ sender: Any) {
        
        configureUI(isRecording: true)

        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        
        configureUI(isRecording: false)
        
        audioRecorder.stop()
        let audio = AVAudioSession.sharedInstance()
        try! audio.setActive(false)
        
    }
    
    func configureUI(isRecording: Bool) {
        recordingLabel.text = isRecording ?  "Recording in progress" : "Tap to record"
        stopButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
    }
    
    // MARK: - Audio Recorder Delegate <-- ADD COMMENTS LIKE THIS!

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stop", sender: audioRecorder.url)
        } else {
            print("Error recording")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stop"
        {
            let vc = segue.destination as! PlaySoundsViewController
            let record = sender as! URL
            vc.recordedAudioURL = record
        }
    }
}
