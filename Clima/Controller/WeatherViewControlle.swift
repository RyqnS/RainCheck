import UIKit
import CoreLocation
import SpriteKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel2: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    

    let skView = SKView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weatherManager.delegate = self

    
        view.addSubview(skView)
        view.insertSubview(skView,aboveSubview: background)
        
        
        skView.translatesAutoresizingMaskIntoConstraints = false
        let top = skView.topAnchor.constraint(equalTo: view.topAnchor,constant:0)
        let leading = skView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        let trailing = skView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:0)
        let bottom = skView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:0)

        NSLayoutConstraint.activate([top,leading,trailing,bottom])
    }
    
    
    
    
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}


extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        skView.isPaused = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        skView.isPaused = false
        if(textField.text != ""){
            return true
        }else{
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.getWeather(name: city)
        }
        searchTextField.text = ""
    }
}

extension WeatherViewController: WMDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.CelsiusString
            self.temperatureLabel2.text = weather.FahrenheitString
            self.conditionImageView.image = UIImage(systemName:weather.conditionName[0])
            self.cityLabel.text = weather.cityName
            self.weatherLabel.text = weather.conditionName[1]
            self.drawWeather(with: weather.conditionName[1])
            
            
        }
        
    }
    func didFailWithError(error:Error){
        print(error)
    }
//
    func drawWeather(with condition: String){
        var Scene:SKScene? = nil

        switch condition{
        case "Rainy":
            Scene = RainScene(size: CGSize(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height))
        case "Snow":
            Scene = SnowScene(size: CGSize(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height))
        case "Fog":
            Scene = FogScene(size: CGSize(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height))
        case "Cloudy":
            Scene = CloudScene(size: CGSize(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height))
        case "Light rain":
            Scene = LightRainScene(size: CGSize(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height))
        case "Thunderstorms":
            Scene = StormScene(size: CGSize(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height))
        default:
            Scene = SunScene(size: CGSize(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height))

        }
        if Scene != nil {
            Scene!.scaleMode = .aspectFill
            Scene!.backgroundColor = .clear
            skView.presentScene(Scene)
        } 
        
        
        

    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.getWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

