//
//  ResultViewController.swift
//  iWeather
//
//  Created by Lucas on 09/03/24.
//

import UIKit

var clima: Result! = nil
var temperatura: Result! = nil
var tempCelcius: Double?
var polution: PollutionRsult! = nil


class ResultViewController: UIViewController {

    var latitude: Double?
    var longitude: Double?
    
    @IBOutlet weak var lbTemp: UILabel!
    
    @IBOutlet weak var lbWind: UILabel!
    
    @IBOutlet weak var lbPrecip: UILabel!
    
    @IBOutlet weak var lbPolution: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadApiOpen()
        loadPolution()
        
        
        // Do any additional setup after loading the view.
    }

    
    func loadApiOpen() {
        let longFormat = Double(String(format: "%.2f", longitude ?? 0))
        let latiFormat = Double(String(format: "%.2f", latitude ?? 0))
        print("long é \(longFormat ?? 0)")
        print("lati é \(latiFormat ?? 0)")
        
        let jsonUrlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latiFormat ?? 0)&lon=\(longFormat ?? 0)&appid=aa91f2552e6abed051cdaca3df261c9c"
        let url = URL(string: jsonUrlString)
        
        //fazendo a busca
        URLSession.shared.dataTask(with: url!) { data, response, error
            in guard let data = data else {return}
            
            do{
                clima = try JSONDecoder().decode(Result.self, from: data)
                temperatura = try JSONDecoder().decode(Result.self, from: data)
                
                DispatchQueue.main.sync {
                    
                    tempCelcius = Double(Int((clima.main.temp) - 273.15))
                    
                    
                    // Temperatura
                    self.lbTemp.text = String(tempCelcius ?? 0) + "ºC"
                    // velocidade vento
                    self.lbWind.text = String(clima.wind.speed)
                    // descrição do clima
                    _ = clima.weather.first?.descricao
                    if let weatherData = clima.weather.first{
                        self.lbPrecip.text = weatherData.descricao.uppercased()
                    }

                }
            }catch let jsonError {
                print("Erro de Serialização !", jsonError)
            }
        }
        //Executando o que está no URLSession
        .resume()
    }
    
    func loadPolution() {
        let longFormat = Double(String(format: "%.2f", longitude ?? 0))
        let latiFormat = Double(String(format: "%.2f", latitude ?? 0))
        let jsonUrlString = "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(latiFormat ?? 0)&lon=\(longFormat ?? 0)&appid=aa91f2552e6abed051cdaca3df261c9c"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) {data, response, error in guard let data = data else {
                print("Nada recebido")
            return}
            
            do{
                polution = try JSONDecoder().decode(PollutionRsult.self, from: data)
                
                DispatchQueue.main.sync {
                    
                    if let polutionData = polution.list.first {
                        
                        switch polutionData.main.aqi {
                                case 1:
                                    self.lbPolution.text = "Good"
                                case 2:
                                    self.lbPolution.text = "Fair"
                                case 3:
                                    self.lbPolution.text = "Moderate"
                                case 4:
                                    self.lbPolution.text = "Poor"
                                default:
                                    self.lbPolution.text = "Very Poor"
                        }
                    }
                    
                }
            }catch  {
                print("Erro de Serilização !", error)
            }
            
        }
        .resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
