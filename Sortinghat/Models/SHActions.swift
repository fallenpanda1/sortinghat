enum House: String {
    case gryffindor
    case hufflepuff
    case slytherin
    case ravenclaw
}

struct SHDeclareHouseAction: Action {
    let house: House

    func execute() {
        print("Declared house '\(house)'!")
    }
}
