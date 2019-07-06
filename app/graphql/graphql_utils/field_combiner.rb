class GraphQLUtils::FieldCombiner
  def self.combine(query_types)
    Array(query_types).each_with_object({}) do |query_type, hash|
      hash.merge!(query_type.fields)
    end
  end
end
