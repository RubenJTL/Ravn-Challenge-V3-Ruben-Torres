//
//  View+Extension.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import SwiftUI


enum TextStyleType {
    case largeTitle
    case largeTitleHighEmphasis
    case title1
    case title1HighEmphasis
    case title2
    case title2HighEmphasis
    case title3
    case title3HighEmphasis
    case headlineHighEmphasis
    case subheadline
    case subheadlineHighEmphasis
    case body
    case bodyHighEmphasis
    case bodyAction
    case bodyActionHighEmphasis
    case footnote
    case footnoteHighEmphasis
    case footnoteDanger
    
    
    var font: Font {
        switch self {
        case .largeTitle:
            return .system(size: 34, weight: .regular)
        case .largeTitleHighEmphasis:
            return .system(size: 34, weight: .bold)
        case .title1:
            return .system(size: 28, weight: .regular)
        case .title1HighEmphasis:
            return .system(size: 28, weight: .bold)
        case .title2:
            return .system(size: 22, weight: .regular)
        case .title2HighEmphasis:
            return .system(size: 22, weight: .bold)
        case .title3:
            return .system(size: 20, weight: .regular)
        case .title3HighEmphasis:
            return .system(size: 20, weight: .bold)
        case .headlineHighEmphasis:
            return .system(size: 17, weight: .regular)
        case .subheadline:
            return .system(size: 15, weight: .regular)
        case .subheadlineHighEmphasis:
            return .system(size: 15, weight: .semibold)
        case .body, .bodyAction:
            return .system(size: 17, weight: .regular)
        case .bodyHighEmphasis, .bodyActionHighEmphasis:
            return .system(size: 17, weight: .semibold)
        case .footnote, .footnoteDanger:
            return .system(size: 13, weight: .regular)
        case .footnoteHighEmphasis:
            return .system(size: 13, weight: .semibold)
        }
    }
    
    var color: Color {
        switch self {
        case .bodyAction, .bodyActionHighEmphasis:
            return Color.blue
        case .footnoteDanger:
            return Color.red
        default:
            return Color.font
        }
    }
}

struct TextStyle: ViewModifier {
    let style: TextStyleType
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .foregroundColor(style.color)
    }
}

extension View {
    func textStyle(with style: TextStyleType) -> some View {
        modifier(TextStyle(style: style))
    }
}
