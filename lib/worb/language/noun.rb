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

module Worb; class Language

class Noun < Concept
  @@inflections = []

  def self.inflection (&block)
    @@inflections << block
  end

  def initialize (grouping, name, data={})
    super(grouping, name, data)
  end

  def inflection? (text)
    result = nil

    (@@inflections + (data[:inflections] || [])).find {|inflection|
      result = self.instance_exec(text, &inflection)
    }

    result
  end

  def is? (text)
    !!(text == self.name || inflection?(text))
  end

  def to_s
    result = self.name.clone

    if data[:plural]
      if result.end_with?('y')
        result[-1] = 'ies'
      else
        result << 's'
      end
    end

    result
  end
end

end; end
