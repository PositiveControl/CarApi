class OptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
end