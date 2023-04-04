//
//  RoastRecordsView.swift
//  Coffee Records
//
//  Created by Jason Koehn on 3/27/23.
//

import SwiftUI

struct RoastRecordsView: View {
    @EnvironmentObject var store: Store
    @State private var showAddRoastView: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.roasts, id: \.id) { roast in
                    HStack {
                        HStack {
                            Text(roast.date!.formatted(.dateTime.day().month()))
                                .font(.system(size: 19))
                                .foregroundColor(.blue)
                            Spacer()
                        }
                        .frame(width: 80)
                        VStack(alignment: .leading) {
                            Text(roast.origin ?? "")
                                .font(.system(size: 18))
                                .foregroundColor(.orange)
                            Text(roast.customer ?? "")
                                .font(.system(size: 18))
                        }
                        Spacer()
                        Text(roast.pounds ?? "")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                    }
                }
                .onDelete(perform: store.deleteRoast(at:))
            }
            .navigationTitle("Roasts")
            .listStyle(.inset)
            .refreshable {
                store.fetchRoasts()
            }
            .toolbar {
                Button(action: {
                    showAddRoastView.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 19))
                }
            }
            .sheet(isPresented: $showAddRoastView) {
                NavigationStack {
                    AddRoastView()
                }
            }
        }
    }
}

struct RoastRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RoastRecordsView()
    }
}
