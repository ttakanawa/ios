import Foundation
import RxSwift
import Models

public protocol UserAPI
{
    func loginUser(email: String, password: String) -> Observable<User>
    func setAuth(token: String?)
}
