//
//  RootTests.swift
//  AppTests
//
//  Created by 日野森寛也 on 2022/10/02.
//

import XCTest
@testable import App
import ComposableArchitecture

@MainActor
final class RootTests: XCTestCase {

    func test_Root_Reducer_Splash() async {
        let testQueue = DispatchQueue.test
        let store = TestStore(
            initialState: RootStore.State(),
            reducer: RootStore.reducer,
            environment: RootStore.Dependency(queue: testQueue.eraseToAnyScheduler())
        )
        _ = await store.send(.splash(.onAppear))
        await testQueue.advance(by: .seconds(1))
        await store.receive(.splash(.onComplete)) {
            $0.splash.isCompleted = true
        }
    }

    func test_Root_Reducer_Content() async {
        let testQueue = DispatchQueue.test
        let store = TestStore(
            initialState: RootStore.State(),
            reducer: RootStore.reducer,
            environment: RootStore.Dependency(queue: testQueue.eraseToAnyScheduler())
        )
        _ = await store.send(.content(.onAppear)) {
            $0.content.text = "Hello, world!!!"
        }
    }

}