//
//  ContentView.swift
//  GesturesTestingTutCode
//
//  Created by HAL-9001 on 13/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DragGesture_004()
        
    }
}


struct DragGesture_004: View {
    @State private var siderPosition: CGFloat = 50 - UIScreen.main.bounds.width
    @GestureState private var offset = CGSize.zero
    
    
    
    var body: some View {
        GeometryReader { geoProxy in
            VStack {
                Text("test_001")
                    .font(.largeTitle)
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "line.horizontal.3")
//                        .font(.largeTitle)
//                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(90))
//                        .foregroundColor(Color.orange)
//                        .background(Color.blue)
                    Spacer()
                }
                .foregroundColor(.white)
                .frame(height: 100)
                .padding()
                .background {
                    ZStack {
                        Rectangle().fill(Color.orange).offset(x: -100)
//                            .fill(Color.orange)
//                            .offset(x: -100)
                        Capsule().fill(Color.orange)
                    }
                }
//                Spacer()
            }
        }
//        RoundedRectangle(cornerRadius: 20)
//            .fill(Color.orange)
//            .frame(width: 100, height: 100)
        
        
        
    }
}

struct DragGesture_003: View {
    @State private var rectPosition = CGPoint(x: 100, y: 100)
    @State private var overlapping = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .stroke(overlapping ? Color.red : Color.clear, style: StrokeStyle(lineWidth: overlapping ? 40 : 0))
            .edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 20)
            //    .frame(width: 100, height: 100)
                .strokeBorder(Color.orange, style: StrokeStyle(lineWidth: overlapping ? 2 : 0))
                .background(overlapping ? Color.clear : Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 100, height: 100)
                .position(rectPosition)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.rectPosition = value.location
                        })
                        .onEnded({ value in
                            // if position is too far beyond 'border' it is not possible to move rectangle back. why ?
                            if value.location.x < UIScreen.main.bounds.minX + 50 ||
                                value.location.x > UIScreen.main.bounds.maxX - 50 ||
                                value.location.y < UIScreen.main.bounds.minY + 50 ||
                                value.location.y > UIScreen.main.bounds.maxY - 50 {
                                self.overlapping = true
                            } else {
                                self.overlapping = false
                            }
                        })
                )
        }

        
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
