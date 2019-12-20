require 'spec_helper'
require 'yaml'

require File.expand_path('../../../lib/ltl_assigner', __FILE__)

RSpec.describe LtlAssigner, "#calculate_distributions" do
  before(:each) do
    @trucks = YAML.load_file("trucks.yaml").collect{|_k, v| v}
    @shipments = YAML.load_file("shipments.yaml").collect{|_k, v| v}
    @ltl_assigner = LtlAssigner.new(@trucks, @shipments)
  end

  context "given sample trucks and shipments" do
    it "returns evenly distributed shipments" do
      expect(@trucks.length).to eq 4
    end

    it "can get total shipping capcity" do
      expect(@ltl_assigner.total_shipping_capacity).to eq 130000
    end
  end
end