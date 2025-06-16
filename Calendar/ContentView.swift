//
//  ContentView.swift
//  Calendar
//
//  Created by Łukasz Adamczak on 16/06/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CalendarViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                HStack {
                    Button(action: { viewModel.moveMonth(by: -1)}) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(viewModel.accentGradient)
                            .clipShape(Circle())
                            .shadow(color: viewModel.primaryColor, radius: 4, x: 0, y: 2)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
