//
//  ContentView.swift
//  Calculator
//
//  Created by Dhiman on 2023-03-20.
//

import SwiftUI

struct ContentView: View {
    
    let grid = [
    ["AC","C","%","/"],
    ["7","8","9","X"],
    ["4","5","6","-"],
    ["1","2","3","+"],
    [".","0","","="]
    ]
    
    let operatore = ["/","+","X","%"]
    @State var visibleWorking = ""
   @State var visibleResult = ""
    @State var showAlert = false
    
    var body: some View {
        
        VStack{
            HStack{
                Spacer()
                Text(visibleWorking).padding()
                    .foregroundColor(Color.white)
                    .font(.system(size: 30,weight: .heavy))
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
            
            HStack{
                Spacer()
                Text(visibleResult).padding()
                    .foregroundColor(Color.white)
                    .font(.system(size: 30,weight: .heavy))
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
            
            ForEach(grid, id: \.self){
                row in
                HStack{
                    ForEach(row,id: \.self){
                        cell in
                        Button(action: {buttonPressed(cell: cell)}, label: {
                            Text(cell)
                                .foregroundColor(buttonColor(cell))
                                .font(.system(size: 40,weight: .heavy))
                                .frame( maxWidth: .infinity,maxHeight: .infinity)
                        })
                    }
                }
            }
            
        }.background(Color.black.ignoresSafeArea())
            .alert(isPresented: $showAlert){
                Alert(
                    title: Text("Inavlid Input"),
                message: Text(visibleWorking),
                        dismissButton: .default(Text("Okay")))
            }
    }
    
    func buttonColor(_ cell: String) -> Color
    {
        if(cell == "AC" || cell == "C")
        {
            return .red
        }
        
        if(cell == "-" || operatore.contains(cell)){
            return .orange
        }
        
        return .white
    }
    
    
    func buttonPressed(cell: String){
        
        switch cell {
        case "AC":
            visibleWorking = ""
            visibleResult = ""
        case "C":
            visibleWorking = String(visibleWorking.dropLast())

        case "=":
            visibleWorking = calresult()
            
        case "-":
            addMinus()
            
        case "X","/","%","+":
            addop(cell)
            
        default:
            visibleWorking += cell
        }
    }
    
    func addop(_ cell : String){
        if !visibleWorking.isEmpty
        {
            let last = String(visibleWorking.last!)
            if operatore.contains(last) || last == "-"{
                visibleWorking.removeLast()
            }
            visibleWorking += cell
        }
    }
    
    func addMinus(){
        if visibleWorking.isEmpty || visibleWorking.last! != "-"
        {
            visibleWorking += "-"
        }
    }
    
    func calresult() -> String
    {
        if(validInput())
        {
            var workings = visibleWorking.replacingOccurrences(of: "%", with: "*0.01*")
            print(workings)
            workings = workings.replacingOccurrences(of: "X", with: "*")
            let experssion  = NSExpression(format: workings)
            let result = experssion.expressionValue(with: nil, context: nil) as! Double
            
            

            return formatResult(val: result)
//            return formatResult(val: 50.0)
            
        }
        showAlert = true
        return ""
    }
    
    func validInput() -> Bool{
        if(visibleWorking.isEmpty){
            return false
        }
        let last = String(visibleWorking.last!)
        if(operatore.contains(last) || last == "-")
        {
            if(last != "%" || visibleWorking.count == 1){
                return false
            }
        }
        return true
    }
    
    func formatResult(val : Double) -> String{
        if(val.truncatingRemainder(dividingBy: 1)==0)
        {
            return String(format: "%.0f", val)
        }
        return String(format: "%.2f", val)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
