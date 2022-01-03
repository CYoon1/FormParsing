//
//  ContentView.swift
//  FormParsing
//
//  Created by Christopher Yoon on 1/2/22.
//

import SwiftUI

struct ContentView: View {
    @State var inputString: String = ""
    @State var name: String = ""
    @State var empi: String = ""
    @State var reasonForVisit: String = ""
    @State var procedure: String = ""
    @State var testoutput: [String] = []
    var body: some View {
        VStack {
            HStack {
                Text("Enter Information Here")
                Button(action: {
                    testoutput = processInput(input: inputString)
                }, label: {
                    Text("Process")
                })
                List(testoutput, id: \.self) { outputLine in
                    Text(outputLine)
                }
            }
            .padding()
            ZStack {
                TextEditor(text: $inputString)
                Text(inputString).opacity(0).padding(.all, 8)
            }
            .shadow(radius: 1)
        }
    }
    
    func processInputTest(input: String) -> [String] {
        var outputArray = [String]()
        var components = input.components(separatedBy: "\n")
        components = components.filter(){$0 != ""}
        
        for component in components {
            outputArray.append(component)
            if component.contains(": ") {
                var stringArray = component.components(separatedBy: ": ")
                let category = stringArray.removeFirst()
                let outputString = stringArray.joined(separator: "")
                outputArray.append("Category: \(category)")
                outputArray.append(outputString)
            } else {
                outputArray.append("Does Not Contain Info")
            }
        }
        return outputArray
    }
    func processInput(input: String) -> [String] {
        var outputArray = [String]()
        var components = input.components(separatedBy: "\n")
        components = components.filter(){$0 != ""}
        
        for component in components {
//            outputArray.append(component)
            if component.contains(": ") {
                var stringArray = component.components(separatedBy: ": ")
                let category = stringArray.removeFirst()
                let outputString = stringArray.joined(separator: "")
                outputArray.append(outputString)
            } else {
//                outputArray.append("Does Not Contain Info")
            }
        }
        return outputArray
    }
}
extension String {
    var mentionedUsernames: [String] {
        let parts = split(separator: "@").dropFirst()

        // Character sets may be inverted to identify all
        // characters that are *not* a member of the set.
        let delimiterSet = CharacterSet.letters.inverted

        return parts.compactMap { part in
            // Here we grab the first sequence of letters right
            // after the @-sign, and check that it’s non-empty.
            let name = part.components(separatedBy: delimiterSet)[0]
            return name.isEmpty ? nil : name
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
