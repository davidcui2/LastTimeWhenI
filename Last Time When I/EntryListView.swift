//
//  ContentView.swift
//  Last Time When I
//
//  Created by Zhihao Cui on 25/05/2020.
//  Copyright © 2020 zhihaocui. All rights reserved.
//

import SwiftUI

struct EntryListView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var showingNewEntry = false
 
    var body: some View {
        NavigationView {
            MasterView()
                .navigationBarTitle(Text("Last Time When I"))
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(
                        action: {
//                            withAnimation { Event.create(in: self.viewContext) }
                            self.showingNewEntry.toggle()
                        }
                    ) {
                        Image(systemName: "plus")
                    }
                )
            Text("Detail view content goes here")
                .navigationBarTitle(Text("Detail"))
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .sheet(isPresented: $showingNewEntry) {
            NewEntryView().environment(\.managedObjectContext, self.viewContext)
        }
    }
}

struct MasterView: View {
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Entry.lastUpdateTime, ascending: false),
            NSSortDescriptor(keyPath: \Entry.name, ascending: true)
        ],
        animation: .default)
    var entries: FetchedResults<Entry>

    @Environment(\.managedObjectContext)
    var viewContext

    var body: some View {
        List {
            ForEach(entries, id: \.self) { entry in
                NavigationLink(
                    destination: EntryDetailView(entry: entry)
                ) {
                    EntryCellView(entry: entry)
                }
            }.onDelete { indices in
                self.entries.delete(at: indices, from: self.viewContext)
            }
        }
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
