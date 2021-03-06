//
//  ContentView.swift
//  Shared
//
//  Created by Hai Feng Kao on 2021/12/9.
//

import SwiftUI
import CombineRex

public struct ShopView: View {
    
    public typealias ViewState = ShopState
    public typealias ViewAction = ShopAction
    public typealias ViewModel = ObservableViewModel<ViewAction, ViewState>
    @ObservedObject public var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var state: ShopState {
        self.viewModel.state
    }

    var items: [Item] {
        switch state.mode {
        case .weapon:
            return state.weapons
        case .armor:
            return state.armors
        }
    }

    public var body: some View {
        VStack {
            Spacer()
            Spacer()
            HStack {
                Spacer()
                Button {
                    // mode = .weapon
                    viewModel.dispatch(ShopAction.changeSection(.weapon))
                } label: {
                    Text("武器")
                }
                Spacer()
                Button {
                    // mode = .armor
                    viewModel.dispatch(ShopAction.changeSection(.armor))
                } label: {
                    Text("防具")
                }
                Spacer()
            }
            List {
                HStack {
                    Text("商品")
                    Spacer()
                    Text("價錢")
                }.listRowBackground(Color(.init(gray: 1.0, alpha: 0.4)))
                ForEach(items, id: \.name) { item in
                    HStack {
                        Text("\(item.name)")
                        Spacer()
                        Text("\(item.price)")
                    }
                }.listRowBackground(Color.clear)
            }
        }
        .background(Image(uiImage: ShopAsset.shop.image).resizable().aspectRatio(contentMode: .fill).opacity(0.5))
        .onAppear {
            // Set the default to clear
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
        }
    }
}

