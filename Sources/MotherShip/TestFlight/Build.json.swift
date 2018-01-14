//
//  Build.json.swift
//  MotherShip
//
//  Created by Cavelle Benjamin on 18-Jan-14 (02).
//

import Foundation

public struct BuildDetails: Codable {
  public let data: BuildDetail
}

public struct BuildDetail: Codable {
  public let id: BuildIdentifier
  public let bundleId: String
  public let trainVersion: Version
  public let buildVersion: BuildNumber
  public let uploadDate: String
  public let appAdamId: AppIdentifier
  public let providerId: TeamIdentifier
  public let providerName: String
  public let developerName: String
  public let sizeInBytes: Int64
  public let internalExpireTime: String
  public let externalExpireTime: String
  public let platform: String
  public let minOsVersion: String
  public let iconAssetToken: String
  public let inviteCount: Int
  public let installCount: Int
  public let activeTesterCount: Int
  public let crashCount: Int
  public let internalState: String
  public let externalState: String
  public let binaryState: String
  public let autoNotifyEnabled: Bool
  public let didNotify: Bool
  public struct Name: Codable {
    public let enUS: String
    private enum CodingKeys: String, CodingKey {
      case enUS = "en-US"
    }
  }
  public let name: Name
//  public struct Capabilities: Codable {
//    public let armv7: Bool
//  }
//  public let capabilities: Capabilities
//  public struct Profiles: Codable {
//    public let hFXFKGB6U5ComSeedsofcodePrettyRandom: String
//    private enum CodingKeys: String, CodingKey {
//      case hFXFKGB6U5ComSeedsofcodePrettyRandom = "HFXFKGB6U5.com.seedsofcode.PrettyRandom"
//    }
//  }
//  public let profiles: Profiles
//  public struct DeviceFamiliesForProfiles: Codable {
//    public let hFXFKGB6U5ComSeedsofcodePrettyRandom: [Int]
//    private enum CodingKeys: String, CodingKey {
//      case hFXFKGB6U5ComSeedsofcodePrettyRandom = "HFXFKGB6U5.com.seedsofcode.PrettyRandom"
//    }
//  }
//  public let deviceFamiliesForProfiles: DeviceFamiliesForProfiles
//  public let deviceFamilies: [String]
  public let defaultLocale: LocaleIdentifier
//  public let assetToken: String?
  public let copyright: String
//  public struct EmbeddedBuildIconAssetTokens: Codable {
//  }
//  public let embeddedBuildIconAssetTokens: EmbeddedBuildIconAssetTokens
//  public struct EmbeddedBuildDeviceFamilies: Codable {
//  }
//  public let embeddedBuildDeviceFamilies: EmbeddedBuildDeviceFamilies
//  public struct EmbeddedBuildMinOs: Codable {
//  }
//  public let embeddedBuildMinOs: EmbeddedBuildMinOs
//  public struct EmbeddedBuildPlatform: Codable {
//  }
//  public let embeddedBuildPlatform: EmbeddedBuildPlatform
  public let betaExternalVersionId: BuildIdentifier
  public let requiresGameController: Bool
  public let iconLargeAssetToken: String
  public let messagesIconAssetToken: String?
  
  public struct ExportCompliance: Codable {
    public let usesEncryption: Bool
    public let encryptionUpdated: String?
    public let encryptionUpdatedRequired: Bool
    public let containsProprietaryCryptography: Bool
    public let containsThirdPartyCryptography: Bool
    public let availableOnFrenchStore: Bool?
    public let ccatFile: String?
    public let platform: Platform
    public let exportComplianceRequired: Bool
    public let usesNonExemptEncryptionFromPlist: Bool?
    public let status: String
    public let id: String
    public let uploadDate: String
    public let exempt: Bool
    public let codeValue: String?
  }
  
  public let exportCompliance: ExportCompliance
  
//  public struct BuildTestInfo: Codable {
//    public let locale: LocaleIdentifier
//    public let primaryLocale: Bool
//    public let description: String
//    public let feedbackEmail: String
//    public let marketingUrl: String
//    public let privacyPolicyUrl: String
//    public let whatsNew: String
//  }
  
