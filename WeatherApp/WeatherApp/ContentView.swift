import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: Weather?

    var body: some View {
        VStack {
            if locationManager.authorizationStatus == .notDetermined {
                WelcomeView()
                    .environmentObject(locationManager)
                    .onAppear {
                        print("🚀 Location permission want...")
                        locationManager.requestLocation()
                    }
            } else if locationManager.authorizationStatus == .denied {
                VStack {
                    Text("Location permission did not given!")
                        .foregroundColor(.red)
                        .bold()
                    Text("Please give location permission from settings .")
                        .padding()
                }
            } else if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                print("🌍 Weather Fetching: \(location.latitude), \(location.longitude)")
                                weather = try await weatherManager.getCurrentWeather(
                                    latitude: location.latitude,
                                    longitude: location.longitude
                                )
                            } catch {
                                print("❌ Weather Error: \(error)")
                            }
                        }
                }
            } else {
                LoadingView()
            }
        }
        .background(Color.blue)
        .preferredColorScheme(.dark)
    }
}
