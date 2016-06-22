@students = []
@last_save = 0
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts
  puts "---------------------------------".center($line_width)
  puts "Student Directory Menu".center($line_width)
  puts "---------------------------------".center($line_width)
  puts "1. Input the students".center($line_width)
  puts "2. Show the students".center($line_width)
  puts "3. Save".center($line_width)
  puts "4. Save as...".center($line_width)
  puts "5. Load the list from students.csv".center($line_width)
  puts "6. Filter student list by letter".center($line_width)
  puts "9. Exit".center($line_width)
  puts "---------------------------------".center($line_width)
  puts
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
    save_as
  when "5"
    load_students
  when "6"
    first_letter_filter
  when "9"
    exit
  else
    puts "I dont know what you meant, please try again"
  end
end

def save_students
  if @last_save == 0
    save_as
    return
  else
    file = File.open("#{@last_save}.csv", "w")
    @students.each do |student|
    student_data = [student[:name], student[:hobby], student[:height], student[:cob], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
    end
  end
  puts
  puts "File saved".center($line_width)
  puts
  file.close
end

def save_as
  puts "Please enter filename"
  filename = gets.chomp
  puts
  file = File.open("#{filename}.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:hobby], student[:height], student[:cob], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  @last_save = filename
  puts
  puts "File saved as #{@last_save}.csv".center($line_width)
  puts
  file.close
end

def load_students
  puts
  puts "Please enter filename to open".center($line_width)
  puts
  filename = gets.chomp
  file = File.open("#{filename}.csv", "r")
  file.readlines.each do |line|
    name, hobby, height, cob, cohort = line.chomp.split(',')
    @students <<{name: name, hobby: hobby, height: height, cob: cob, cohort: cohort.to_sym}
  end
  puts
  puts "#{filename}.csv opened".center($line_width)
  puts
  @last_save = filename
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "loaded #{@students.count} from #{filename}".center($line_width)
  else
    puts "Sorry, #{filename} doesn't exist".center($line_width)
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
  puts "---------------------------------".center($line_width)
  puts "The students of Villains Academy".center($line_width)
  puts "---------------------------------".center($line_width)
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
    puts "---------------------------------".center($line_width)
    puts "Overall, we have #{@students.count} great student".center($line_width)
    else
    puts "---------------------------------".center($line_width)
    puts "Overall, we have #{@students.count} great students".center($line_width)
  end
  puts "
  "
end

def first_letter_filter
  puts
  puts "Enter the first letter of the students' name"
  firstl = gets.chomp.downcase
  puts
  puts "Students starting with '#{firstl}'".center($line_width)
  puts "---------------------------------".center($line_width)
  @students.each_with_index do |student, idx|
    if firstl == student[:name][0].downcase
      puts "#{idx + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center($line_width)
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
