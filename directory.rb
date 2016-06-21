def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit the return twice"
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    #get another name from the user
    name = gets.chomp
  end

  #return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "__________"
end

=begin Previous method for printing students name. Replaced with 'While' print(students)
method below.
def print(students)
  students.each_with_index do |student, idx|
    puts "#{idx + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end
=end

#'while' print student method to replace .each mehtod from above, as per exercise 8.4
def print(students)
  counter =  0
  while counter < students.length
    puts "#{students[counter][:name]} (#{students[counter][:cohort]} cohort)"
    counter = counter + 1
  end

end

def print_footer(student)
  puts "Overall, we have #{student.count} great students"
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

students = input_students
print_header
print(students)
print_footer(students)
#shorter_than(students)

puts "Would you like to filter the list by first letter?"
answer = gets.chomp.downcase
if answer == 'yes'
  first_letter_filter(students)
end
