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
    @State var dateOfBirth: String = ""
    @State var studyDate: String = ""
    @State var accessionNumber: String = ""
    @State var testoutput = [String]()
    @State var specificDataOutput = [String]()
    var body: some View {
        VStack {
            HStack {
                Text("Enter Information Below")
                VStack {
                    Button(action: {
                        testoutput = processInput(input: inputString)
                        specificDataOutput = getSpecificData(input: inputString)
                        assignValues(input: specificDataOutput)
                    }, label: {
                        Text("Process")
                    })
                        .padding()
                    Button(action: {
                        testoutput = []
                    }, label: {
                        Text("Clear")
                    })
                        .padding()
                    
                }
                List(testoutput, id: \.self) { outputLine in
                    Text(outputLine)
                }
                List(specificDataOutput, id: \.self) { outputLine in
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
    
    
    func getSpecificData(input: String) -> [String] {
        var outputArray = [String]()
        var filteredArray = [String]()
        let targetSubstring: [String] = ["Name", "Birth", "Study", "Accession"]
        
        let components = divideLineBreaks(input: input)
        filteredArray = targetCategory(input: components, targets: targetSubstring)
        outputArray = removeCategory(input: filteredArray)
        
        return outputArray
    }
    
    private func divideLineBreaks(input: String) -> [String] {
        // Separate by Line Breaks
        var components = input.components(separatedBy: "\n")
        // Remove Empty Elements
        components = components.filter(){$0 != ""}
        return components
    }
    
    private func targetCategory(input: [String], targets: [String]) -> [String] {
        var outputArray = [String]()
        for target in targets {
            for element in input {
                if element.contains(target) {
                    outputArray.append(element)
                }
            }
        }
        return outputArray
    }
    
    private func removeCategory(input: [String]) -> [String] {
        // Removes characters in string before ": "
        var outputArray = [String]()
        for item in input {
            if item.contains(": ") {
                var stringArray = item.components(separatedBy: ": ")
                _ = stringArray.removeFirst()
                let outputString = stringArray.joined(separator: "")
                outputArray.append(outputString)
            }
        }
        return outputArray
    }
    
    func assignValues(input: [String]) {
        name = input[0]
        dateOfBirth = input[1]
        studyDate = input[2]
        accessionNumber = input[3]
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
            // after the @-sign, and check that it???s non-empty.
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
