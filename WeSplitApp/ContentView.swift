//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Neshwa on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPrecentage = 20
    @FocusState private var amountFocused : Bool
    let tippercentages = [10, 15, 20, 25, 0]
    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var totalPerPerson : Double {
        let countOfPeople = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPrecentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountperPerson = grandTotal / countOfPeople
        return amountperPerson
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountFocused)
                
                    Picker("Number OF People",selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPrecentage) {
                        ForEach(tippercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .padding(.vertical, 3)
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(currencyFormatter.string(from: NSNumber(value: totalPerPerson)) ?? "")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
