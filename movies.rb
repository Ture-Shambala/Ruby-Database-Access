require 'pg'
require 'pry'

begin
  con = PG.connect :dbname => 'ruby_sample', :user => 'postgres', :password => 'root'
  # con.exec "Create table Movies(Id INT PRIMARY KEY, Name VARCHAR(20), Year_Release INT)"
  # con.exec "INSERT INTO Movies VALUES(1,'DDLJ',1995)"
  # con.exec "INSERT INTO Movies VALUES(2,'K3G',2001)"
  # con.exec "INSERT INTO Movies VALUES(3,'DHOOM2',2006)"
  # con.exec "INSERT INTO Movies VALUES(4,'KRISH',2006)"
  # con.exec "INSERT INTO Movies VALUES(5,'PK',2014)"
  p "Select following digit"
  p "1 : Show all movies"
  # p "2 : Add new movie"
  p "3 : Exit"
  digit = gets.chomp

  case digit
    when "1"
      a = con.exec "Select * from movies;"
      p "All Movies List"
      p "Id | Name | Year_Release"
      a.each do |movie|
        p "#{movie['id']} | #{movie['name']} | #{movie['year_release']}"
      end
    # when "2"

    when "3"
    else
      p "Thank you"
  end


rescue PG::Error => e
  puts e.message 
ensure
  con.close if con
end