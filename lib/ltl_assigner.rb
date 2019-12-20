class LtlAssigner
  attr_accessor :trucks, :shipments

  def initialize(trucks, shipments)
    @trucks = trucks
    @shipments = shipments
  end

  def distributions
    distro = trucks.map{|t| {"truck_id" => t["id"], "truck_capacity" => t["capacity"], "shipments" => []}}
    ordered_trucks = distro.sort_by{|t| t["truck_capacity"]}.reverse
    available_shipments = shipments.sort_by{|s| s["capacity"]}.reverse.clone
    ordered_trucks.each do |truck|
      available_truck_capacity = truck["truck_capacity"]
      while shipment = find_shipment_that_fits(available_truck_capacity, available_shipments)
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

  private
  def find_shipment_that_fits(available_truck_capacity, available_shipments)
    available_shipments.each do |s|
      s["fitness"] = (available_truck_capacity - s["capacity"])
    end
    available_shipments.select{|s| s["fitness"] >= 0}.sort_by{|s| s["fitness"] }.first
  end
end