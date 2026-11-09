<?php

namespace Database\Factories;

use App\Models\Product;
use App\Models\ProductCategoryTranslation;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProductFactory extends Factory
{
    protected $model = Product::class;

    public function definition(): array
    {
        return [
            'product_category_name' => ProductCategoryTranslation::factory(),
            'product_name_length' => $this->faker->numberBetween(5, 50),
            'product_description_length' => $this->faker->numberBetween(10, 200),
            'product_photos_qty' => $this->faker->numberBetween(1, 5),
            'product_weight_g' => $this->faker->randomFloat(2, 100, 5000),
            'product_length_cm' => $this->faker->randomFloat(2, 5, 100),
            'product_height_cm' => $this->faker->randomFloat(2, 5, 100),
            'product_width_cm' => $this->faker->randomFloat(2, 5, 100),
        ];
    }
}