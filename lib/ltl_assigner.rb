class LtlAssigner
  attr_accessor :trucks, :shipments

  def initialize(trucks, shipments)
    @trucks = trucks
    @shipments = shipments
  end

  def distributions
    return trucks.map{|t| {"truck_id" => t["id"], "shipments" => []}}
  end

  def total_shipping_capacity
    trucks.map{|t| t["capacity"]}.reduce(:+)
  end

  def total_shipping_volume
    shipments.map{|t| t["capacity"]}.reduce(:+)
  end
end