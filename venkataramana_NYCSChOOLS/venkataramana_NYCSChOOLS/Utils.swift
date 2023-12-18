//
//  Utils.swift
//  NYC SCHOOLS
//  Created by venkataramana Polisetty on 18/12/23.

import Foundation
import CoreLocation
import MapKit

class Utils {
    
    /// This function will fetch the address without coodinates
    ///
    /// - Returns: Stirng, address of the high school
    static func getCompleteAddressWithoutCoordinate(_ schoolAddr: String?) -> String{
        if let schoolAddress = schoolAddr{
            let address = schoolAddress.components(separatedBy: "(")
            return address[0]
        }
        return ""
    }
    
    /// This function will fetch the coodinates for the selected High School location
    ///
    /// - Returns: CLLocationCoordinate2D, coodinate of High School location
    static func getCoodinateForSelectedHighSchool(_ schoolAddr: String?) -> CLLocationCoordinate2D?{
        if let schoolAddress = schoolAddr{
            let coordinateString = schoolAddress.slice(from: "(", to: ")")
            let coordinates = coordinateString?.components(separatedBy: ",")
            if let coordinateArray = coordinates{
                let latitude = (coordinateArray[0] as NSString).doubleValue
                let longitude = (coordinateArray[1] as NSString).doubleValue
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            }
        }
        return nil
    }
    
    
    /// This functions is used to fetch JSON payload and assign parameter to the NYCHighSchools model
    ///
    /// - Parameter json: Dictionany with Schools Detail
    /// - Returns: High School Model type
    static func getHSInfoWithJSON(_ json: [String: Any]) -> NYCHighSchools?{
        if !json.isEmpty{
            let nycHighSchools = NYCHighSchools()
            if let dbnObject = json["dbn"] as? String{
                nycHighSchools.dbn = dbnObject
            }
            
            if let schoolNameOnject = json["school_name"] as? String{
                nycHighSchools.schoolName = schoolNameOnject
            }
            
            if let overviewParagraphObject = json["overview_paragraph"] as? String{
                nycHighSchools.overviewParagraph = overviewParagraphObject
            }
            if let schoolAddressObject = json["location"] as? String{
                nycHighSchools.schoolAddress = schoolAddressObject
            }
            if let schoolTelObject = json["phone_number"] as? String{
                nycHighSchools.schoolTelephoneNumber = schoolTelObject
            }
            
            if let websiteObject = json["website"] as? String{
                nycHighSchools.schoolWebsite = websiteObject
            }
            
            return nycHighSchools
        }
        return nil
    }
    
    /// Pass the JSON and configure to the model type
    ///
    /// - Parameter highSchoolsData: Data of Array composed with Dictionary
    /// - Returns: Array of Model class
    static func fetchNYCHsWithJsonData(_ highSchoolsData: Any) -> [NYCHighSchools]?{
        guard let highSchoolsDictionaryArray = highSchoolsData as? [[String: Any]] else{
            return nil
        }
        var highSchoolModelArray = [NYCHighSchools]()
        for highSchoolsDictionary in highSchoolsDictionaryArray{
            if let highSchoolModels = Utils.getHSInfoWithJSON(highSchoolsDictionary){
                highSchoolModelArray.append(highSchoolModels)
            }
        }
        return highSchoolModelArray
    }
    
}
