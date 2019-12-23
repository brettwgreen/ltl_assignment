module LtlStrategy
  class BiggestFirst
    def self.find_shipment_that_fits(available_truck_capacity, available_shipments)
      available_shipments.find{|s| s["capacity"] <= available_truck_capacity}
    end
  end
  
  class TightestFit
    def self.find_shipment_that_fits(available_truck_capacity, available_shipments)
      available_shipments.find{|s| s["capacity"] <= available_truck_capacity}
      available_shipments.each do |s|
        s["fitness"] = (available_truck_capacity - s["capacity"])
      end
      available_shipments.select{|s| s["fitness"] >= 0}.sort_by{|s| s["fitness"] }.first
    end
  end
end
