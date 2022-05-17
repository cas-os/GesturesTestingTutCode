//
//  ContentView.swift
//  GesturesTestingTutCode
//
//  Created by HAL-9001 on 13/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DragGesture_008()
        
    }
}

// MARK - to check difference between .animation (deprecated in iOS 15.0) vs .withanimation ..?


struct DragGesture_008: View {
    @State private var maxHeight: CGFloat = 200
    @State private var sliderProgress: CGFloat = 0
    @State private var sliderHeight: CGFloat = 0
    @State private var currentSliderValue: CGFloat = 0
    
    private var labelHeight: CGFloat = 50
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                Rectangle()
                    .fill(Color.white)
                    .frame(height: sliderHeight)
            }
            .frame(width: 70, height: maxHeight)
            .cornerRadius(40)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 2)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: -2, y: -2)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let translation = value.translation
                        sliderHeight = -translation.height + currentSliderValue
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        
                        sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                        let progress = sliderHeight / maxHeight
                        sliderProgress = progress <= 1.0 ? progress : 1
                    })
                    .onEnded({ value in
                        sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                        sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                        currentSliderValue = sliderHeight
                    })
            )
            .overlay(
                Image(systemName: (sliderHeight / maxHeight > 0.5 ? "sun.max.fill" : "sun.min.fill"))
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn)
                ,alignment: .bottom
            )
        }
    }
}


struct DragGesture_007: View {
    @State private var minValue: Float = 0.0
    @State private var maxValue: Float = Float(UIScreen.main.bounds.width - 50.0)
    
    var body: some View {
        VStack {
            Text("RangeSlider")
            DTRangeSlider_007(
                minValue: $minValue,
                maxValue: $maxValue,
                sliderWidth: CGFloat(maxValue),
                globeMinMaxValuesColor: .black
            )
        }
    }
}
struct DTRangeSlider_007: View {
    @Binding var minValue: Float
    @Binding var maxValue: Float
    
    @State var sliderWidth: CGFloat = 0.0
    @State var backgroundTrackColor = Color.green.opacity(0.3)
    @State var selectedTrackColor = Color.orange
    
    @State var globeColor = Color.gray
    @State var globeBackgroundColor = Color.black
    
    @State var globeMinMaxValuesColor = Color.black
    
    var body: some View {
        VStack {
            HStack {
                Text("0")
                    .offset(x: 28, y: 20)
                    .frame(width: 30, height: 30, alignment: .leading)
                    .foregroundColor(globeMinMaxValuesColor)
                
                Spacer()
                
                Text("100")
                    .offset(x: -18, y: 20)
                    .frame(width: 30, height: 30, alignment: .trailing)
                    .foregroundColor(globeMinMaxValuesColor)
                
            }
            .padding()
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Capsule()
                    .fill(backgroundTrackColor)
                    .frame(width: CGFloat(sliderWidth + 10), height: 20, alignment: .center)
                Capsule()
                    .fill(selectedTrackColor)
                    .offset(x: CGFloat(minValue))
                    .frame(width: CGFloat(maxValue - minValue), height: 20)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(globeColor)
                        .frame(width: 40, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10).stroke(globeBackgroundColor, lineWidth: 2))
                        .offset(x: CGFloat(minValue))
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    if value.location.x > 8 && value.location.x <= self.sliderWidth && value.location.x < CGFloat(maxValue - 30) {
                                        minValue = Float(value.location.x - 8)
                                    }
                                }
                                )
                        )
                    Text(String(format: "%.0f", (CGFloat(minValue) / sliderWidth) * 100))
                        .offset(x: CGFloat(minValue))
                        .multilineTextAlignment(.center)
                        .frame(width: 30, height: 30)
                        .foregroundColor(globeMinMaxValuesColor)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(globeColor)
                        .frame(width: 40, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(globeBackgroundColor, lineWidth: 2))
                        .offset(x: CGFloat(maxValue - 18))
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    if value.location.x - 8 <= sliderWidth && value.location.x > CGFloat(minValue + 50) {
                                        maxValue = Float(value.location.x - 8)
                                    }
                                })
                        )
                        
                }
                Text(String(format: "%.0f", (CGFloat(maxValue) / sliderWidth) * 100))
                    .offset(x: CGFloat(maxValue - 15))
                    .multilineTextAlignment(.center)
                    .frame(width: 30, height: 30)
                    .foregroundColor(globeMinMaxValuesColor)
            }
        }
    }
}
// MARK - DragGesture_007



struct DragGesture_006: View {
    @State private var angle: Angle = .zero
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.orange)
                .frame(width: 20, height: 20)
            Image(systemName: "arrow.right.circle.fill")
                .foregroundColor(Color.red)
                .font(.largeTitle)
                .rotationEffect(angle)
                .offset(offset)
                .gesture(
                    DragGesture(minimumDistance: 50, coordinateSpace: .local)
                        .onChanged({ (value) in
                            let translation = value.translation
                            
                            let point1 = Double(translation.width == 0 ? 0 : translation.width)
                            let point2 = Double(translation.height)
                            
                            let a = point1 < 0 ? atan(Double(point2 / point1)) : atan(Double(point2 / point1)) - Double.pi
                            
                            // MARK - radians instead of degrees
                            //angle = Angle(degrees: a)
                            angle = Angle(radians: a)
                            offset = value.translation
                        })
                        .onEnded({ (value) in
                            angle = .zero
                            offset = .zero
                        })
                )
                .animation(.spring())
        }
    }
}

struct DragGesture_005: View {
    @GestureState private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.orange, lineWidth: 5)
                .frame(width: 100, height: 100)
            Image(systemName: "arrow.right.circle")
                .font(.largeTitle)
                .foregroundColor(.orange)
        }.offset(offset)
            .gesture(
                DragGesture(minimumDistance: 100) // minimumDistance !
//                    .updating($offset, body: {(value, state, transaction) in
                    .updating($offset, body: {(value, state, _) in
                        state = value.translation
                        
                    })
                
            )
            .animation(.spring())
        
        
    }
}

struct DragGesture_004: View {
    @State private var sliderPosition: CGFloat = 50 - UIScreen.main.bounds.width
    @GestureState private var offset = CGSize.zero
    
    
    
    var body: some View {
        GeometryReader { geoProxy in
            VStack {
//                Text("test_001")
//                    .font(.largeTitle)
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "line.horizontal.3")
                        .rotationEffect(.degrees(90))
//                    Spacer()
                }
                .foregroundColor(.white)
                .frame(height: 100)
                .padding()
                .background(
                    ZStack {
                        Rectangle().fill(Color.orange).offset(x: -100)
                        Capsule().fill(Color.orange)
                    }
                )
                .offset(x: sliderPosition + offset.width)
                .gesture(
                    DragGesture()
                        .updating($offset, body: { (value, state, transaction) in //????
                            state = value.translation
                        })
                        .onEnded({ value in
                            if value.translation.width < -geoProxy.size.width * 0.4 {
                                sliderPosition = 50 - geoProxy.size.width
                            } else {
                                sliderPosition = 0
                            }
                                
                        })
                )
                .animation(.spring())
                
                //Spacer()
            }
        }
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
