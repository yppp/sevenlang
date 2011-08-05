#
class Tree
  attr_accessor :name, :children

  def initialize(arg)
    if arg[:rootname].nil? then
      @name = arg[:hash].keys[0]
      if arg[:hash].values[0].empty? then
        @children = []
      else
        @children = arg[:hash].values[0].map do |x, y|
          Tree::new rootname: x,  hash: y
        end
      end

    else
      @name = arg[:rootname]
      if arg[:hash].empty? then
        @children = []
      else
        @children = arg[:hash].map do |x, y|
          Tree::new rootname: x,  hash: y
        end
      end
    end
  end

  def visit(&block)
    block.call self
  end

  def visit_all(&block)
    visit &block
    children.each{|x| x.visit_all &block}
  end
end

tree = Tree::new(hash: {grandpa: {dad: {child1: [], child2: []}, uncle: {child3: [], child4: []}}})

tree.visit_all{|x| p x.name}
