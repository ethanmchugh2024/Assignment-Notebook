//
//  AddAssignmentView.swift
//  Assignment Notebook
//
//  Created by Ethan McHugh on 7/25/22.
//

import SwiftUI

struct AddAssignmentView: View {
    @ObservedObject var assignmentList : AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["Math", "English", "Science", "Coding"]
    var body: some View {
        NavigationView{
            Form{
                Picker("Courses", selection: $course){
                    ForEach(Self.courses, id: \.self){ course in
                        Text(course)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Course", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save"){
                if course.count > 0 && description.count > 0 {
                    let item = AssignmentItems(course: course, id: UUID(), description: description, dueDate:dueDate)
                    assignmentList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView(assignmentList: AssignmentList())
    }
}
