//
//  EditorModeView.swift
//  Hamilton
//
//  Created by Milton Montiel on 30/11/25.
//

import SwiftUI

struct EditorModeView: View {
    var editorMode: UIMode
    // TODO: This should be a full on information bar.
    var body: some View {
        Text("\(editorMode)")
            .font(.title)
            .fontWeight(.bold)
            .frame(width: 100, height: 40)
            .background(editorMode == .Edit ? Color.red : Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding(8)
    }
}

#Preview {
    EditorModeView(editorMode: .Edit)
    EditorModeView(editorMode: .Normal)
}
