<?php

namespace Database\Factories;

use App\Models\Customer;
use App\Models\Geolocation;
use Illuminate\Database\Eloquent\Factories\Factory;

class CustomerFactory extends Factory
{
    protected $model = Customer::class;

    public function definition(): array
    {
        return [
            'customer_name' => $this->faker->name(),
            'customer_zip_code_prefix' => Geolocation::factory(),
            'customer_city' => $this->faker->city(),
            'customer_state' => $this->faker->stateAbbr(),
        ];
    }
}