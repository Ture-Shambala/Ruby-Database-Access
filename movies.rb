require 'pg'
require 'pry'

begin
  con = PG.connect :dbname => 'ruby_sample', :user => 'postgres', :password => 'root'
  # con.exec "Create table Movie(Id SERIAL PRIMARY KEY, Name VARCHAR(20), Year_Release INT)"
  # # con.exec "CREATE SEQUENCE movies_id;"
  # # con.exec "CREATE TABLE movie ( id integer NOT NULL DEFAULT nextval('movies_id') )"
  # # con.exec "ALTER TABLE movie ALTER id SET DEFAULT NEXTVAL('movies_id')"
  # con.exec "INSERT INTO Movies VALUES(1,'DDLJ',1995)"
  # con.exec "INSERT INTO Movies VALUES(2,'K3G',2001)"
  # con.exec "INSERT INTO Movies VALUES(3,'DHOOM2',2006)"
  # con.exec "INSERT INTO Movies VALUES(4,'KRISH',2006)"
  # con.exec "INSERT INTO Movies VALUES(5,'PK',2014)"
  p "Select following digit"
  p "1 : Show all movies"
  p "2 : Add new movie"
  p "3 : Exit"
  digit = gets.chomp

  case digit
    when "1"
      movies = con.exec "Select * from movies;"
      p "All Movies List"
      p "Id | Name | Year_Release"
      movies.each do |movie|
        p "#{movie['id']} | #{movie['name']} | #{movie['year_release']}"
      end
    when "2"
      p "Please enter name of movie"
      mv_name = gets.chomp
      p "Please enter release year of movie"
      year = gets.chomp
      con.exec "INSERT INTO Movies (name, year_release) VALUES ('#{mv_name}',#{year.to_i})"
      # p "New record is"
      # new_record = con.exec "select * from movies ORDER BY id DESC LIMIT 1"
      # p new_record
    when "3"
    else
      p "Thank you"
  end


rescue PG::Error => e
  puts e.message 
ensure
  con.close if con
end