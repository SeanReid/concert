# Sean Reid
#
# Week 1 Project Ya'll
# Create a Concert!!!!
#
# A promoter has asked you to create a concert application for them. You'll have a Ruby application where you can:
#
# Display to the user a list of opening-acts that they can choose from
# Let the user choose 2 of the opening-acts
# Let the user enter information for a new headline-act
# Let the user press "Play" and output the acts in order
# Due: Monday morning, 9am
#
# For example:
#
# "Grave Band -> 20 minutes"
# "Freaky Friday -> 30 minutes"
# "HEADLINER: Dave's Weeekend -> 70 minutes"
#
# Tech Details
#
# Have Band class that gets populated by the user
# More than 2 bands in your app for user to choose from
# class Band
# end
#
# #....
# band_name = gets
# Band.new band_name

class Band
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

band1 = Band.new "AAA"
band2 = Band.new "SSS"
band3 = Band.new "DDD"
band4 = Band.new "ZZZ"

@band = [band1, band2, band3, band4]

names = @band.map do |band|
  band.name
end

def start(names)
  first_choice(names)
  second_choice(names)
  third_choice(names)
  last_question(names)
end

def first_choice(names)
  puts "There are #{@band.size} bands to choose from."
  first_choice_selected = false
  until first_choice_selected do
    puts "#{names.join(", ")}"
    puts "Which band would you like to have open your event?"
    @answer1 = gets.chomp.strip
    @band_goes_1st = names.select do |who|
      who[/^#{@answer1}$/i]
    end

    @bands_left_after_1st = names.reject do |who|
      who[/^#{@answer1}$/i]
    end

    if @band_goes_1st.empty?
      puts "The #{@answer1.split.map(&:capitalize).first} Band is not available, please choose from:"
    else
      puts "Great choice, The #{@band_goes_1st.first} Band will open the show!"
      first_choice_selected = true
    end
  end
end

def second_choice(names)
  puts "There are #{@bands_left_after_1st.size} bands left."
  second_choice_selected = false
  until second_choice_selected do
    puts "#{@bands_left_after_1st.join(", ")}"
    puts "What band should go next?"
    @answer2 = gets.chomp.strip
    @band_goes_2nd = @bands_left_after_1st.select do |who|
      who[/^#{@answer2}$/i]
    end

    @bands_left_after_2nd = @bands_left_after_1st.reject do |who|
      who[/(^#{@answer1}$|^#{@answer2}$)/i]
    end

    if @band_goes_2nd.empty?
      puts "The #{@answer2.split.map(&:capitalize).first} Band is not available, please choose from these #{@bands_left_after_1st.size}:"
    else
      puts "Great choice! The #{@band_goes_2nd.first} Band will go second!"
      second_choice_selected = true
    end
  end
end

def third_choice(names)
  puts "For your HEADLINER do you want to pick from one of the remaining #{@bands_left_after_2nd.size}?"
  puts "Yes or no?"
  third_choice = false
  until third_choice do
    answer = gets.chomp.downcase.strip
    if answer == "yes"
      third_choice = true
      third_choice_yes(names)
    elsif answer == "no"
      third_choice = true
      third_choice_no(names)
    else
      puts "Please enter yes or no."
      third_choice = false
    end
  end
end

def third_choice_yes(names)
  puts "Which of the remaining #{@bands_left_after_2nd.size} bands are going to HEADLINE?!"
  puts "#{@bands_left_after_2nd.join(", ")} are left to choose."
  third_choice_selected = false
  until third_choice_selected do
    puts "Which of the remaining #{@bands_left_after_2nd.size} bands would you like to HEADLINE?"
    answer = gets.chomp.strip
    @band_goes_3rd = @bands_left_after_2nd.select do |who|
      who[/^#{answer}$/i]
    end

    @bands_left_after_2nd = @bands_left_after_1st.reject do |who|
      who[/(^#{@answer1}$|^#{@answer2}$)/i]
    end

    if @band_goes_3rd.empty?
      puts "The #{answer.split.map(&:capitalize).first} Band is not available, please choose from these #{@bands_left_after_2nd.size}:"
    else
      puts "Great choice! The #{@band_goes_3rd.first} Band will HEADLINE the show!"
      third_choice_selected = true
    end
  end
end

def third_choice_no(names)
  puts "What band is going to HEADLINE?"
  @user_creates = gets.chomp.split.map(&:capitalize).first
  puts "Great choice, #{@user_creates} will HEADLINE the show!"
end

def last_question(names)
  puts "Would you like to view your lineup? Yes or no?"
  last_question_selected = false
  until last_question_selected do
    answer = gets.chomp.downcase.strip
    if answer == "yes"
      last_question_yes(names)
      last_question_selected = true
    elsif answer == "no"
      last_question_no(names)
      last_question_selected = true
    else
      puts "Please enter yes or no."
      last_question_selected = false
    end
  end
end

def last_question_yes(names)
  puts "The #{@band_goes_1st.first} Band will open with a 20 minute set."
  puts "The #{@band_goes_2nd.first} Band will go next with a 30 minute set"
  puts "The #{@user_creates} Band is you HEADLINER! They have a full hour!"
end

def last_question_no(names)
  puts "Why not?!"
  answer = gets.chomp.strip
  puts "That's a great reason! Let's take a look anyway."
  last_question_yes(names)
end

start(names)
