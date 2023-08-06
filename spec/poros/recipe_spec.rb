require 'rails_helper'

RSpec.describe Recipe do
  before(:each) do
    recipe_info = File.read("spec/fixtures/recipes/one_recipe.json")
    params = JSON.parse(recipe_info, symbolize_names: true)
    @recipe = Recipe.new(params, 'lithuania')
  end

  describe 'initialize' do 
    it 'exists' do 
      expect(@recipe).to be_a Recipe
    end

    it 'has attributes' do 
      expect(@recipe.title).to eq("Ukrainian Grain Pudding")
      expect(@recipe.url).to eq("https://www.epicurious.com/recipes/food/views/ukrainian-grain-pudding-236736")
      expect(@recipe.image).to eq("https://edamam-product-images.s3.amazonaws.com/web-img/ad1/ad18e2657c9af89df684a7e9c5f9b3ab.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEKb%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCICV1jqPDm3EXA1OJmETN%2FqOkroKanrvBo83v18yssP9tAiBJSof4GMDaFGiVSYE6BGeAA6r%2BckSMfc7FZLlVSwqPeiq5BQhPEAAaDDE4NzAxNzE1MDk4NiIM0%2BvoUjPa3cxBs7dQKpYFOh3VpRsJ5h%2BgOIR0z6tCQk%2FJz6O2xhgBcduIlXS6%2B5rFsG8r026czJ38sc5kSra%2BU%2BVxl6eoussFYS7S7hXlq4LOBCekKcQv3HmnuqI9%2Bhu7Y3zT9dCYkWDrQkOkx0NdEyVEq6yVWBn6r6A6S0d5FWhHl76s6NTtSLF5MJbYCstHh1RrSbiMjUtRidt13Bu5es3aXNRyn2dDYR%2BenpcOn8l30BXqMmg979RAzZX69OcviHyzRzrPBIfYE3gZtjbO29f6ArtAritqyjVe9uJqJJUgR966AJVE5DONoGvEj7Gp4rH15hNOs%2FcPIUR0Fon6MEHdIPvGPtS9o6eQyhGuoKt7eTmvfnw2Wk9weIdVEDSAQEMWANCCnfuEkgNkirjWlrIXVxq%2B6pNZsTQ4o0BW%2BT3%2Fj%2F010CLj8xomZ%2BzAnUPwRtZTO1jw1EtzcQkc%2BUokDbEp9aWlOPBCDRle00Mxb6%2FuqBLo4il5R1W8F5Gqkjuc4qCVqp4Pw27Dvs3rFAsb%2FaD%2B3H9Bee%2FjcaAZeBG3%2BAAbkx%2Ft2rCHgiWACtZ0%2BYk6Un1nUDm7iQtFV8WBH44rmjC%2B16VmXP00TAQkXoStJPxQ8u26I5UafFZ6cX3I19F%2FvQwk5RfK8BnfgBLL3Qq9GrNuM7rf0WjyV1gcc95vG9ctzzbizYOkPqjD%2BQlWldvL0EpbkuFlUX9KG3LLMfi519wM1hIsGC3ppyNh7z9ygK8aseHA9PM7jeM7nvgkCCz6EdYgHh2H78Lymf88YBLYzZONhRZumWbX9CgXdTLxgH%2FN%2FGJmhGP5BEReg1ClzLiqNR%2FBoS9d56sp%2BuYJkFQ2JuoxFbSgn6FlJvcZgqYaIj8pTmf9PCrPoTtt6piVKgu5rrGwMxIwgYi7pgY6sgGTXXfTgmFLB3KA6RZZVP%2FGf%2FKy6xIJR3Ooiw9QcGHksLTkFKjkurGCE8pal9mhTna8K4qh6747A9C6tlDfFeyO2zH%2FSPKaXy%2BTWkqfZqOQKXICSs2OGXZaMalCdPpVFZBDbgBZ9OT1NjmMDbqvCuHlZLDCPcOoUetzyI8Y7SijP9nVEGe9kcDzpvO4N1kTuFPiSAYaCrwoenN39A%2BpcwwNJfAY5oAMHFDupQLHpTY%2BQv2D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230805T231650Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFBRFNXPWR%2F20230805%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=db808257c2f8603eaa199bfa340623f0325ca4b7ffe0d8aed795983f7484417e")
      expect(@recipe.country).to eq('Lithuania')
    end
  end
end