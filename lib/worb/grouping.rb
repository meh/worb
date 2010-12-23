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

class Grouping < Array
  attr_reader :language, :klass

  def initialize (language, klass)
    @language  = language
    @klass     = klass
    @data      = {}
  end

  def do (*args, &block)
    self.instance_exec(self, args, &block) if block
  end

  alias __push push
  def push (value)
    unless value.is_a?(@klass)
      raise ArgumentError.new("You can push only instances of #{@klass}")
    end

    __push(value)
  end
  alias << push

  def inherit (klass, &block)
    @language.instance_variable_get(:@groupings)[klass].each {|instance|
      self.instance_exec(instance, &block)
    }
  end

  def method_missing (id, *args, &block)
    if "Worb::Language::#{id.to_s.capitalize}" == @klass.name
      self.push(@klass.new(self, *args, &block))
      self.last.data.merge!(@data.merge(self.last.data))
    elsif @klass.respond_to? id
      @klass.send(id, *args, &block)
    else
      @data[id] = args.first
      self.do(*args, &block)
      @data.delete(id)
    end
  end
end

end
