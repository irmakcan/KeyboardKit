//
//  Keyboard+BottomRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-02-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {

    /// This view creates a keyboard bottom row with leading
    /// and trailing actions around a space key.
    ///
    /// The view can be used to keep the bottom row when you
    /// replace the rest of the keyboard with another view.
    struct BottomRow<
        ButtonContent: View,
        ButtonView: View>: KeyboardViewComponent {

        /// Create a bottom row based on state and services.
        ///
        /// - Parameters:
        ///   - leadingActions: The actions to add before the space bar.
        ///   - trailingActions: The actions to add after the space bar.
        ///   - state: The keyboard state to use.
        ///   - services: The keyboard services to use.
        ///   - buttonContent: The content view to use for buttons.
        ///   - buttonView: The button view to use for an buttons.
        public init(
            leadingActions: [KeyboardAction],
            trailingActions: [KeyboardAction],
            state: Keyboard.State,
            services: Keyboard.Services,
            @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
            @ViewBuilder buttonView: @escaping ButtonViewBuilder
        ) {
            self.init(
                leadingActions: leadingActions,
                trailingActions: trailingActions,
                actionHandler: services.actionHandler,
                layoutProvider: services.layoutProvider,
                styleProvider: services.styleProvider,
                keyboardContext: state.keyboardContext,
                buttonContent: buttonContent,
                buttonView: buttonView
            )
        }

        /// Create a bottom row based on raw properties.
        ///
        /// - Parameters:
        ///   - leadingActions: The actions to add before the space bar.
        ///   - trailingActions: The actions to add after the space bar.
        ///   - actionHandler: The action handler to use.
        ///   - styleProvider: The style provider to use.
        ///   - keyboardContext: The keyboard context to use.
        ///   - buttonContent: The content view to use for buttons.
        ///   - buttonView: The button view to use for an buttons.
        public init(
            leadingActions leading: [KeyboardAction],
            trailingActions trailing: [KeyboardAction],
            actionHandler: KeyboardActionHandler,
            layoutProvider: KeyboardLayoutProvider,
            styleProvider: KeyboardStyleProvider,
            keyboardContext: KeyboardContext,
            @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
            @ViewBuilder buttonView: @escaping ButtonViewBuilder
        ) {
            let layout = layoutProvider.keyboardLayout(for: keyboardContext)
            let width = layout.bottomRowSystemItemWidth ?? .percentage(0.15)
            let leading = leading.map { layout.createIdealItem(for: $0, width: width) }
            let space = layout.createIdealItem(for: .space, width: .available)
            let trailing = trailing.map { layout.createIdealItem(for: $0, width: width) }
            layout.itemRows = [leading + [space] + trailing]
            self.layout = layout

            self.actionHandler = actionHandler
            self.styleProvider = styleProvider
            self.buttonContentBuilder = buttonContent
            self.buttonViewBuilder = buttonView
            _keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        }

        private let actionHandler: KeyboardActionHandler
        private let layout: KeyboardLayout
        private let styleProvider: KeyboardStyleProvider

        private let buttonContentBuilder: ButtonContentBuilder
        private let buttonViewBuilder: ButtonViewBuilder

        @ObservedObject
        private var keyboardContext: KeyboardContext

        public var body: some View {
            KeyboardView(
                layout: layout,
                actionHandler: actionHandler,
                styleProvider: styleProvider,
                keyboardContext: keyboardContext,
                autocompleteContext: .preview,
                calloutContext: nil,
                buttonContent: buttonContentBuilder,
                buttonView: buttonViewBuilder,
                emojiKeyboard: { _ in EmptyView() },
                toolbar: { _ in EmptyView() }
            )
            .keyboardInputToolbarDisplayMode(.hidden)
        }
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
#Preview {
    Keyboard.BottomRow(
        leadingActions: [.keyboardType(.numeric), .keyboardType(.emojis)],
        trailingActions: [.backspace, .primary(.go)],
        state: .preview,
        services: .preview,
        buttonContent: { $0.view },
        buttonView: { $0.view}
    )
    .background(Color.keyboardBackground)
}
#endif
