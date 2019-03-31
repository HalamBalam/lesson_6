require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_station(station)
    return if [@stations.first, @stations.last].include?(station)
    @stations.delete(station)
  end

  def print
    stations.each { |station| puts station.name }
  end

  def description
    start = stations.first.name
    finish = stations.last.name
    "#{start}-#{finish}, станций: #{stations.size}"
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Неверный тип начальной станции" unless stations[0].is_a?(Station)
    raise "Неверный тип конечной станции" unless stations[-1].is_a?(Station)
    raise "Начальные и конечные станции не должны совпадать" if stations[0] == stations[-1]
  end

end
