# -*- coding:utf-8 -*-

class CsvRow
  def initialize(header, row)
    @header = header.map{|x| x.strip}
    @row = row.map{|x| x. strip}
  end

  def method_missing name, *args
    namest =  name.to_s
    ret = nil
    @header.zip(@row) do |x, y|
      if namest == x then
        ret = y
        break
      end
    end
    super if ret.nil?
    ret
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

    module InstanceMethods
      def read
        @csv_contents = []
        filename = self.class.to_s.downcase + '.txt'
        File::open(filename) do |f|
          @headers = f.gets.chomp.split(",")
          f.each do |row|
            @csv_contents << CsvRow::new(@headers, row.chomp.split(","))
          end
        end
      end

      def each(&block)
        @csv_contents.each &block
      end

      attr_accessor :headers, :csv_contents

      def initialize
        read
      end
    end
  end
end


class RubyCsv
  include ActsAsCsv
  acts_as_csv
end

m = RubyCsv::new
m.each{|row| puts row.one}
m.each{|row| puts row.two}
m.each{|row| puts row.teeeee}
