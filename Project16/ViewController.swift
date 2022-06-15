//
//  ViewController.swift
//  Project16
//
//  Created by Olibo moni on 19/02/2022.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var mapType: MKMapType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), latitudinalMeters: CLLocationDistance(40), longitudinalMeters: CLLocationDistance(40)), animated: true)
        mapType = .satellite
        mapView.mapType = mapType
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Map", style: .plain, target: self, action: #selector(selectMap(mapViewType:)))
        
            let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
            let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
            let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
            let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
            let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
            
        mapView.addAnnotations([london, oslo, paris, rome, washington] )
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil}
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.markerTintColor = .cyan
            annotationView?.animatesWhenAdded = true
            annotationView?.glyphImage = UIImage(systemName: "cross")
            annotationView?.canShowCallout = true
            
            
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped: UIControl){
        guard let capital = view.annotation as? Capital else { return}
        let vc = DetailVC()
        vc.capital = capital
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Visit Wikepedia page", style: .default, handler: { _ in
            self.navigationController?.pushViewController(vc, animated: true)
        }))
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(ac, animated: true)
    }
    
    @objc func selectMap(mapViewType: MKMapType){
       
        let ac = UIAlertController(title: "Select Map", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { _ in
            self.mapView.mapType = .standard
        }))
        ac.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: { _ in
            self.mapView.mapType = .hybridFlyover
        }))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { _ in
            self.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { _  in
            self.mapView.mapType = .hybrid
        }))
        ac.addAction(UIAlertAction(title: "Muted Standard", style: .default, handler: { _ in
            self.mapView.mapType = .mutedStandard
        }))
        ac.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: { _ in
            self.mapView.mapType = .satelliteFlyover
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let popOver = ac.popoverPresentationController
        popOver?.sourceView = view
        //popOver?.sourceRect = CGRect(x: <#T##Int#>, y: <#T##Int#>, width: <#T##Int#>, height: <#T##Int#>)
        present(ac, animated: true, completion: nil)
        
        
        
    }
    


}

