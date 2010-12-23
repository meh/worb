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

require 'worb/language/noun'
require 'worb/language/verb'

module Worb; class Language

Language.define 'English', :use => [Noun, Verb] do
  concepts {
    level :common do
      concept 'dog'
      concept 'party'
    end
  }

  nouns {
    inherit Concept do |concept|
      noun concept.name, concept.data
    end

    # Plural words
    inflection do |text|
      if (text.end_with?('ies') && self.name == text.sub(/ies$/, 'y')) || (text.end_with?('s') && self.name == text.sub(/s$/, ''))
        result = self.clone
        result.data[:plural] = true
        result
      end
    end
  }
end

end; end
