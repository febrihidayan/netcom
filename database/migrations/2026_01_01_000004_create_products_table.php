<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('product_category_name')->nullable();
            $table->integer('product_name_length')->nullable();
            $table->integer('product_description_length')->nullable();
            $table->integer('product_photos_qty')->nullable();
            $table->decimal('product_weight_g', 10, 2)->nullable();
            $table->decimal('product_length_cm', 10, 2)->nullable();
            $table->decimal('product_height_cm', 10, 2)->nullable();
            $table->decimal('product_width_cm', 10, 2)->nullable();
            $table->timestamps();

            $table->foreign('product_category_name')
                ->references('product_category_name')
                ->on('product_category_translations')
                ->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};