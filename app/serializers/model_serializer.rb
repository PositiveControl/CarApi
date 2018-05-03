class ModelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :model_title, :make_id
end