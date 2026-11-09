<?php

namespace Database\Factories;

use App\Models\ProductCategoryTranslation;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProductCategoryTranslationFactory extends Factory
{
    protected $model = ProductCategoryTranslation::class;

    public function definition(): array
    {
        $name = $this->faker->unique()->word();

        return [
            'product_category_name' => $name,
            'product_category_name_english' => ucfirst($name),
        ];
    }
}