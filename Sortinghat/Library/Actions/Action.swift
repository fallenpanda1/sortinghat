import RxSwift

protocol Action {
    /// excecute this action
    func execute() -> Completable
}
