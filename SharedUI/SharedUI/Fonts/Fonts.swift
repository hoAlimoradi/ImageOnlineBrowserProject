//
//  Fonts.swift
//  SharedUI
//
//  Created by hoseinAlimoradi on 6/28/23.
//

import UIKit
import Foundation

public struct Fonts {
    public struct FontSize {
        public static let headingXXSize = CGFloat(60)
        public static let headingXSize = CGFloat(44)
        public static let headingsSize = CGFloat(24)
        public static let titleSize = CGFloat(16)
        public static let subtitleSize = CGFloat(14)
        public static let smallSubtitleSize = CGFloat(12)
        public static let largeBodySize = CGFloat(16)
        public static let bodySize = CGFloat(14)
        public static let smallBodySize = CGFloat(12)
        public static let buttonSize = CGFloat(14)
        public static let largeButtonSize = CGFloat(16)
        public static let smallButtonSize = CGFloat(12)
        public static let captionSize = CGFloat(10)
        public static let overlineSize = CGFloat(8)
    }

    public struct FontName {
        public static let regularSFProUIFontName = "SFProDisplay-Regular"
        public static let regularItalicSFProUIFontName = "SFProDisplay-RegularItalic"

        public static let ultralightSFProUIFontName = "SFProDisplay-Ultralight"
        public static let ultralightItalicSFProUIFontName = "SFProDisplay-UltralightItalic"

        public static let thinSFProUIFontName = "SFProDisplay-Thin"
        public static let thinItalicSFProUIFontName = "SFProDisplay-ThinItalic"

        public static let lightSFProUIFontName = "SFProDisplay-Light"
        public static let lightItalicSFProUIFontName = "SFProDisplay-LightItalic"

        public static let mediumSFProUIFontName = "SFProDisplay-Medium"
        public static let mediumItalicSFProUIFontName = "SFProDisplay-MediumItalic"

        public static let semiBoldSFProUIFontName = "SFProDisplay-Semibold"
        public static let semiBoldItalicSFProUIFontName = "SFProDisplay-SemiboldItalic"

        public static let boldSFProUIFontName = "SFProDisplay-Bold"
        public static let boldItalicSFProUIFontName = "SFProDisplay-BoldItalic"

        public static let heavySFProUIFontName = "SFProDisplay-Heavy"
        public static let heavyItalicSFProUIFontName = "SFProDisplay-HeavyItalic"

        public static let blackSFProUIFontName = "SFProDisplay-Black"
        public static let blackItalicSFProUIFontName = "SFProDisplay-BlackItalic"
    }

    public struct Headings {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.headingsSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)

        public static let boldx = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.headingXSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
        public static let boldxx = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.headingXXSize) ?? UIFont.systemFont(ofSize: FontSize.headingsSize)
    }

    public struct Title {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.titleSize)
    }

    public struct Subtitle {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.subtitleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.subtitleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.subtitleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.subtitleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.subtitleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.subtitleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.subtitleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.subtitleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.titleSize) ?? UIFont.systemFont(ofSize: FontSize.subtitleSize)
    }

    public struct SmallSubtitle {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
        
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.smallSubtitleSize) ?? UIFont.systemFont(ofSize: FontSize.smallSubtitleSize)
    }

    public struct LargeBody {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
        
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.largeBodySize) ?? UIFont.systemFont(ofSize: FontSize.largeBodySize)
    }

    public struct Body {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.bodySize) ?? UIFont.systemFont(ofSize: FontSize.bodySize)
    }
    
    public struct SmallBody {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
        
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.smallBodySize) ?? UIFont.systemFont(ofSize: FontSize.smallBodySize)
    }

    public struct LargeButton {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
        
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
        
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
        
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.largeButtonSize) ?? UIFont.systemFont(ofSize: FontSize.largeButtonSize)
    }

    public struct Button {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.buttonSize) ?? UIFont.systemFont(ofSize: FontSize.buttonSize)
    }

    public struct SmallButton {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.smallButtonSize) ?? UIFont.systemFont(ofSize: FontSize.smallButtonSize)
    }

    public struct Caption {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.captionSize) ?? UIFont.systemFont(ofSize: FontSize.captionSize)
    }

    public struct Overline {
        public static let regular = UIFont(name: FontName.regularSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
        
        public static let regularItalic = UIFont(name: FontName.regularItalicSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)

        public static let ultralight = UIFont(name: FontName.ultralightSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
        
        public static let ultralightItalic = UIFont(name: FontName.ultralightItalicSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)

        public static let thin = UIFont(name: FontName.thinSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
        
        public static let thinItalic = UIFont(name: FontName.thinItalicSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)

        public static let light = UIFont(name: FontName.lightSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
        
        public static let lightItalic = UIFont(name: FontName.lightItalicSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)

        public static let medium = UIFont(name: FontName.mediumSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
        
        public static let mediumItalic = UIFont(name: FontName.mediumItalicSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)

        public static let semiBold = UIFont(name: FontName.semiBoldSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
        public static let semiBoldItalic = UIFont(name: FontName.semiBoldItalicSFProUIFontName, size: FontSize.overlineSize)!

        public static let bold = UIFont(name: FontName.boldSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
        public static let boldItalic = UIFont(name: FontName.boldItalicSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)

        public static let heavy = UIFont(name: FontName.heavySFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
        public static let heavyItalic = UIFont(name: FontName.heavyItalicSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)

        public static let black = UIFont(name: FontName.blackSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
        public static let blackItalic = UIFont(name: FontName.blackItalicSFProUIFontName, size: FontSize.overlineSize) ?? UIFont.systemFont(ofSize: FontSize.overlineSize)
    }
}

extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let newDescriptor = fontDescriptor.addingAttributes([.traits: [
            UIFontDescriptor.TraitKey.weight: weight]
                                                            ])
        return UIFont(descriptor: newDescriptor, size: pointSize)
    }
}


