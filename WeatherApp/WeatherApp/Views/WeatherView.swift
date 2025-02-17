import SwiftUI

struct WeatherView: View {
    
    var weather: Weather
    
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                Spacer()
                
                VStack {
                    HStack {
                        VStack {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")) {
                                image in image.resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(weather.weather[0].main)
                                .foregroundColor(.white)
                        }
                        .frame(width: 150, alignment: .leading)

                        Spacer()

                        Text("\(weather.main.feelsLike.roundDouble())°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 40)

                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) {
                        image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)

                VStack {
                    Text("Weather Now")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Divider().background(Color.white.opacity(0.5))

                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min Temp", value: weather.main.temp_min.roundDouble() + "°")
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max Temp", value: weather.main.temp_max.roundDouble() + "°")
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        WeatherRow(logo: "wind.circle.fill", name: "Wind Speed", value: weather.wind.speed.roundDouble() + " m/s")
                        Spacer()
                        WeatherRow(logo: "humidity.fill", name: "Humidity", value: weather.main.humidity.roundDouble() + "%")
                    }
                    .padding(.horizontal)
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                .padding(.horizontal)
                .shadow(radius: 5)
            }
        }
        .preferredColorScheme(.dark)
    }
}
