<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('customers', function (Blueprint $table) {
            $table->index('customer_zip_code_prefix');
            $table->index('customer_city');
        });

        Schema::table('sellers', function (Blueprint $table) {
            $table->index('seller_city');
            $table->index('seller_state');
        });

        Schema::table('products', function (Blueprint $table) {
            $table->index('product_category_name');
        });

        Schema::table('orders', function (Blueprint $table) {
            $table->index('customer_id');
            $table->index('order_status');
            $table->index('order_purchase_timestamp');
        });

        Schema::table('order_items', function (Blueprint $table) {
            $table->index('order_id');
            $table->index('product_id');
            $table->index('seller_id');
        });

        Schema::table('order_payments', function (Blueprint $table) {
            $table->index('order_id');
            $table->index('payment_type');
        });

        Schema::table('order_reviews', function (Blueprint $table) {
            $table->index('order_id');
        });
    }

    public function down(): void
    {
        // noop
    }
};
