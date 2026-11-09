<?php

namespace Database\Factories;

use App\Models\Order;
use App\Models\OrderPayment;
use Illuminate\Database\Eloquent\Factories\Factory;

class OrderPaymentFactory extends Factory
{
    protected $model = OrderPayment::class;

    public function definition(): array
    {
        return [
            'order_id' => Order::factory(),
            'payment_sequential' => $this->faker->numberBetween(1, 3),
            'payment_type' => $this->faker->randomElement(['credit_card', 'boleto', 'voucher', 'debit_card']),
            'payment_installments' => $this->faker->numberBetween(1, 12),
            'payment_value' => $this->faker->randomFloat(2, 10, 1000),
        ];
    }
}