class Tree
  attr :node_name
  attr :children

  def initialize(tree)
    @node_name = tree.keys.first
    @children = []
    tree[@node_name].each_pair do |k, v|
      @children << Tree.new({k => v})
    end
  end

  def to_s
    node_name
  end

  def visit(&block)
    block.call self
  end

  def visit_all(&block)
    visit(&block)
    @children.each do |child|
      child.visit_all(&block)
    end
  end
end

t = Tree.new({
  "grandpa" => {
    "dad" => {
      "james" => {
        "ella" => {}
      },
      "antonia" => {
        "isabella" => {},
        "will" => {},
        "ava" => {},
        "scarlett" => {},
      },
      "natalie" => {
        "alex" => {},
        "elena" => {},
      }
    },
    "uncle" => {
      "dave" => {
        "anna" => {},
        "kate" => {},
        "naima" => {},
      },
      "deb" => {
        "ruben" => {},
        "elke" => {},
      }
    }
  }
})

t.visit_all {|n| puts n.to_s}
