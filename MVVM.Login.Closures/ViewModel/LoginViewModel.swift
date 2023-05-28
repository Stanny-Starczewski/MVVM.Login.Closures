import Foundation

typealias Binding<T> = (T) -> Void

final class LoginViewModel {
    
    var onLoginAllowedStateChange: Binding<Bool>?
    var onErrorStateChange: Binding<String?>?
    
    private let model: LoginModel
    
    init(for model: LoginModel) {
        self.model = model
    }
    
    func didEnter(_ credentials: Credentials) {
        let result = model.didEnter(credentials)
        
        switch result {
        
        case .success(let isLoginAllowed):
            onLoginAllowedStateChange?(isLoginAllowed)
            onErrorStateChange?(nil)
        
        case .failure(let error):
            onLoginAllowedStateChange?(false)
            if let error = error as? LoginError {
                onErrorStateChange?(error.localizedDescription)
            }
        }
    }
}
