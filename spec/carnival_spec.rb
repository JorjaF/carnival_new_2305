require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do
  it 'exists and has attributes' do
    carnival = Carnival.new(14)

    expect(carnival).to be_a(Carnival)
    expect(carnival.duration).to eq(14)
    expect(carnival.rides).to eq([])
  end

  it 'can add rides' do
    carnival = Carnival.new(14)
    ride1 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 1 })
    ride2 = Ride.new({ name: 'Bumper Cars', min_height: 48, admission_fee: 3 })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 52, admission_fee: 10 })

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    expect(carnival.rides).to eq([ride1, ride2, ride3])
  end

    it "can tell the most popular ride" do
      carnival = Carnival.new(14)
      ride1 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 1 })
      ride2 = Ride.new({ name: 'Bumper Cars', min_height: 48, admission_fee: 3 })
      ride3 = Ride.new({ name: 'Roller Coaster', min_height: 52, admission_fee: 10 })
      
      visitor2 = Visitor.new('Tucker', 36, '$5')
      visitor1 = Visitor.new('Bruce', 54, '$10')
      visitor3 = Visitor.new('Penny', 64, '$15')

      carnival.add_ride(ride1)
      carnival.add_ride(ride2)
      carnival.add_ride(ride3)

      ride3.board_rider(visitor3)
      ride3.board_rider(visitor3)
      ride2.board_rider(visitor1)
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor3)

      expect(carnival.most_popular_ride).to eq(ride1)
    end
end


# Additionally, use TDD to add the following functionality to the Carnival class. A passing challenge will complete at least one of the following. We recommend completing more than one if you have time.

# A carnival can tell us its most popular ride.
# A carnival can tell us its most profitable ride
# A carnival can calculate the total revenue earned from all its rides.
