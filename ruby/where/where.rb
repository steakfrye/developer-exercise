module Where

  def where(search_params)

    # declare variables
    found = Array.new
    input = self

    # iterate through each argument
    for j in (0...search_params.length) do
      key = search_params.keys[j]
      value = search_params.values[j]

      # if multiple arguments are given, make sure output matches all criteria
      if j > 0
        input = found
        found = []
      end

      # iterate through given array of hashes
      for i in (0...input.length) do
        position = input[i]

        # find match with Regexp as argument
        if value.class == Regexp
          symbols = position.find_all { |key,value| search_params[key] }
          # symbols variable returns array of arrays, therefore we need to visit 0 index (symbols[0].select)
          if (symbols[0].select { |n| n.match(value) }).any?
            found.push(position)
          end

        else
          # find exact match
          if not (position.select { |key,value| search_params[key] == value }).empty?
            found.push(position)
          end
        end
      end
    end
    # return the found results!
    return found
  end
end

class Array
  include Where
end
