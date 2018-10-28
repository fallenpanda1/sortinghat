/// Tree structure for navigating through actions
enum ActionNode {
    case branch(ActionBranchNode)
    case leaf(ActionLeafNode)

    var name: String {
        switch self {
        case .branch(let branchNode):
            return branchNode.name
        case .leaf(let leafNode):
            return leafNode.name
        }
    }
}

/// Lists out all possible branch children for our purposes
enum ActionBranchChildPosition {
    case center
    case top
    case left
    case bottom
    case right
}

/// A node that has subnodes
class ActionBranchNode {
    let name: String
    let centerNode: ActionNode?
    let topNode: ActionNode?
    let leftNode: ActionNode?
    let bottomNode: ActionNode?
    let rightNode: ActionNode?

    init(name: String,
         centerNode: ActionNode? = nil,
         topNode: ActionNode? = nil,
         leftNode: ActionNode? = nil,
         bottomNode: ActionNode? = nil,
         rightNode: ActionNode? = nil) {
        self.name = name
        self.centerNode = centerNode
        self.topNode = topNode
        self.leftNode = leftNode
        self.bottomNode = bottomNode
        self.rightNode = rightNode
    }

    func childNode(forPosition position: ActionBranchChildPosition) -> ActionNode? {
        switch position {
        case .center:
            return centerNode
        case .top:
            return topNode
        case .left:
            return leftNode
        case .bottom:
            return bottomNode
        case .right:
            return rightNode
        }
    }
}

struct ActionLeafNode {
    let name: String
    let action: Action
}
