import SwiftUI
import HealthKit
import Combine

struct YogaFlowView: View {
    @EnvironmentObject var currentYoga: CurrentYoga
    let yogaFlows = [
        "GentleMorningFlow", "HipOpener", "StrengthBalance",
        "SunSalutation", "WindDown", "CoreFocusedPower",
        "HipOpener2", "MorningFlow", "StrengthBalance2", "WindDown2"
    ]

    var body: some View {
        VStack {
            Text("Select Your Yoga Flow")
                .font(.headline)
                .padding()

            List(yogaFlows, id: \.self) { flow in
                Button(action: {
                    currentYoga.updateFlow(newFlow: flow)
                }) {
                    Text(flow)
                        .padding()
                }
            }
        }
        .navigationTitle("Yoga Flows")
    }
}

struct YogaFlowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            YogaFlowView().environmentObject(CurrentYoga())
        }
    }
}
