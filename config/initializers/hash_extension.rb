class Hash
  def underscore
    def underscore_obj(obj)
      case obj
        when Hash
          Hash[obj.map { |k,v| [k.underscore, underscore_obj(v)] }]
        when Array
          obj.map { |v| underscore_obj(v) }
        else
          obj
      end
    end

    underscore_obj self
  end

  def camelize(first_letter=:upper)
    def camelize_obj(obj, first_letter)
      case obj
        when Hash
          Hash[obj.map { |k,v| [k.to_s.camelize(first_letter), camelize_obj(v, first_letter)] }]
        when Array
          obj.map { |v| camelize_obj(v, first_letter) }
        else
          obj
      end
    end

    camelize_obj self, first_letter
  end
end