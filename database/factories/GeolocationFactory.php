<?php

namespace Database\Factories;

use App\Models\Geolocation;
use Illuminate\Database\Eloquent\Factories\Factory;

class GeolocationFactory extends Factory
{
    protected $model = Geolocation::class;

    public function definition(): array
    {
        return [
            'geolocation_zip_code_prefix' => $this->faker->unique()->postcode(),
            'geolocation_lat' => $this->faker->latitude(),
            'geolocation_lng' => $this->faker->longitude(),
            'geolocation_city' => $this->faker->city(),
            'geolocation_state' => $this->faker->stateAbbr(),
        ];
    }
}