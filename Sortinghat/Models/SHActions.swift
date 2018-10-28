enum House: String {
    case gryffindor
    case hufflepuff
    case slytherin
    case ravenclaw
}

struct DeclareHouseAction: Action {
    let house: House

    func execute() {
        print("Declared house '\(house.rawValue.capitalized)'!")
    }
}

struct GoToBranchAction: Action {
    let branch: ActionBranchNode
    let actionTree = SHActionTree.shared

    func execute() {
        actionTree.goToBranch(branch)
    }
}
