module Where

  def where(search_params)
    for i in (0...self.length) do
      @pos = self[i]
      if !(@pos.select { |key,value| search_params[key] == value }).empty?
        return [@pos]
      end
    end
  end

end

class Array
  include Where
end
