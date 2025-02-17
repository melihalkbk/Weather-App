import Foundation

struct Weather:Decodable{
    var coord:CoordinatesResponse
    var weather:[WeatherResponse]
    var main :MainResponse
    var name:String
    var wind:WindResponse
    
    
    struct CoordinatesResponse:Decodable{
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse:Decodable{
        var id:Double
        var main:String
        var description:String
        var icon:String
    }
    
    struct MainResponse:Decodable{
        var temp:Double
        var feels_like:Double
        var temp_min:Double
        var temp_max:Double
        var pressure:Double
        var humidity:Double
    }
    struct WindResponse:Decodable{
        var speed:Double
        var deg:Double
    }
}

extension Weather.MainResponse{
    var feelsLike:Double{return feels_like}
    var tempMin:Double{return temp_min}
    var tempMax:Double{return temp_max}
}
