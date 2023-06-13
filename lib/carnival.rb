class Carnival
  
  attr_reader :duration, 
              :rides,
              :revenue_per_ride

  def initialize(duration)
    @duration = duration
    @rides = []
    @revenue_per_ride = {}
  end

  def add_ride(ride)
    @rides.push(ride)
  end

  def most_popular_ride
      @rides.max_by do |ride|
      ride.rider_log.length
    end
  end

  def most_profitable_ride
    @rides.max_by do |ride|
      ride.total_revenue
    end
  end

  def total_revenue
    @rides.sum do |ride|
      ride.total_revenue
    end
  end
end
