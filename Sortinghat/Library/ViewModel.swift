/// Protocol to which all view models should conform.
protocol ViewModel {

    /// A type which specifies the observables that are passed into the view model.
    associatedtype Input

    /// A type which specifies the observables that are obtained from the view model.
    associatedtype Output

    func bind(inputs: Input)

    func outputBindings() -> Output
}