  public let testInfo: [TestInfo]
//  public struct BetaReviewInfo: Codable {
//    public let contactFirstName: String
//    public let contactLastName: String
//    public let contactPhone: String
//    public let contactEmail: String
//    public let demoAccountName: Any?
//    public let demoAccountPassword: Any?
//    public let demoAccountRequired: Bool
//    public let notes: Any?
//  }
  public let betaReviewInfo: BetaReviewInfo
  public let eula: String?
  public let fileName: String
  public let buildSdk: String
  public let buildPlatform: String
  public let supportedArchitectures: [String]
  public let localizations: [String]
  public let newsstandApp: Bool
  public let prerenderedIconFlag: Bool
//  public struct Entitlements: Codable {
//    public struct PrettyRandomAppPrettyRandom: Codable {
//      public let applicationIdentifier: String
//      public let getTaskAllow: String
//      public let betaReportsActive: String
//      public let keychainAccessGroups: String
//      public let comAppleDeveloperTeamIdentifier: String
//      private enum CodingKeys: String, CodingKey {
//        case applicationIdentifier = "application-identifier"
//        case getTaskAllow = "get-task-allow"
//        case betaReportsActive = "beta-reports-active"
//        case keychainAccessGroups = "keychain-access-groups"
//        case comAppleDeveloperTeamIdentifier = "com.apple.developer.team-identifier"
//      }
//    }
//    public let prettyRandomAppPrettyRandom: PrettyRandomAppPrettyRandom
//    private enum CodingKeys: String, CodingKey {
//      case prettyRandomAppPrettyRandom = "PrettyRandom.app/PrettyRandom"
//    }
//  }
//  public let entitlements: Entitlements
//  public let deviceProtocols: [Any]
//  public struct SizesInBytes: Codable {
//    public struct __129InchIPadPro2ndGeneration: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let _129InchIPadPro2ndGeneration: __129InchIPadPro2ndGeneration
//    public struct IPhone4S: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone4S: IPhone4S
//    public struct IPad4Wifi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPad4Wifi: IPad4Wifi
//    public struct IPhone8: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone8: IPhone8
//    public struct IPhone7: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone7: IPhone7
//    public struct IPhone6Plus: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone6Plus: IPhone6Plus
//    public struct IPhone6sPlus: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone6sPlus: IPhone6sPlus
//    public struct IPadAirWifiCell: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadAirWifiCell: IPadAirWifiCell
//    public struct IPhone6: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone6: IPhone6
//    public struct IPadMini4WiFiCellular: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadMini4WiFiCellular: IPadMini4WiFiCellular
//    public struct IPadProWiFiCellular: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadProWiFiCellular: IPadProWiFiCellular
//    public struct IPhone5: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone5: IPhone5
//    public struct IPad3WifiCell: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPad3WifiCell: IPad3WifiCell
//    public struct IPhoneSE: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhoneSE: IPhoneSE
//    public struct __97InchIPadProCellular: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let _97InchIPadProCellular: __97InchIPadProCellular
//    public struct IPadAirWifi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadAirWifi: IPadAirWifi
//    public struct __97InchIPadPro: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let _97InchIPadPro: __97InchIPadPro
//    public struct IPadMiniWifiCell: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadMiniWifiCell: IPadMiniWifiCell
//    public struct IPadMini2WifiCell: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadMini2WifiCell: IPadMini2WifiCell
//    public struct IPadMini3WifiCell: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadMini3WifiCell: IPadMini3WifiCell
//    public struct IPhone8Plus: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone8Plus: IPhone8Plus
//    public struct IPadProWiFi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadProWiFi: IPadProWiFi
//    public struct Universal: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let universal: Universal
//    public struct IPodTouchFifthGeneration: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPodTouchFifthGeneration: IPodTouchFifthGeneration
//    public struct IPodTouchSixthGeneration: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPodTouchSixthGeneration: IPodTouchSixthGeneration
//    public struct IPad3Wifi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPad3Wifi: IPad3Wifi
//    public struct IPhone6s: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone6s: IPhone6s
//    public struct IPhone5S: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone5S: IPhone5S
//    public struct IPhoneX: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhoneX: IPhoneX
//    public struct IPadMini3Wifi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadMini3Wifi: IPadMini3Wifi
//    public struct IPad5thGeneration: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPad5thGeneration: IPad5thGeneration
//    public struct IPad23G: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPad23G: IPad23G
//    public struct IPad4WifiCell: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPad4WifiCell: IPad4WifiCell
//    public struct IPad2Wifi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPad2Wifi: IPad2Wifi
//    public struct IPadMini2Wifi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadMini2Wifi: IPadMini2Wifi
//    public struct IPhone7Plus: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone7Plus: IPhone7Plus
//    public struct __129InchIPadProWiFiCellular2ndGeneration: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let _129InchIPadProWiFiCellular2ndGeneration: __129InchIPadProWiFiCellular2ndGeneration
//    public struct IPadMini4WiFi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadMini4WiFi: IPadMini4WiFi
//    public struct IPhone5C: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPhone5C: IPhone5C
//    public struct __105InchIPadPro: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let _105InchIPadPro: __105InchIPadPro
//    public struct IPadWiFiCellular5thGeneration: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadWiFiCellular5thGeneration: IPadWiFiCellular5thGeneration
//    public struct IPadMiniWifi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadMiniWifi: IPadMiniWifi
//    public struct IPadAir2WifiCell: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadAir2WifiCell: IPadAir2WifiCell
//    public struct IPadAir2Wifi: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let iPadAir2Wifi: IPadAir2Wifi
//    public struct __105InchIPadProWiFiCellular: Codable {
//      public let uncompressed: Int
//      public let compressed: Int
//    }
//    public let _105InchIPadProWiFiCellular: __105InchIPadProWiFiCellular
//    private enum CodingKeys: String, CodingKey {
//      case _129InchIPadPro2ndGeneration = "12.9-inch iPad Pro (2nd generation)"
//      case iPhone4S = "iPhone 4S"
//      case iPad4Wifi = "iPad 4 Wifi"
//      case iPhone8 = "iPhone 8"
//      case iPhone7 = "iPhone 7"
//      case iPhone6Plus = "iPhone 6 Plus"
//      case iPhone6sPlus = "iPhone 6s Plus"
//      case iPadAirWifiCell = "iPad Air Wifi + Cell"
//      case iPhone6 = "iPhone 6"
//      case iPadMini4WiFiCellular = "iPad mini 4 WiFi + Cellular"
//      case iPadProWiFiCellular = "iPad Pro WiFi + Cellular"
//      case iPhone5 = "iPhone 5"
//      case iPad3WifiCell = "iPad 3 Wifi + Cell"
//      case iPhoneSE = "iPhone SE"
//      case _97InchIPadProCellular = "9.7-inch iPad Pro Cellular"
//      case iPadAirWifi = "iPad Air Wifi"
//      case _97InchIPadPro = "9.7-inch iPad Pro"
//      case iPadMiniWifiCell = "iPad Mini Wifi + Cell"
//      case iPadMini2WifiCell = "iPad Mini 2 Wifi + Cell"
//      case iPadMini3WifiCell = "iPad Mini 3 Wifi + Cell"
//      case iPhone8Plus = "iPhone 8 Plus"
//      case iPadProWiFi = "iPad Pro WiFi"
//      case universal = "Universal"
//      case iPodTouchFifthGeneration = "iPod Touch Fifth Generation"
//      case iPodTouchSixthGeneration = "iPod Touch Sixth Generation"
//      case iPad3Wifi = "iPad 3 Wifi"
//      case iPhone6s = "iPhone 6s"
//      case iPhone5S = "iPhone 5S"
//      case iPhoneX = "iPhone X"
//      case iPadMini3Wifi = "iPad Mini 3 Wifi"
//      case iPad5thGeneration = "iPad (5th generation)"
//      case iPad23G = "iPad 2 3G"
//      case iPad4WifiCell = "iPad 4 Wifi + Cell"
//      case iPad2Wifi = "iPad 2 Wifi"
//      case iPadMini2Wifi = "iPad Mini 2 Wifi"
//      case iPhone7Plus = "iPhone 7 Plus"
//      case _129InchIPadProWiFiCellular2ndGeneration = "12.9-inch iPad Pro Wi-Fi + Cellular (2nd generation)"
//      case iPadMini4WiFi = "iPad mini 4 WiFi"
//      case iPhone5C = "iPhone 5C"
//      case _105InchIPadPro = "10.5-inch iPad Pro"
//      case iPadWiFiCellular5thGeneration = "iPad Wi-Fi + Cellular (5th generation)"
//      case iPadMiniWifi = "iPad Mini Wifi"
//      case iPadAir2WifiCell = "iPad Air 2 Wifi + Cell"
//      case iPadAir2Wifi = "iPad Air 2 Wifi"
//      case _105InchIPadProWiFiCellular = "10.5-inch iPad Pro Wi-Fi + Cellular"
//    }
//  }
//  public let sizesInBytes: SizesInBytes
  public let containsODR: Bool
  public let numberOfAssetPacks: Int
//  public let dSYMUrl: URL
  public let includesSymbols: Bool
  public let useEncryptionInPlist: Bool
  public let exportComplianceCodeValueInPlist: Bool?
  public let hasStickers: Bool
  public let hasMessagesExtension: Bool
  public let launchProhibited: Bool
  public let usesSynapse: Bool
  public let usesLocationBackgroundMode: Bool
  public let expire: String
  public let cfBundleShortVersion: String
  public let cfBundleVersion: String
}
