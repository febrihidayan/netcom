<?php

namespace Database\Factories;

use App\Models\Order;
use App\Models\OrderReview;
use Illuminate\Database\Eloquent\Factories\Factory;

class OrderReviewFactory extends Factory
{
    protected $model = OrderReview::class;

    public function definition(): array
    {
        return [
            'order_id' => Order::factory(),
            'review_score' => $this->faker->numberBetween(1, 5),
            'review_comment_title' => $this->faker->optional()->sentence(3),
            'review_comment_message' => $this->faker->optional()->paragraph(),
            'review_creation_date' => $this->faker->dateTimeBetween('-1 year', 'now'),
            'review_answer_timestamp' => $this->faker->optional()->dateTimeBetween('-1 year', 'now'),
        ];
    }
}