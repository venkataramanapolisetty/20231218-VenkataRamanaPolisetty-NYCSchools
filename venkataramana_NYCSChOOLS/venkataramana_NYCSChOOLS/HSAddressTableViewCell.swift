//
//  HSAddressTableViewCell.swift
//  NYC SCHOOLS
//  Created by venkataramana Polisetty on 18/12/23.


import UIKit
import MapKit

class HSAddressTableViewCell: UITableViewCell {

    @IBOutlet var hsAddressMapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func addHSAnnotaionWithCoordinates(_ hsCoordinates: CLLocationCoordinate2D){
        
        let highSchoolAnnotation = MKPointAnnotation()
        highSchoolAnnotation.coordinate = hsCoordinates
        self.hsAddressMapView.addAnnotation(highSchoolAnnotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: highSchoolAnnotation.coordinate, span: span)
        let adjustRegion = self.hsAddressMapView.regionThatFits(region)
        self.hsAddressMapView.setRegion(adjustRegion, animated:true)
    }

}
