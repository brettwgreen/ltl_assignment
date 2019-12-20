require 'spec_helper'
require 'yaml'

require File.expand_path('../../../lib/ltl_assigner', __FILE__)

RSpec.describe LtlAssigner, "#calculate_distributions" do
  context "given sample trucks and shipments" do
    it "returns evenly distributed shipments" do
      trucks = YAML.load_file("trucks.yaml")
      expect(trucks.length).to eq 4
    end
  end
end