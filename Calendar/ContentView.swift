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
                    
                    Button(action: { withAnimation { viewModel.showYearPicker.toggle() } } ) {
                        Text(viewModel.currentMonth.formatted(.dateTime.month().year()))
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(viewModel.secondaryColor)
                                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                            )
                    }
                    
                    Button(action: { viewModel.moveMonth(by: -1)}) {
                        Image(systemName: "chevron.right")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(viewModel.accentGradient)
                            .clipShape(Circle())
                            .shadow(color: viewModel.primaryColor, radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    ForEach(viewModel.dayOfWeek, id: \.self) { day in
                        Text(day)
                            .font(.caption.bold())
                            .foregroundColor(viewModel.primaryColor)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(viewModel.secondaryColor.opacity(0.7))
                        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                )
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                    ForEach(viewModel.daysInMonth, id: \.self) { date in
                        if let date = date {
                            Text(date.formatted(.dateTime.day()))
                                .font(.system(.body, design: .rounded).bold())
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        if viewModel.isDateSelected(date) {
                                            Circle()
                                                .fill(viewModel.accentGradient)
                                                .shadow(color: viewModel.primaryColor, radius: 2, x: 0, y: 1)
                                        } else if viewModel.isDateToday(date){
                                            Circle()
                                                .stroke(viewModel.primaryColor, lineWidth: 1)
                                        }
                                    }
                                )
                                .foregroundColor(viewModel.isDateSelected(date) ? .white : viewModel.textColor)
                                .scaleEffect(viewModel.isDateSelected(date) ? 1.1 : 1)
                                .onTapGesture {
                                    viewModel.selectedDate(date)
                                }
                        } else {
                            Text("")
                                .frame(height: 50)
                        }
                    }
                }
                .padding()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 5)
            )
            .padding()
            
            if viewModel.showYearPicker {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            viewModel.showYearPicker = false
                        }
                    }
                VStack {
                    YearPickerView (
                        selectedYear: viewModel.currentYear,
                        yearRange: viewModel.yearRange,
                        onYearSelected: viewModel.selectedDate)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, -40)
            }
        }
    }
}

#Preview {
    ContentView()
}
