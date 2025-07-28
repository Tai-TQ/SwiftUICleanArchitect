//
//  CountryItemView.swift
//  Demo
//
//  Created by truong.quoc.tai on 8/1/25.
//

import SwiftUI

struct CountryItemView: View {
    let item: CountryModel
    
    var body: some View {
        HStack(spacing: 12) {
            // Flag Section
            AsyncImage(url: URL(string: item.flagURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.clear
            }
            .frame(width: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            
            // Content Section
            VStack(alignment: .trailing, spacing: 6) {
                // Country Names
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.commonName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    if item.commonName != item.officialName {
                        Text(item.officialName)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.secondaryColor)
                            .lineLimit(1)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Info Row
                HStack(spacing: 16) {
                    // Capital
                    if !item.capital.isEmpty {
                        HStack(spacing: 4) {
                            Image(systemName: "building.2.fill")
                                .foregroundColor(.blue)
                            Text(item.capital.first ?? "")
                                .foregroundColor(.secondaryColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    // Currency
                    if let firstCurrency = item.currencies.first {
                        HStack(spacing: 4) {
                            Image(systemName: "dollarsign.circle.fill")
                                .foregroundColor(.green)
                            Text(firstCurrency.value.symbol)
                                .fontWeight(.medium)
                                .foregroundColor(.secondaryColor)
                        }
                    }
                    
                    // Timezone indicator
                    if !item.timezones.isEmpty {
                        HStack(spacing: 4) {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.orange)
                            Text(item.timezones.first?.suffix(6) ?? "")
                                .foregroundColor(.secondaryColor)
                        }
                    }
                }
                .font(.system(size: 13))
                .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondaryColor)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    CountryItemView(item: CountryModel.mock())
}
