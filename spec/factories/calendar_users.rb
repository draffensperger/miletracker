# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calendar_user1, class: CalendarUser do
    access_role "freeBusyReader"
    hidden true
  end
  
  factory :calendar_user1_changed, class: CalendarUser do
    color_id "12"
    background_color "#fad165"
    foreground_color "#000000"
    selected true
    access_role "writer"
    primary true
    summary_override "Custom Cal 2 Summary"
  end
end