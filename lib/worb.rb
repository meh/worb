#--
# Copyleft meh. [http://meh.doesntexist.org | meh@paranoici.org]
#
# This file is part of worb.
#
# worb is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# worb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with worb. If not, see <http://www.gnu.org/licenses/>.
#++

module Worb
  def self.debug (argument, options={})
    if !ENV['DEBUG'] && !options[:force]
      return
    end

    if ENV['DEBUG'].to_i < (options[:level] || 1) && !options[:force]
      return
    end

    output = "[#{Time.new}] From: #{caller[0, options[:deep] || 1].join("\n")}\n"

    if argument.is_a?(Exception)
      output << "#{argument.class}: #{argument.message}\n"
      output << argument.backtrace.collect {|stack|
        stack
      }.join("\n")
      output << "\n\n"
    elsif argument.is_a?(String)
      output << "#{argument}\n"
    else
      output << "#{argument.inspect}\n"
    end

    if options[:separator]
      output << options[:separator]
    end

    puts output
  end
end
