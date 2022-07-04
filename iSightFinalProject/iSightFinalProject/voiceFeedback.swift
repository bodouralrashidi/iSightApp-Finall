//
//  voiceFeedback.swift
//  Socket
//
//  Created by dalal aljassem on 11/20/21.
//

import Foundation
import AVFoundation

class VoiceFeedback {
    private let synthesizer = AVSpeechSynthesizer()
//    let speechToTextLabels = socket.read( " \(string) ")
//    let _phrase = speechToTextLabels.joined(separator: " ")
    func say(_phrase:String){
        let utterance = AVSpeechUtterance(string: _phrase)
        synthesizer.speak(utterance)
    }
}
//speechService.say  = ("Say whatever we want")

//let speechToTextLabels = ["Hi", "Hello"]
//let joinedLabel = speechToTextLabels.joined(separator: " ")
//
//let utterance = AVSpeechUtterance(string: joinedLabel)
//utterance.voice = AVSpeechSynthesisVoice(language: "en-gb")
//let synthesizer = AVSpeechSynthesizer()
//DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//    synthesizer.speak(utterance)
//}
//}
