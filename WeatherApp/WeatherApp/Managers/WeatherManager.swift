import Foundation
import CoreLocation

class WeatherManager {
    private let apiKey: String

    init() {
        apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }

    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> Weather {
        guard let url = URL(string:
            "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        ) else {
            fatalError("Missing URL")
        }

        print("📡 API Request URL: \(url)")

        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ ERROR: Invalid HTTP response")
                throw URLError(.badServerResponse)
            }
            
            guard httpResponse.statusCode == 200 else {
                print("❌ HTTP ERROR CODE: \(httpResponse.statusCode)")
                throw URLError(.badServerResponse)
            }

            let decodedData = try JSONDecoder().decode(Weather.self, from: data)
            return decodedData
        } catch {
            print("❌ API Request Failed: \(error.localizedDescription)")
            throw error
        }
    }
}
