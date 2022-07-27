//
//  String.swift
//  Challenge_App
//
//  Created by khaled saad on 9/25/17.
//  Copyright © 2017 Asgatech. All rights reserved.
//

import Foundation
import VUIComponents


extension String {
    
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    func toDateTime() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        //Specify Format of String to Parse
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
        dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        //Return Parsed Date
        return dateFromString
    }
    func toDateOnly() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        //Return Parsed Date
        return dateFromString
    }
    
    func toDate(format :String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let locale = (LanguageHandler.sharedInstance.currentLanguage() == .arabic) ? "ar" :"US_POSIX"
        dateFormatter.locale = Locale(identifier: locale) // set locale to reliable US_POSIX
        let dateFromString:Date = dateFormatter.date(from: self) ?? Date()
        return dateFromString
    }
    
    func convertDateString(fromFormat sourceFormat : String!, toFormat desFormat : String!) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = desFormat
        if date != nil {
            return dateFormatter.string(from: date!)
        }
        return self
    }
    func toDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self) ?? Date()
        //Return Parsed Date
        return dateFromString
    }
    func toGregorianDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self) ?? Date()
        //Return Parsed Date
        return dateFromString
    }
    func toHijriDate() -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        //Return Parsed Date
        return dateFromString
    }
    func toTime() -> Date {
        //Create Date Formatter
        let timeFormatter = DateFormatter()
        //Specify Format of String to Parse
        timeFormatter.dateFormat = "hh:mm:ss"
        //Parse into NSDate
        let timeFromString : Date = timeFormatter.date(from: self)!
        //Return Parsed Date
        return timeFromString
    }
    
    func fromSecondsStringToMinutesString() -> String {
        if let seconds = Int(self) {
            return "\(seconds / 60)"
        }
        return ""
    }
    
    func fromByteStringToMegaString() -> String {
        if let byte = Double(self) {
            let mega = byte / 1024 / 1024
            return String(format: "%.2f", mega)
        }
        return ""
    }
}
extension String {
    
