#---
# Excerpted from "Seven Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btlang for more book information.
#---

class CsvRow
  def initialize(headers, data)
    @headers = headers
    @data = data
  end

  def method_missing(name, *args)
    index = @headers.index(name.to_s)
    @data[index] if index
  end
end

module ActsAsCsv

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods

    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << CsvRow.new(@headers, row.chomp.split(', '))
      end
    end

    attr_accessor :headers, :csv_contents

    def initialize
      read
    end

    def each(&block)
      return @csv_contents.each(&block)
    end

  end

end

class RubyCsv  # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect

puts
puts "testing each method"
m.each {|r| puts r.inspect}

puts
puts "testing method missing features"
m.each {|r| puts r.name}
m.each {|r| puts r.location}
