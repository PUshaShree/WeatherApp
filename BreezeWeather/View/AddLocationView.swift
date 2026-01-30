import SwiftUI

struct AddLocationView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var latitude = ""
    @State private var longitude = ""
    @State private var showAlert = false

    var body: some View {
        Form {
            Section("Location Info") {
                TextField("Name", text: $name)
                TextField("Latitude", text: $latitude)
                    .keyboardType(.decimalPad)
                TextField("Longitude", text: $longitude)
                    .keyboardType(.decimalPad)
            }

            Button("Save Location") {
                guard !name.isEmpty,
                      let lat = Double(latitude),
                      let long = Double(longitude) else {
                    showAlert = true
                    return
                }

                PersistenceController.shared.createLocation(name: name, lat: lat, long: long)
                dismiss()
            }
        }
        .navigationTitle("Add Location")
        .alert("Invalid input", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Enter a valid name, latitude, and longitude.")
        }
    }
}
