<?php

namespace Database\Factories;

use App\Models\Seller;
use Illuminate\Database\Eloquent\Factories\Factory;

class SellerFactory extends Factory
{
    protected $model = Seller::class;

    public function definition(): array
    {
        return [
            'seller_zip_code_prefix' => $this->faker->postcode(),
            'seller_city' => $this->faker->city(),
            'seller_state' => $this->faker->stateAbbr(),
        ];
    }
}