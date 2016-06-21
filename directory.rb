def interactive_menu
  students = []
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "I dont know what you meant, please try again"
    end
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit the return twice"
  #create an empty array
  students = []
  #get the first name
  name = gets.rstrip! #rstrip! used instead of .chomp exercise 8.10

  #while the name is not empty, repeat this code
  while !name.empty? do
    default = 'TBC' #set default value if no value is entered
    puts "Please enter the student's hobby"
    hobby = gets.chomp
    if hobby.empty?
      hobby = default
    end
    puts "Please enter the student's height"
    height = gets.chomp
    if height.empty?
      height = default
    end
    puts "Please enter the student's country of birth"
    cob = gets.chomp
    if cob.empty?
      cob = default
    end
    puts "Please enter the student's cohort month"
    cohort = gets.chomp
    if cohort.empty?
      cohort = default
    end
    students << {name: name, hobby: hobby, height: height, cob: cob, cohort: cohort}
    if students.count < 2
      puts "Now we have #{students.count} student"
      else
      puts "Now we have #{students.count} students"
    end
    #get another name from the user
    puts "Please enter the name of the next student"
    puts "To finish, just hit the return twice"
    name = gets.chomp
  end

  #return the array of students
   students
end

$line_width = 100

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "__________".center($line_width)
end


def sort_month(students)
  grouped = students.group_by {|student|  student[:cohort].to_sym}
  grouped.each do |month, pupil|
  puts "Students in #{month}.".center($line_width)
  pupil.each do |info|
    puts "#{info[:name]}".center($line_width)
  end
end
end


def print(students)
  puts "Full list of students
  ".center($line_width)
  students.each_with_index do |student, idx|
    puts "#{idx + 1}. #{student[:name]} #{student[:hobby]} #{student[:height]} #{student[:cob]} (#{student[:cohort]} cohort)".center($line_width)
  end
  puts "
  "
end


=begin 'while' print student method to replace .each mehtod from above, as per exercise 8.4
def print(students)
  counter =  0
  while counter < students.length
    puts "#{students[counter][:name]} (#{students[counter][:cohort]} cohort)"
    counter = counter + 1
  end

end
=end

def print_footer(student)
  if student.count < 2
    puts "Overall, we have #{student.count} great student".center($line_width)
    else
    puts "Overall, we have #{student.count} great students".center($line_width)
  end
  puts "
  "
end

def first_letter_filter(students)
  puts "Enter the first letter of the students' name"
  firstl = gets.chomp.downcase
  students.each_with_index do |student, idx|
    if firstl == student[:name][0].downcase
      puts "#{idx + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def shorter_than(students)
  students.each_with_index do |student, idx|
    if student[:name].length < 12
      puts "#{idx + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

#nothing happens until we call the methods
interactive_menu
#students = input_students
#print_header
#print(students)
#print_footer(students)
#sort_month(students)
#shorter_than(students)

=begin
puts "Would you like to filter the list by first letter?"
answer = gets.chomp.downcase
if answer == 'yes'
  first_letter_filter(students)
end
=end
