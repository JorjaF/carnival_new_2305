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
    
    visitor1.add_preference(:gentle)
    visitor1.add_preference(:thrilling)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:gentle)
    visitor3.add_preference(:thrilling)

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

  it "can find the most profitable ride" do
    carnival = Carnival.new(14)
    ride1 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Bumper Cars', min_height: 48, admission_fee: 3, excitement: :gentle})
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 52, admission_fee: 7, excitement: :thrilling})
      
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor3 = Visitor.new('Penny', 64, '$15')
  
    visitor1.add_preference(:gentle)
    visitor1.add_preference(:thrilling)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:gentle)
    visitor3.add_preference(:thrilling)
  
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
  
    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)
    ride2.board_rider(visitor1)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor3)
  
    expect(carnival.most_profitable_ride).to eq(ride3)
  end

  it "can calculate total revenue from all rides" do
    carnival = Carnival.new(14)
    ride1 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Bumper Cars', min_height: 48, admission_fee: 3, excitement: :gentle})
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 52, admission_fee: 7, excitement: :thrilling})
    
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor3 = Visitor.new('Penny', 64, '$15')

    visitor1.add_preference(:gentle)
    visitor1.add_preference(:thrilling)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:gentle)
    visitor3.add_preference(:thrilling)

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)
    ride2.board_rider(visitor1)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor3)
  
    expect(carnival.total_revenue).to eq(20)
  end

  it "can make a summary of visitors and revenu" do
    carnival = Carnival.new(14)
    ride1 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Bumper Cars', min_height: 48, admission_fee: 3, excitement: :gentle})
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 52, admission_fee: 7, excitement: :thrilling})
    
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor3 = Visitor.new('Penny', 64, '$15')

    visitor1.add_preference(:gentle)
    visitor1.add_preference(:thrilling)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:gentle)
    visitor3.add_preference(:thrilling)

    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)

    ride3.board_rider(visitor3)
    ride3.board_rider(visitor3)
    ride2.board_rider(visitor1)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor3)
    
    expect(carnival.summary).to eq(
      {
      visitor_count: 3,
      revenue_earned: 20,
      visitors: [
        visitor: visitor1,
        favorite_ride: ride1,
        total_money_spent: 4
      },
      {
        visitor: visitor2,
        favorite_ride: ride1,
        total_money_spent: 1
      },
      {
        visitor: visitor3,
        favorite_ride: ride3,
        total_money_spent: 14
      }],
      rides: [
    {
      ride: ride1,
      riders: [visitor1, visitor2, visitor],
      total_revenue: 3
    },
    {
      ride: ride2,
      riders: [visitor1],
      total_revenue: 3
    },
    {
      ride: ride,
      riders: [visitor3],
      total_revenue: 14
    }])
    end
  end
end
# {
#   visitor_count: integer, 
#   revenue_earned: integer, 
#   visitors: [
#     {
#       visitor: Visitor object,
#       favorite_ride: Ride object,
#       total_money_spent: integer
#     }, 
#     {
#       visitor: Visitor object,
#       favorite_ride: Ride object,
#       total_money_spent: integer
#     }],
#   rides: [
#     {
#       ride: Ride object,
#       riders: [Visitor objects],
#       total_revenue: integer
#     },
#     {
#       ride: Ride object,
#       riders: [Visitor objects],
#       total_revenue: integer
#     }]
#   }

# A carnival can provide a summary hash that includes:
# Visitor count
# Revenue earned
# List of visitors and each visitor's favorite ride and how much total money a visitor spent
# List of rides and who rode each ride and the ride's total revenue
