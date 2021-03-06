require 'spec_helper'


describe Trip do
  before do
    @user = create :user    
    @cal = create :calendar
    @cal_user = CalendarUser.create user: @user, calendar: @cal    
  end
  
  def trip(start_min, end_min)
    Trip.create start_time: start_min.minutes.from_now, 
      end_time: end_min.minutes.from_now, user: @user
  end
  
  def event(start_min, end_min)
    Event.create start_date_time: start_min.minutes.from_now, 
      end_date_time: end_min.minutes.from_now, calendar: @cal,
      gcal_event_id: "#{start_min}_#{end_min}"
  end
  
  it 'should find destination events' do
    t1__5_10 = trip 5, 10
    t2__25_30 = trip 25, 30
    t3__45_50 = trip 45, 50
    
    # Event ends before t1 starts => Not in destination events for t1
    e1_2 = event 1, 2
      
    # Event ends before t1 ends => Not in desertination events for t1
    e6_9 = event 6, 9
    
    # Events start before t2 starts, ends after t1 ends => t1 destinations 
    e1_15 = event 1, 15
    e9_15 = event 9, 15
    e11_15 = event 11, 15
    e11_90 = event 11, 90
    
    # Events start after t2 starts => not t1 destination
    e25_27 = event 25, 27
    
    t1__5_10.find_destination_events.should eq [e1_15, e9_15, e11_15, e11_90]
    t2__25_30.find_destination_events.should eq [e11_90]
    
    # Return a blank list for a trip without another trip after it (for now).
    t3__45_50.find_destination_events.should eq []
  end
  
  it 'should not display events for hidden calendar' do
    #t1__5_10 = trip 5, 10       
    #e1_2 = event 9, 15    
    #e1_2.calendar.calendar_user
    #pending('left off implementing this')
  end
end
