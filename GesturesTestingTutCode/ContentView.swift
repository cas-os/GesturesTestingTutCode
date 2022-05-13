//
//  ContentView.swift
//  GesturesTestingTutCode
//
//  Created by HAL-9001 on 13/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //DragGesture_001()
        DragGesture_002()
    }
}


struct DragGesture_002: View {
    @GestureState private var isMoving: Bool = false
    @State private var rectPosition = CGPoint(x: 100, y: 100)
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Circle()
                    .fill(isMoving ? Color.red : Color.green)
                    .frame(width: 50, height: 50)
                Spacer()
                
            }
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .position(rectPosition)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                        self.rectPosition = value.location
                        })
                    // .updating binding and body passed params to check and explain
                        .updating($isMoving, body: { (value, state, transaction) in
                            state = true
                        })
                )
        }
    }
}

struct DragGesture_001: View {
    @State private var rectPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: 100)
    
    var body: some View {
        ZStack {
            ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .position(rectPosition) // position of the *center* of view
                .gesture(DragGesture()
                            .onChanged({ value in
    //                            print(".onChanged :: value :: \(value)")
    //                            print(".onChanged :: value.predictedEndLocation :: \(value.predictedEndLocation)")
                                self.rectPosition = value.location
                                    }
                            )
                            .onEnded({ value in
    //                print(".onEnded :: value.location ::  \(value.location)")
    //                print(".onEnded :: value ::  \(value)")
    //                print(".onEnded :: value.predictedEndLocation :: \(value.predictedEndLocation)")
                                    }
                            )
                            
                )
            
            VStack {
                Text("location x: \(self.rectPosition.x)")
                Text("location y: \(self.rectPosition.y)")
            }
            }
            

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