    var isValidEmail: Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    public var isValidMsisdn: Bool {
        let msisdnRegEx = "^01[0-9]{9}$"
        let msisdnTest = NSPredicate(format:"SELF MATCHES %@", msisdnRegEx)
        return msisdnTest.evaluate(with: self)
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        }
        return false
    }
    
    var isPhoneNumber: Bool {
        if self.count != 8 {
            return false
        }
        if self.first == "5" && self[1] == "0"  {
            return true
        }
        return false
    }
    
    var boolValue: Bool {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return false
        }
    }
    
    func prepMsisdn() -> String {
        var msisdn = self
        // Convert Arabic MSISDN to English
        let arabicNumbers = ["٠": "0",
                             "١": "1",
                             "٢": "2",
                             "٣": "3",
                             "٤": "4",
                             "٥": "5",
                             "٦": "6",
                             "٧": "7",
                             "٨": "8",
                             "٩": "9"]
        for (key, value) in arabicNumbers {
            msisdn = msisdn.replacingOccurrences(of: key, with: value)
        }
        
        // Removing Spaces and leading +
        msisdn = msisdn.replacingOccurrences(of: " ", with: "")
        
        if msisdn.hasPrefix("+2") {
            msisdn = msisdn.replacingOccurrences(of: "+2", with: "")
        }
        
        if msisdn.hasPrefix("002") {
            let lowerBound = msisdn.index(msisdn.startIndex, offsetBy: 3)
            msisdn = String(msisdn[lowerBound...])
        }
        
        if msisdn.hasPrefix("2") {
            let lowerBound = msisdn.index(msisdn.startIndex, offsetBy: 1)
            msisdn = String(msisdn[lowerBound...])
        }
        return msisdn
    }
    
    public var initials: String {
        
        var finalString = String()
        var words = components(separatedBy: .whitespacesAndNewlines)
        
        if let firstCharacter = words.first?.first {
            finalString.append(String(firstCharacter))
            words.removeFirst()
        }
        
        if let lastCharacter = words.last?.first {
            finalString.append(String(lastCharacter))
        }
        
        return finalString.uppercased()
    }
    
    
    var intValue : Int {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        result = result.replacingOccurrences(of: " \("SAR".localized)", with:"" )
        if result.isEmpty {
            return 0
        }
        return Int(result) ?? 0
    }
    
    var floatValue : Float {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        result = result.replacingOccurrences(of: " \("SAR".localized)", with:"" )
        if result.isEmpty {
            return 0
        }
        
        return (result as NSString).floatValue
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    public var replacedEnglishDigitsWithArabic: String {
        var str = self
        let map = ["0": "٠",
                   "1": "١",
                   "2": "٢",
                   "3": "٣",
                   "4": "٤",
                   "5": "٥",
                   "6": "٦",
                   "7": "٧",
                   "8": "٨",
                   "9": "٩"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    var englishPhoneNumber : String {
        
        let arr = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        
        var result = self
        
        for int in 0...9 {
            result = result.replacingOccurrences(of: arr[int], with:String(int) )
        }
        
        return result
    }
    func localize() -> String {
        return LanguageHandler.sharedInstance.string(forKey: self)
    }
    
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    
    func makeAttributedStrForTwoLines(details: String, subDetails: String) -> NSAttributedString {
        let detailsAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let subDetailsAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        
        var detailsStr = NSMutableAttributedString()
        if subDetails.isEmpty {
            detailsStr = NSMutableAttributedString(string: "\(details)", attributes: detailsAttributes)
        }
        else {
            detailsStr = NSMutableAttributedString(string: "\(details)\n", attributes: detailsAttributes)
        }
        
        let subDetailStr = NSAttributedString(string: subDetails, attributes: subDetailsAttributes)
        detailsStr.append(subDetailStr)
        
        return detailsStr
    }
    
    func makeAttributedStrForOneLine(title: String, boldTitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: LanguageHandler.sharedInstance.string(forKey: "regularFont"), size: 14) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]
        let boldTitleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0),
                                   NSAttributedString.Key.foregroundColor: UIColor.black]
        
        var titleStr = NSMutableAttributedString()
        titleStr = NSMutableAttributedString(string: "\(title) ", attributes: titleAttributes)
        
        let boldTitleStr = NSAttributedString(string: boldTitle, attributes: boldTitleAttributes)
        titleStr.append(boldTitleStr)
        
        return titleStr
    }
    
    func makeAttributedStr(bold: Bool, color:UIColor, fontSize:CGFloat) -> NSMutableAttributedString {
        
        let fontName = (bold) ? "boldFont" : "regularFont"
        

        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: LanguageHandler.sharedInstance.string(forKey: fontName) , size: fontSize) as Any, NSAttributedString.Key.foregroundColor: color]

        
        var titleStr = NSMutableAttributedString()
        titleStr = NSMutableAttributedString(string: "\(self) ", attributes: titleAttributes)
        
        return titleStr
    }
    
    func isLandline() -> Bool {
        var isLandline = false
        
        if (self.count == 10 || self.count == 11) && !self.hasPrefix("010") && !self.hasPrefix("011") && !self.hasPrefix("012") && !self.hasPrefix("015") && !self.hasPrefix("2010") && !self.hasPrefix("2011") && !self.hasPrefix("2012") && !self.hasPrefix("2015")  {
            isLandline = true
        }
        
        return isLandline
        
    }
    
    var moneyFormat : String {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        let intVal = (self as NSString).integerValue
        let nsvalue = NSNumber(integerLiteral: intVal )
        let formattedTipAmount = formatter.string(from: nsvalue)
        return formattedTipAmount!
    }
    func convertToAttributedString(withSize size: CGFloat, andLineSpacing lineSpacing: CGFloat = 5, andColor color: UIColor = UIColor.black, andFontType fontType: String = "regularFont".localize(), andAlignment alignment: NSTextAlignment = .center) -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        let attributes = [NSAttributedString.Key.font: UIFont(name: fontType, size: size) as Any, NSAttributedString.Key.foregroundColor: color]
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    var cleanNumberString :String{
        let cleanedString = (self.components(separatedBy: CharacterSet(charactersIn: "0123456789+١٢٣٤٥٦٧٨٩٠").inverted).joined(separator: ""))
        
        let str = cleanedString.replacingOccurrences(of: "+2", with: "")
        
        let str2 = str.replacingOccurrences(of: "+", with: "")
        
        var mystr = str2
        
        if (str2.count ) > 3 {
            mystr = (str2 as NSString?)?.substring(to: 3) ?? str2
            if (mystr == "002") {
                mystr = (str2 as NSString?)?.substring(from: 3) ?? str2
                return mystr
            }
            mystr = (str2 as NSString?)?.substring(to: 2) ?? str2
            if (mystr == "20") {
                mystr = (str2 as NSString?)?.substring(from: 1) ?? str2
                return mystr
            }
            return str2
        }
        return str2
        
    }
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func convertStringtoEnglish() -> String {
        var finalString: String = self
        finalString = finalString.replacingOccurrences(of: "٠", with: "0")
        finalString = finalString.replacingOccurrences(of: "١", with: "1")
        finalString = finalString.replacingOccurrences(of: "٢", with: "2")
        finalString = finalString.replacingOccurrences(of: "٣", with: "3")
        finalString = finalString.replacingOccurrences(of: "٤", with: "4")
        finalString = finalString.replacingOccurrences(of: "٥", with: "5")
        finalString = finalString.replacingOccurrences(of: "٦", with: "6")
        finalString = finalString.replacingOccurrences(of: "٧", with: "7")
        finalString = finalString.replacingOccurrences(of: "٨", with: "8")
        finalString = finalString.replacingOccurrences(of: "٩", with: "9")
        return finalString
    }
    
    func convertStringtoArabic() -> String {
        var finalString: String = self
        finalString = finalString.replacingOccurrences(of: "0", with: "٠")
        finalString = finalString.replacingOccurrences(of: "1", with: "١")
        finalString = finalString.replacingOccurrences(of: "2", with: "٢")
        finalString = finalString.replacingOccurrences(of: "3", with: "٣")
        finalString = finalString.replacingOccurrences(of: "4", with: "٤")
        finalString = finalString.replacingOccurrences(of: "5", with: "٥")
        finalString = finalString.replacingOccurrences(of: "6", with: "٦")
        finalString = finalString.replacingOccurrences(of: "7", with: "٧")
        finalString = finalString.replacingOccurrences(of: "8", with: "٨")
        finalString = finalString.replacingOccurrences(of: "9", with: "٩")
        return finalString
    }
    
    func getContentAssetUrl() -> URL? {
        let imgName = self.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) ?? ""
        
        var imageName = NetworkPaths.getURL(type: .contentAssets, networkProtocol: .https) + imgName
        
        if NetworkPaths.getURL(type: .contentAssets).contains("qa1"){
            
            imageName = NetworkPaths.getURL(type: .contentAssets, networkProtocol: .http) + imgName
        }
        return URL(string: imageName)
        
    }
}
// MARK: App Version
extension String {
    // Modified from the DragonCherry extension - https://github.com/DragonCherry/VersionCompare
    private func compare(toVersion targetVersion: String) -> ComparisonResult {
        let versionDelimiter = "."
        var result: ComparisonResult = .orderedSame
        var versionComponents = components(separatedBy: versionDelimiter)
        var targetComponents = targetVersion.components(separatedBy: versionDelimiter)
        
        while versionComponents.count < targetComponents.count {
            versionComponents.append("0")
        }
        while targetComponents.count < versionComponents.count {
            targetComponents.append("0")
        }
        
        for (version, target) in zip(versionComponents, targetComponents) {
            result = version.compare(target, options: .numeric)
            if result != .orderedSame {
                break
            }
        }
        
        return result
    }
    
