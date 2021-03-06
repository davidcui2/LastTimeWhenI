//
//  EntryCellView.swift
//  Last Time When I
//
//  Created by Zhihao Cui on 29/05/2020.
//  Copyright © 2020 zhihaocui. All rights reserved.
//

import SwiftUI

struct EntryCellView: View {
    @ObservedObject var entry: Entry

    var body: some View {
        HStack {
            entry.wrappedImage
                .resizable()
                .squareImage()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(entry.wrappedName)
                    .font(.headline)
                if (entry.sortedEvents.first != nil) {
                    Text(entry.sortedEvents.first!.relativeDateTime)
                }
            }
        }
    }
}

struct EntryCellView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = PersistenceController.preview.container.viewContext
                
        //        let event = Event.create(in: context, time: Date())
        let event = Event.init(context: context)
        
        event.timestamp = Date().addingTimeInterval(-15000)
                
                let entry = Entry.init(context: context)
                entry.name = "Entry name"
                entry.image = (UIImage(named: "Camera")?.pngData())
                entry.addToEvents(event)
                
        return EntryCellView(entry: entry) // .environment(\.managedObjectContext, context)
    }
}
