enum House: String {
    case gryffindor
    case hufflepuff
    case slytherin
    case ravenclaw

    var name: String {
        return self.rawValue.capitalized
    }
}

/// Declare wearer to a house
struct DeclareHouseAction: Action {
    let house: House

    func execute() {
        print("House \(house.name)!")

        // also go back to root
        SHActionTree.shared.goUpToRootBranch()
    }
}

struct GoToBranchAction: Action {
    let branch: ActionBranchNode

    func execute() {
        SHActionTree.shared.goToBranch(branch)
    }
}
