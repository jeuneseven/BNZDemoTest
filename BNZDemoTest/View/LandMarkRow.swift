//
//  LandMarkRow.swift
//  BNZDemoTest
//
//  Created by seven on 2026/1/22.
//

import SwiftUI

struct LandMarkRow: View {
    let landmark: LandMark
        
    var body: some View {
        HStack(spacing: 12) {
            // Placeholder image
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.green.opacity(0.3))
                Image(systemName: categoryIcon)
                    .font(.title2)
                    .foregroundStyle(.green)
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(landmark.name ?? "Unknown")
                        .font(.headline)
                    
                    if landmark.isFavorite == true {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.caption)
                    }
                }
                
                Text(landmark.park ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundStyle(.red)
                        .font(.caption)
                    Text("\(landmark.city ?? ""), \(landmark.state ?? "")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            if landmark.isFeatured == true {
                Text("Featured")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .foregroundStyle(.blue)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 4)
    }
    
    private var categoryIcon: String {
        switch landmark.category?.lowercased() {
        case "lakes":
            return "water.waves"
        case "rivers":
            return "drop.fill"
        case "mountains":
            return "mountain.2.fill"
        default:
            return "leaf.fill"
        }
    }
}

//#Preview {
//    LandMarkRow()
//}