    func isVersion(equalTo targetVersion: String) -> Bool { return compare(toVersion: targetVersion) == .orderedSame }
    func isVersion(greaterThan targetVersion: String) -> Bool { return compare(toVersion: targetVersion) == .orderedDescending }
    func isVersion(greaterThanOrEqualTo targetVersion: String) -> Bool { return compare(toVersion: targetVersion) != .orderedAscending }
    func isVersion(lessThan targetVersion: String) -> Bool { return compare(toVersion: targetVersion) == .orderedAscending }
    func isVersion(lessThanOrEqualTo targetVersion: String) -> Bool { return compare(toVersion: targetVersion) != .orderedDescending }
    
    func getEnglishValueFormString() -> String? {
        let basePath = Bundle.main.path(forResource: "Base", ofType: "lproj")
        let bundle = Bundle(path: basePath!)
        let stringsPath = Bundle.main.path(forResource: "Localizable", ofType: "strings")
        
        if let dictionary = NSDictionary (contentsOfFile: stringsPath ?? "")  {
            let keys = dictionary.allKeys
            for key in keys {
                if let localizedKey = dictionary[key] as? String , localizedKey == self , let identifier = key as? String{
                    let id = bundle?.localizedString(forKey: identifier, value: identifier, table: nil) ?? ""
                    return id
                }
            }
        }
        return nil
    }
    
    func jsonToArray<T:Codable>() -> [T] {
        guard let data = Data(base64Encoded: self) else { return [] }
        guard let val = try? JSONDecoder().decode([T].self, from: data) else { return [] }
        return val
    }
}

// used for objective c
@objc extension NSString {
    public var replacedArabicDigitsWithEnglish: NSString {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) as NSString }
        return str
    }
}
