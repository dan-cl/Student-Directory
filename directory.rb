@students = []
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I dont know what you meant, please try again"
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students <<{name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit the return twice"
  #get the first name
  name = STDIN.gets.rstrip! #rstrip! used instead of .chomp exercise 8.10
  #while the name is not empty, repeat this code
  while !name.empty? do
    default = 'TBC' #set default value if no value is entered
    puts "Please enter the student's hobby"
    hobby = STDIN.gets.chomp
    if hobby.empty?
      hobby = default
    end
    puts "Please enter the student's height"
    height = STDIN.gets.chomp
    if height.empty?
      height = default
    end
    puts "Please enter the student's country of birth"
    cob = STDIN.gets.chomp
    if cob.empty?
      cob = default
    end
    puts "Please enter the student's cohort month"
    cohort = STDIN.gets.chomp
    if cohort.empty?
      cohort = default
    end
    @students << {name: name, hobby: hobby, height: height, cob: cob, cohort: cohort}
    if @students.count < 2
      puts "Now we have #{@students.count} student"
      else
      puts "Now we have #{@students.count} students"
    end
    #get another name from the user
    puts "Please enter the name of the next student"
    puts "To finish, just hit the return twice"
    name = STDIN.gets.chomp
  end
end

$line_width = 100

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "__________".center($line_width)
end


def sort_month
  grouped = @students.group_by {|student|  student[:cohort].to_sym}
  grouped.each do |month, pupil|
  puts "Students in #{month}.".center($line_width)
  pupil.each do |info|
    puts "#{info[:name]}".center($line_width)
  end
end
end


def print_students_list
  puts "Full list of students
  ".center($line_width)
  @students.each_with_index do |student, idx|
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

def print_footer
  if @students.count < 2
    puts "Overall, we have #{@students.count} great student".center($line_width)
    else
    puts "Overall, we have #{@students.count} great students".center($line_width)
  end
  puts "
  "
end

def first_letter_filter
  puts "Enter the first letter of the students' name"
  firstl = gets.chomp.downcase
  @students.each_with_index do |student, idx|
    if firstl == student[:name][0].downcase
      puts "#{idx + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def shorter_than
  @students.each_with_index do |student, idx|
    if student[:name].length < 12
      puts "#{idx + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

#nothing happens until we call the methods
try_load_students
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
