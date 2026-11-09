<?php

namespace Database\Seeders;

use App\Models\Customer;
use App\Models\Geolocation;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\OrderPayment;
use App\Models\OrderReview;
use App\Models\Product;
use App\Models\ProductCategoryTranslation;
use App\Models\Seller;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    public function run(): void
    {
        User::factory()->create([
            'name' => 'Test Admin',
            'email' => 'admin@app.com',
            'password' => 'password',
        ]);

        Geolocation::factory(20)->create();
        Customer::factory(50)->create();
        Seller::factory(20)->create();
        ProductCategoryTranslation::factory(10)->create();
        Product::factory(50)->create();
        Order::factory(30)->create();
        OrderItem::factory(60)->create();
        OrderPayment::factory(30)->create();
        OrderReview::factory(20)->create();
    }
}