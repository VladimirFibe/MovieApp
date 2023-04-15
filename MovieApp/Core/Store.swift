import Combine
import SwiftUI

typealias Bag = Set<AnyCancellable>

protocol ErrorObservable {
    var errorViewModel: ErrorViewModel { get set }
}

protocol LoadingObservable {
    var loadingViewModel: LoadingViewModel { get set }
}

class Store<Event, Action>: ErrorObservable, LoadingObservable {
    private(set) var events = PassthroughSubject<Event, Never>()
    private(set) var actions = PassthroughSubject<Action, Never>()
    
    var errorViewModel = ErrorViewModel()
    var loadingViewModel = LoadingViewModel()
    
    var bag = Bag()
    
    init() {
        setupActionHandlers()
    }
    
    func sendAction(_ action: Action) {
        actions.send(action)
    }
    
    func sendEvent(_ event: Event) {
        events.send(event)
    }
    
    func setupActionHandlers() {
        actions.sink { [weak self] action in
            guard let self = self else { return }
            self.handleActions(action: action)
        }.store(in: &bag)
    }
    
    func handleActions(action: Action) {
        
    }
    
    func statefulCall(_ action: @MainActor @escaping () async throws -> (),
             retry: (@MainActor () async -> ())? = nil) {
        Task {
            await stateful(action: action, retry: retry)
        }
    }
    
    @MainActor
    func stateful(action: @MainActor @escaping () async throws -> (),
                 retry: (@MainActor () async -> ())? = nil) async {
        self.loadingViewModel.isLoading = true
        self.errorViewModel.error = nil
        do {
            defer {
                self.loadingViewModel.isLoading = false
            }
            try await action()
        } catch {
            self.errorViewModel.error = error as? AppError
            self.errorViewModel.onRetry = {
                Task {
                    if let retry = retry {
                        await retry()
                    } else {
                        await self.stateful(action: action)
                    }
                }
            }
        }
    }
}

class ErrorViewModel: ObservableObject {
    @Published var error: AppError?
    var onRetry: Callback = {}
}

extension AppError {
    var imageName: String {
        switch type {
        case .noInternet:
            return "no-internet-error"
        case .server:
            return "server-error"
        case .generic:
            return "generic-error"
        }
    }
}

class LoadingViewModel: ObservableObject {
    @Published var isLoading: Bool = true
}

class AppError: Error {
    var statusCode: StatusCode?
    
    var isRetryable: Bool {
        false
    }
    
    var message: String {
        "Ошибка"
    }
    
    var type: AppErrorType {
        .generic
    }
}

typealias StatusCode = Int

enum AppErrorType {
    case noInternet
    case server
    case generic
}
