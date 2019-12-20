class LtlAssigner
  attr_accessor :trucks, :shipments

  def initialize(trucks, shipments)
    @trucks = trucks
    @shipments = shipments
  end

  def distributions
    distro = trucks.map{|t| {"truck_id" => t["id"], "shipments" => []}}
    ordered_trucks = trucks.sort_by{|t| t["capacity"]}.reverse
    available_shipments = shipments.sort_by{|s| s["capacity"]}.reverse.clone
    ordered_trucks.each do |truck|
      available_truck_capacity = truck["capacity"]
      truck_distro = distro.find{|d| d["truck_id"] == truck["id"]}
      while shipment = find_shipment_that_fits(available_truck_capacity, available_shipments)
        truck_distro["shipments"] << shipment
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
    available_shipments.find{|s| s["capacity"] <= available_truck_capacity}
  end
end