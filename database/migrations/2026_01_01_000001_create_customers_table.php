<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('customers', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('customer_name')->nullable();
            $table->string('customer_zip_code_prefix')->nullable();
            $table->string('customer_city')->nullable();
            $table->string('customer_state', 10)->nullable();
            $table->timestamps();

            $table->foreign('customer_zip_code_prefix')
                ->references('geolocation_zip_code_prefix')
                ->on('geolocations')
                ->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('customers');
    }
};