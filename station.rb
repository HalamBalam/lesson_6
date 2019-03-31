require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@instances << self
    register_instance
  end

  def arrive(train)
    @trains << train
  end

  def depart(train)
    @trains.delete(train)
  end

  def trains_count(type)
    trains_by_type(type).size  
  end

  def description
    name
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Не указано наименование" if name.empty?
  end

  private
  
  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end
end
