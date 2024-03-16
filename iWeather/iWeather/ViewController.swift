//
//  ViewController.swift
//  iWeather
//
//  Created by Lucas on 08/03/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var latitude: Double?
    var longitude: Double?
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var Search: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar CLLocationManager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Solicitar permissão de localização quando o app estiver em uso
        
    }


    @IBAction func btSearch(_ sender: UIButton) {
        //view.endEditing(true)
       
        if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
                // Iniciar atualização de localização
                locationManager.startUpdatingLocation()
            performSegue(withIdentifier: "next", sender: nil)
            
        } else {
                // Exibi um erro  se a permissão de localização não for concedida
            print("Permissão não concedida")
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                   print("Erro ao obter a localização: \(error.localizedDescription)")
               }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        
        manager.stopUpdatingLocation()
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        
        latitude = location.coordinate.latitude
        longitude = (location.coordinate.longitude)
       
        print(latitude ?? 0)
        print(longitude ?? 0)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            //Enviando para a próxima tela ResultViewController
            if let nextResultVC = segue.destination as? ResultViewController {
                nextResultVC.latitude = latitude 
                nextResultVC.longitude = longitude
            }
            
            
        }
    }
    
    
}

