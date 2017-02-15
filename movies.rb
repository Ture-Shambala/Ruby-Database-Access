require 'pg'
require 'pry'


def select_choice
  puts "=============Select your choice============="
  p "1 : Show all movies records"
  p "2 : Add new movie record"
  p "3 : Remove particular record"
  p "4 : Exit"
  puts "============================================"
  digit=gets.chomp
  db_connect(digit)
  # hash_store(choice)
end

def all_records
  @con = PG.connect :dbname => 'ruby_sample', :user => 'postgres', :password => 'root'
  movies = @con.exec "Select * from movies;"
  p "All Movies List"
  p "Id | Name | Year_Release"
  movies.each do |movie|
    p "#{movie['id']} | #{movie['name']} | #{movie['year_release']}"
  end
end

def db_connect(digit)
  begin
    case digit
      when "1"
        all_records
        select_choice
      when "2"
        p "Please enter name of movie"
        mv_name = gets.chomp
        p "Please enter release year of movie"
        year = gets.chomp
        @con.exec "INSERT INTO Movies (name, year_release) VALUES ('#{mv_name}',#{year.to_i})"
        p "New record added successfully"
        all_records
        select_choice
      when "3"
        p "Please enter either name nor year_release of particular movie that you want's to remove"
        remove_record = gets.chomp
        @con.exec "delete from movies where name = '#{remove_record}' OR year_release = #{remove_record}"
        p "Remove single record successfully"
        all_records
        select_choice
      else
        p "Thank you"
    end
  rescue PG::Error => e
    puts e.message 
  # ensure
  #   @con.close if @con
  end
end
select_choice