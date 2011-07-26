class SimpleCustomPlugin
  attr_reader :invoked, :args
  def initialize(args)
    @args = args
  end
  def invoke_all
    @invoked = true
    self
  end
end