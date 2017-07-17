class Status
  attr_reader :id, :key, :name

  STATUS = {}
  STATUS_JP = {}

  def initialize(id)
    @id = id
    @key = self.class::STATUS.key id
    raise "Status '#{id}' not found." if @key.nil?
    @name = self.class::STATUS_JP[@key] || @key
  end
end
