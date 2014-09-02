require 'mongo'
puts "Database connection"
db = Mongo::Connection.new("localhost", 27017).db("mydb")
puts "Create and use new collection"
coll    = db.collection("students")
puts "Insert the record within the collection"
doc1 = {"name" => "MongoDB", "type" => "database", "count" => 1, "info" => {"x" => 203, "y" => '102'}, "array" => [1, 2, 3, 4]}
id = coll.insert(doc1)
doc2 = {"name" => "MongoDB", "type" => "database", "count" => 2, "info" => {"x" => 203, "y" => '102'}}
id = coll.insert(doc2)
puts "Find the single record"
puts coll.find_one
puts "Find all the record"
coll.find.each { |row| puts row.inspect }
puts "Specific query with id #{doc2[:_id]}"
puts coll.find("_id" => doc2[:_id]).to_a
puts "Sorting the documents: acending"
coll.find.sort(:count).each { |row| puts row.inspect }
puts "Sorting the documents: descending"
coll.find.sort(:count => :desc).each { |row| puts row.inspect }
puts "Counting document in array"
puts coll.count
puts "Update the collection"
coll.update({"_id" => doc2[:_id]}, {"$set" => {"name" => "MongoDB Ruby"}})
coll.find.each { |row| puts row.inspect }
puts "Selecting the specific fields"
puts coll.find_one( :fields => ["name", "type"]).to_a
puts "Delete specific document"
coll.remove("_id" => doc2[:_id])
coll.find.each { |row| puts row.inspect }
puts "Delete the collection"
coll.remove