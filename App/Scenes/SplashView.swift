//
//  SplashView.swift
//  App
//
//  Created by 日野森寛也 on 2022/10/02.
//

import SwiftUI
import ComposableArchitecture

extension ViewFactory {
    static func create(_ store: StoreOf<Splash>) -> some View {
        SplashView(store: store)
    }
}

struct SplashView: View {
    let store: StoreOf<Splash>
    
    var body: some View {
        WithViewStore(store) { viewState in
            ZStack(alignment: .center) {
                Color(.black)
                    .opacity(0.3)
                    .ignoresSafeArea()
                VStack {
                    Text("Initializing...")
                    IndicatorView()
                }
            }
            .onAppear {
                viewState.send(.onAppear)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(
            store: .init(
                initialState: .init(),
                reducer: Splash()
            )
        )
    }
}
