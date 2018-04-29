module Where

  def where(search_params)

    # iterate through given array of hashes
    for i in (0...self.length) do
      # declare variables
      @position = self[i]
      @value = search_params.values[0]

      # find match with Regexp as argument
      if @value.class == Regexp
        if (@position.select { |key,value| @value.match(key) })
          return [@position]
        end

      else
        # find exact match with one argument
        if !(@position.select { |key,value| search_params[key] == value }).empty?
          return [@position]
        end
      end
    end
  end

end

class Array
  include Where
end
