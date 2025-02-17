import SwiftUI




struct LoadingView:View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint:.white))
            .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}
