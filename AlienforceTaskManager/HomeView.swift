//
//  HomeView.swift
//  AlienforceTaskManager
//
//  Created by Fernando Florez on 26/07/21.
//

import SwiftUI

enum SelectedView {
    case home
    case look
    case list
}

struct HomeView: View {
    @State private var sliderValue: Double = 69
    @Namespace var namespace
    
    @State private var selectedView: SelectedView = .home
    
    private let grid = [
        GridItem(.adaptive(minimum: 300, maximum: 343))
    ]
    
    @State var tasks: [TaskItemData] = TaskItemData.all
    
    var body: some View {
        ZStack {
            Color("black0C")
                .ignoresSafeArea(edges: .all)
            
            VStack {
                header
                
                ScrollView(showsIndicators: false) {
                    HStack {
                        Text("Overall Information")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(8)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Alienforce")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .gradientForeground(colors: [
                                Color("purpleDD"),
                                Color("purpleCF"),
                            ])
                            .padding(.top, 16)
                            .padding(.leading, 16)
                        
                        Text("Powered by Alphadesign")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.top, 2)
                            .padding(.leading, 16)
                        
                        HStack {
                            HStack(spacing: 0) {
                                Image("unfernaAvatar")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .shadow(radius: 8)
                                
                                Image("neriAvatar")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .shadow(radius: 8)
                                    .padding(.leading, -10)
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("69% done")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                
                                Slider(value: $sliderValue, in: 0 ... 100)
                                    .disabled(true)
                                    .accentColor(.white)
                                    
                                    .frame(maxWidth: 150)
                            }
                        }
                        .padding(16)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("grayAC").opacity(0.2))
                    .cornerRadius(10)
                    
                    HStack {
                        Text("Recent Tasks")
                            .foregroundColor(.white.opacity(0.7))
                        Spacer()
                        
                        Image(systemName: "slider.vertical.3")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            
                    }
                    .padding(.top, 10)
                    
                    LazyVGrid(columns: grid, alignment: .center) {
                        ForEach(tasks) { task in
                            TaskItem(task: task)
                                .contextMenu {
                                    Group {
                                        Button(!task.isFinished ? "Finish" : "Unfinish") {
                                            finishOrUnfinishTask(task)
                                        }
                                    }
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                
                // Tabbar
                HStack(spacing: 50) {
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .aspectRatio(contentMode: .fit)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color("purpleCF"),
                            Color("purpleDD")
                        ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .clipShape(Circle())
                        .shadow(color: Color("purpleDD"), radius: 4)
                    )
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedView = .home
                        }
                    }) {
                        VStack {
                            Image(systemName: "house")
                                .aspectRatio(contentMode: .fit)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            
                            if selectedView == .home {
                                Circle()
                                    .matchedGeometryEffect(id: "redDot", in: namespace)
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.red)
                                    .shadow(color: .red.opacity(0.7), radius: 5)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedView = .look
                        }
                    }) {
                        VStack {
                            Image(systemName: "magnifyingglass")
                                .aspectRatio(contentMode: .fit)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            
                            if selectedView == .look {
                                Circle()
                                    .matchedGeometryEffect(id: "redDot", in: namespace)
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.red)
                                    .shadow(color: .red.opacity(0.7), radius: 5)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                                        
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedView = .list
                        }
                    }) {
                        VStack {
                            Image(systemName: "doc.append")
                                .aspectRatio(contentMode: .fit)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            
                            if selectedView == .list {
                               Circle()
                                    .matchedGeometryEffect(id: "redDot", in: namespace)
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.red)
                                    .shadow(color: .red.opacity(0.7), radius: 5)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            }
        }
        .navigationBarHidden(true)
    }
    
    func finishOrUnfinishTask(_ task: TaskItemData) {
        if let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[taskIndex].isFinished.toggle()
        }
    }
    
    var header: some View {
        HStack {
            Image(systemName: "list.dash")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
                .padding()
            
            Spacer()
            Image(systemName: "bell.badge")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
                .padding()
                
        }
    }
}

struct TaskItemData: Identifiable {
    var id = UUID()
    var taskName: String
    var taskDescription: String?
    var deadline: String
    var isFinished: Bool
    
    static let all: [TaskItemData] = [
        TaskItemData(taskName: "Buy Nvidia RTX 3080", deadline: "Today", isFinished: true),
        TaskItemData(taskName: "Watch Apple Keynote", deadline: "Today", isFinished: false),
        TaskItemData(taskName: "Design Daily Shot", taskDescription: "Somethin' about RE8", deadline: "Today", isFinished: false),
        TaskItemData(taskName: "Design Daily Shot", taskDescription: "Somethin' about RE8\nlong text to prove I can resize this shit", deadline: "Today", isFinished: false),
        TaskItemData(taskName: "Design Daily Shot", taskDescription: "Somethin' about RE8\nlong text to prove I can resize this shit.\nText even larger.", deadline: "Today", isFinished: false)
    ]
}

struct TaskItem: View {
    var task: TaskItemData
    
    private var accentColor: Color {
        Color( task.isFinished ? "green3D" : "purpleDD" )
    }
    
    var body: some View {
        HStack(spacing: 25) {
            HStack(spacing: 0) {
                VStack {
                    Image(systemName: task.isFinished ? "checkmark" : "multiply")
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40, alignment: .center)
                .background(accentColor)
                .cornerRadius(20)
                .shadow(color: accentColor, radius: 5, x: 0, y: 0)
                
                VStack(alignment: .leading) {
                    Text(task.taskName)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    
                    if let desc = task.taskDescription {
                        Text(desc)
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.4))
                            .padding(.top, 1)
                    }
                }
                .padding(.leading, 16)
            }
            
            Spacer()
            if task.isFinished {
                Text("Finished")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .gradientForeground(colors: [
                        Color("purpleDD"),
                        Color("purpleCF"),
                    ])
            
            } else {
                Text(task.deadline)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .padding()
        .background(Color("grayAC").opacity(0.2))
        .cornerRadius(10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        overlay(
            LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .mask(self)
    }
}
