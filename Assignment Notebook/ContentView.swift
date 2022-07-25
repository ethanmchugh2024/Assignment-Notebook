//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Ethan McHugh on 7/25/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddAssignmentView = false
    var body: some View {
        NavigationView{
            List{
                ForEach(assignmentList.items) { item in
                    HStack {
                        VStack (alignment: .leading){
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove{indices, newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                }
                .onDelete{ indexSet in
                    assignmentList.items.remove(atOffsets: indexSet)
                }
            }
            .sheet(isPresented: $showingAddAssignmentView, content: {
                AddAssignmentView(assignmentList: assignmentList)
            })
            .navigationBarTitle("Assignment Notebook", displayMode: .inline)
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showingAddAssignmentView = true}) {
                    Image(systemName: "plus")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AssignmentItems: Identifiable, Codable{
    var course = String()
    var id = UUID()
    var description = String()
    var dueDate = Date()
}
