puts "="*45
puts 'room!!'
puts "="*45
Fabricator :room, :class_name => "Dickburt::Room" do
  name 'boom' # name {Faker::Company.name}
end