enum House: String {
    case gryffindor
    case hufflepuff
    case slytherin
    case ravenclaw

    var name: String {
        return self.rawValue.capitalized
    }
}
