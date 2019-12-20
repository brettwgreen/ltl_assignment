require 'spec_helper'
require 'yaml'
require 'ltl_assigner'

RSpec.describe LtlAssigner, "#calculate_distributions" do
  before(:each) do
    @trucks = YAML.load_file("trucks.yaml").collect{|_k, v| v}
    @shipments = YAML.load_file("shipments.yaml").collect{|_k, v| v}
    @ltl_assigner = LtlAssigner.new(@trucks, @shipments)
  end

  context "given sample trucks and shipments" do
    it "fits in all the shipments" do
      result = @ltl_assigner.distributions
      # all trucks accounted for, even if empty (perhaps all loads are too large for one truck)
      expect(result.length).to eq 4
      @ltl_assigner.trucks.each do |truck|
        truck_result = result.find{|k, v| k["truck_id"] == truck["id"]}
        truck_capacity = truck["capacity"]
        truck_fill_volume = truck_result["shipments"].map{|tr| tr["capacity"]}.reduce(:+)
        # don't overfill the truck
        expect(truck_fill_volume).to be <= truck_capacity
        # Not sure what's reasonable... let's see if we can acheive 90% fill rate
        expect(truck_fill_volume.fdiv(truck_capacity)).to be >= 0.75
        puts "truck: #{truck["id"]}, capacity: #{truck_capacity}, filled: #{truck_fill_volume}"
      end
    end

    it "can get total shipping capcity" do
      expect(@ltl_assigner.total_shipping_capacity).to eq 130000
    end

    it "can get total shipping volume" do
      expect(@ltl_assigner.total_shipping_volume).to eq 225700
    end
  end
end