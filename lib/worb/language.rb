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

#--
# nouns, verbs, adjectives, adverbs, articles, conjunctions, prepositions, punctuations
#++

require 'worb'
require 'worb/languages'
require 'worb/grouping'
require 'worb/language/concept'

module Worb

class Language
  def self.define (name, data={}, &block)
    if Languages[name]
      Languages[name].do(data, &block)
    else
      Language.new(name, data, &block)
    end
  end

  def self.load (what)
    require "worb/languages/#{what}"
  end

  attr_reader :name, :symbol

  def initialize (name, data={}, &block)
    @name      = name
    @symbol    = data[:symbol] || name[0, 2].downcase.to_sym
    @groupings = {}

    Languages[@name] = Languages[@symbol] = self

    self.do(data, &block) if block
  end

  def do (data={}, &block)
    (data[:use] || []).push(Concept).uniq.each {|klass|
      @groupings[klass] ||= Grouping.new(self, klass)
    }

    self.instance_exec(self, data, &block)
    self
  end

  alias __method_missing method_missing

  def method_missing (id, *args, &block)
    if grouping = @groupings.find {|(klass, grouping)| klass.name == "Worb::Language::#{id.to_s.capitalize.sub(/s$/, '')}" }.last rescue nil
      if block
        grouping.do(*args, &block)
      else
        grouping
      end
    else
      __method_missing(id, *args, &block)
    end
  end
end

end
