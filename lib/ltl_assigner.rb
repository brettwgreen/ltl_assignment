class LtlAssigner
  attr_accessor :trucks, :shipments, :strategy

  def initialize(trucks, shipments, strategy)
    @trucks = trucks
    @shipments = shipments
    @strategy = strategy
  end

  def distributions
    distro = trucks.map{|t| {"truck_id" => t["id"], "truck_capacity" => t["capacity"], "shipments" => []}}
    ordered_trucks = distro.sort_by{|t| t["truck_capacity"]}.reverse
    available_shipments = shipments.sort_by{|s| s["capacity"]}.reverse.clone
    ordered_trucks.each do |truck|
      available_truck_capacity = truck["truck_capacity"]
      while shipment = strategy.find_shipment_that_fits(available_truck_capacity, available_shipments)
        truck["shipments"] << shipment
        available_truck_capacity -= shipment["capacity"]
        available_shipments.delete(shipment)
      end
    end
    distro
  end

  def total_shipping_capacity
    trucks.map{|t| t["capacity"]}.reduce(:+)
  end

  def total_shipping_volume
    shipments.map{|t| t["capacity"]}.reduce(:+)
  end

end