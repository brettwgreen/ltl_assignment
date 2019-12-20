## Truck shipping distribution code challenge (ltl_assignment)

### Setup and Run:
Ruby 2.6.5

I use rvm... so `rvm install 2.6.5` if you don't already have it

Then simply:
```
bundle install
rspec --format doc
```

### General notes
- RSpec used as testing framework
- Truck and shipping samples loaded from YAML files
- Just passing hashes around for data
- Added awesome_print gem... there's an `ap result` in the main test that will print out the truck distributions that is commented out, but was using that to visualize what my algorithm attempts were spitting out.

### Algorithm notes
- Started with pretty basic thing to sort all trucks in descending order of capacity, then all shipments in descending order as well
- Then just walked all trucks and put the biggest shipment in each truck that would fit
- Was not sure what was acheivable, so started with 'hey can I fill each truck to 90%'?
- Well, that did not work to 90%, but was able to acheive 75% with that and at least I had something I could iterate/experiment with
- Tried one more algorithm change to 'find the tightest fit given a truck with available capacity and a set of shipments'
- That seemed like how I might pack a truck when I'm moving or packing for vacation. Don't think it really moved the needle, but seemed abstractly like a better algorithm

### Future improvements
- I think the change that would move the needle was to take the _set_ of trucks with available capacity and the remaining shipments and find the 'tighest fit' in those collections, add that shipment to the truck, rinse and repeat. I started refactoring that, but thought I had spent enough time and that was a fair amount of change to my structure.
- I did do a cursory search when done and landed on some 'packing algorithms' that seemed to at least rudimentally confirm my point above (I kinda wanted to see what I could come up with before looking around), although I'm sure it can get pretty sophisticated.
- Add a lot more tests and assertions at a more granular level... obviously more test scenarios as well.
  - Test the `find_shipment_that_fits` method directly since it's the core of the operation.
- Obviously, using real classes Truck, Shipment and TruckDistrubution would be a lot better than passing hashes around.

