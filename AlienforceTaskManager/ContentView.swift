//
//  ContentView.swift
//  AlienforceTaskManager
//
//  Created by Fernando Florez on 22/07/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingHome = false
    var body: some View {
        NavigationView {
            ZStack {
                Color("black0C")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    ZStack {
                        ZStack {
                            GeometryReader { geometry in
                                Path { path in
                                    let width = geometry.size.width
                                    let height = geometry.size.height
                                    
                                    let cornerSize: CGFloat = 40
                                    let rightHeight: CGFloat = height - 50
                                    
                                    path.move(to: CGPoint(x: width / 2, y: 0))
                                    path.addLine(to: CGPoint(x: width, y: 0))
                                    
                                    path.addLine(to: CGPoint(x: width, y: rightHeight))
                                    path.addArc(center: CGPoint(x: width - cornerSize, y: rightHeight - cornerSize), radius: cornerSize, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                                    
                                    path.addLine(to: CGPoint(x: cornerSize, y: height))
                                    path.addArc(center: CGPoint(x: cornerSize, y: height - cornerSize), radius: cornerSize, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                                    
                                    path.addLine(to: CGPoint(x: 0, y: 0))
                                }.fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color("purpleDD"),
                                            Color("purpleCF"),
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                            }
                            .frame(height: 500)
                            
                            Image("big3dCircle")
                                .resizable()
                                .frame(width: 300, height: 340)
                        }
                        
                        ZStack(alignment: .topTrailing) {
                            Color.clear.frame(height: 500)
                            
                            Image("topClouds")
                                .resizable()
                                .frame(width: 100, height: 80)
                                .padding(.top, 20)
                                .padding(.trailing, 20)
                                .rotationEffect(Angle(degrees: -10))
                        }
                        
                        ZStack(alignment: .bottomLeading) {
                            Color.clear.frame(height: 500)
                            
                            Text("☁️")
                                .font(.system(size: 100))
                                .rotationEffect(Angle(degrees: -8))
                                .offset(x: 10, y: 50)
                        }
                    }
                    
                    Spacer()
                    
                    
                    VStack {
                        ZStack {
                            Image("dotsBackground")
                                .resizable()
                                .frame(width: 280, height: 200)
                            
                            VStack {
                                Text("Schedule tasks\nwith Alienforce")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                                Text("Manage daily tasks in\nthe blink of an eye")
                                    .foregroundColor(Color("grayAC"))
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 10)
                            }
                        }
                        Spacer()
                    
                        Button(action: {
                            isShowingHome = true
                        }) {
                            HStack {
                                LinearGradient(gradient: Gradient(colors: [
                                    Color("purpleCF"),
                                    Color("purpleDD")
                                ]), startPoint: .leading, endPoint: .trailing)
                                .overlay(
                                    Text("Sign Up")
                                        .foregroundColor(.white)
                                )
                            }
                            .frame(width: 200, height: 60)
                            .cornerRadius(30)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                .edgesIgnoringSafeArea(.top)
                
                NavigationLink(
                    destination: HomeView(),
                    isActive: $isShowingHome,
                    label: {
                        EmptyView()
                    }
                )
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
