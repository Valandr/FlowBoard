# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end




puts "Figures list"
figures = [
  { name: 'Peter Pan', description: 'Fluid crossing of the legs as you move forward.', skill_level: 'beginner', duration: 45, category: ['footwork'], video_url: 'https://www.youtube.com/watch?v=O6kkrBlrA6s' },
  { name: 'Ghostride Kickflip', description: 'A kickflip after a longboard jump.', skill_level: 'intermediate', duration: 60, category: ['flip', 'freestyle'], video_url: 'https://www.youtube.com/watch?v=0l87FeDZVb8' },
  { name: 'Tiger Claw', description: 'Throw and retrieve the board with one hand.', skill_level: 'intermediate', duration: 75, category: ['spin', 'freestyle'], video_url: 'https://www.youtube.com/watch?v=_dm-z3z08dM' },
  { name: 'Shuvit', description: 'Rotate the board 180° under the feet.', skill_level: 'beginner', duration: 30, category: ['spin'], video_url: 'https://www.youtube.com/watch?v=wboWFn3vBlY' },
  { name: 'Casper Flip', description: 'Flip from a Casper position.', skill_level: 'advanced', duration: 90, category: ['flip', 'freestyle'], video_url: 'https://www.youtube.com/watch?v=5TMCyLxPnVQ' },
  { name: 'G-Turn', description: 'Turning on a front wheel.', skill_level: 'advanced', duration: 120, category: ['slide', 'carving'], video_url: 'https://www.youtube.com/watch?v=UqzFF3AzTjE' },
  { name: 'Manual', description: 'Ride on two wheels only.', skill_level: 'beginner', duration: 40, category: ['balance', 'freestyle'], video_url: 'https://www.youtube.com/watch?v=MTM0ppAWhXo' },
  { name: 'No Comply 180', description: '180° with pressure on the tail and jump.', skill_level: 'intermediate', duration: 50, category: ['spin', 'freestyle'], video_url: 'https://www.youtube.com/watch?v=Mz4Xex0hEXM' },
  { name: 'Boneless', description: 'Take the board in hand and jump.', skill_level: 'beginner', duration: 35, category: ['freestyle'], video_url: 'https://www.youtube.com/watch?v=F5OsA84hSQU' },
  { name: 'Pivot', description: 'Single rear wheel rotation.', skill_level: 'intermediate', duration: 55, category: ['balance'], video_url: 'https://www.youtube.com/watch?v=pO51wEjkW-c' },
  { name: "Laser Flip", description: "A trick involving grinding on the board.", skill_level: "advanced", duration: 39, category: ["grind", "carving", "manual"], video_url: "https://www.example.com/laser_flip" },
  { name: "Madonna", description: "A trick involving spinning on the board.", skill_level: "advanced", duration: 57, category: ["flip", "grind"], video_url: "https://www.example.com/madonna" },
  { name: "McTwist", description: "A trick involving sliding on the board.", skill_level: "advanced", duration: 92, category: ["balance", "spin"], video_url: "https://www.example.com/mctwist" },
  { name: "Tail Manual", description: "A trick involving sliding on the board.", skill_level: "intermediate", duration: 60, category: ["freestyle"], video_url: "https://www.example.com/tail_manual" },
  { name: "Casper Slide", description: "A trick involving spinning on the board.", skill_level: "advanced", duration: 62, category: ["slide"], video_url: "https://www.example.com/casper_slide" },
  { name: "Body Varial", description: "A trick involving balancing on the board.", skill_level: "beginner", duration: 54, category: ["balance", "grind"], video_url: "https://www.example.com/body_varial" },
  { name: "Finger Flip", description: "A trick involving sliding on the board.", skill_level: "beginner", duration: 52, category: ["flip"], video_url: "https://www.example.com/finger_flip" },
  { name: "Backside Flip", description: "A trick involving spinning on the board.", skill_level: "intermediate", duration: 82, category: ["carving"], video_url: "https://www.example.com/backside_flip" },
  { name: "Airwalk", description: "A trick involving grinding on the board.", skill_level: "advanced", duration: 61, category: ["flip", "freestyle"], video_url: "https://www.example.com/airwalk" },
  { name: "Indy Grab", description: "A trick involving balancing on the board.", skill_level: "advanced", duration: 101, category: ["spin"], video_url: "https://www.example.com/indy_grab" },
  { name: "Ollie", description: "A trick involving sliding on the board.", skill_level: "intermediate", duration: 103, category: ["manual"], video_url: "https://www.example.com/ollie" },
  { name: "Rocket Air", description: "A trick involving flipping on the board.", skill_level: "advanced", duration: 85, category: ["freestyle", "balance", "flip"], video_url: "https://www.example.com/rocket_air" },
  { name: "Darkslide", description: "A trick involving grinding on the board.", skill_level: "advanced", duration: 93, category: ["freestyle"], video_url: "https://www.example.com/darkslide" },
  { name: "Tre Flip", description: "A trick involving spinning on the board.", skill_level: "advanced", duration: 78, category: ["flip", "freestyle"], video_url: "https://www.example.com/tre_flip" },
  { name: "No Comply", description: "A trick involving balance on the board.", skill_level: "beginner", duration: 65, category: ["freestyle", "manual"], video_url: "https://www.example.com/no_comply" },
  { name: "Bigspin", description: "A trick involving spinning on the board.", skill_level: "intermediate", duration: 96, category: ["spin", "carving"], video_url: "https://www.example.com/bigspin" },
  { name: "Varial Kickflip", description: "A trick involving flipping and spinning.", skill_level: "advanced", duration: 107, category: ["flip", "spin"], video_url: "https://www.example.com/varial_kickflip" },
  { name: "Kickflip", description: "A classic flipping trick.", skill_level: "beginner", duration: 50, category: ["flip"], video_url: "https://www.example.com/kickflip" },
  { name: "Heelflip", description: "A trick similar to kickflip but flipped with the heel.", skill_level: "intermediate", duration: 62, category: ["flip"], video_url: "https://www.example.com/heelflip" },
  { name: "Hardflip", description: "A combination of a frontside pop shove-it and a kickflip.", skill_level: "advanced", duration: 85, category: ["flip"], video_url: "https://www.example.com/hardflip" },
]

puts "Creating database figures..."
figures.each do |trick|
  Figure.create!(
    name: trick[:name],
    description: trick[:description],
    skill_level: trick[:skill_level],
    duration: trick[:duration],
    category: trick[:category],
    video_url: trick[:video_url]
  )
end

puts "Figures seeded successfully !"
