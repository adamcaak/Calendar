//
//  YearPickerView.swift
//  Calendar
//
//  Created by Łukasz Adamczak on 16/06/2025.
//
import Foundation
import SwiftUI

struct YearPickerView: View {
    let selectedYear: Int
    let yearRange: ClosedRange<Int>
    let onYearSelected: (Int) -> Void
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(yearRange, id: \.self) { year in
                        Button(action: { onYearSelected(year)}) {
                            .font(.system(.body, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius(10))
                                    .fill(year == selectedYear ? Color.blue.opacity(0.2) : Color.clear)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .frame(height: 200)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
        .padding()
    }
}

