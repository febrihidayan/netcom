<?php

namespace Database\Factories;

use App\Models\Customer;
use App\Models\Order;
use Illuminate\Database\Eloquent\Factories\Factory;

class OrderFactory extends Factory
{
    protected $model = Order::class;

    public function definition(): array
    {
        return [
            'customer_id' => Customer::factory(),
            'order_status' => $this->faker->randomElement(['pending', 'approved', 'shipped', 'delivered', 'canceled']),
            'order_purchase_timestamp' => $this->faker->dateTimeBetween('-1 year', 'now'),
            'order_approved_at' => $this->faker->optional()->dateTimeBetween('-1 year', 'now'),
            'order_delivered_carrier_date' => $this->faker->optional()->dateTimeBetween('-1 year', 'now'),
            'order_delivered_customer_date' => $this->faker->optional()->dateTimeBetween('-1 year', 'now'),
            'order_estimated_delivery_date' => $this->faker->dateTimeBetween('now', '+1 month'),
        ];
    }
}