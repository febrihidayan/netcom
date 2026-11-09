<?php

namespace Database\Factories;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Models\Seller;
use Illuminate\Database\Eloquent\Factories\Factory;

class OrderItemFactory extends Factory
{
    protected $model = OrderItem::class;

    public function definition(): array
    {
        return [
            'order_id' => Order::factory(),
            'order_item_id' => $this->faker->numberBetween(1, 5),
            'product_id' => Product::factory(),
            'seller_id' => Seller::factory(),
            'shipping_limit_date' => $this->faker->dateTimeBetween('now', '+1 month'),
            'price' => $this->faker->randomFloat(2, 10, 500),
            'freight_value' => $this->faker->randomFloat(2, 5, 50),
        ];
    }
}