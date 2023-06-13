class Carnival
  
  attr_reader :duration, 
              :rides

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides.push(ride)
  end

  def most_popular_ride
    @rides.max_by do |ride|
      ride.rider_log.length
    end
  end
end
